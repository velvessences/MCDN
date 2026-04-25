const express = require('express');
const path = require('path');
const cors = require('cors')
const fs = require('fs');
const libamf = require('libamf');
const nodeamf = require('@jadbalout/nodeamf');
const app = express();
const PORT = 1600;

app.use(cors());

app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', 'http://127.0.0.1:5500');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, x-requested-with');
    res.setHeader('Access-Control-Allow-Credentials', 'true');
    if (req.method === 'OPTIONS') return res.sendStatus(200);
    next();
});

app.use((req, res, next) => {
    console.log(`[GAME REQUESTED]: ${req.method} ${req.url}`);
    next();
});

// 1. Cross-Domain Policy
app.get('/crossdomain.xml', (req, res) => {
    res.type('text/xml');
    res.send(`<?xml version=\"1.0\"?><cross-domain-policy><allow-access-from domain=\"*\" to-ports=\"*\" /></cross-domain-policy>`);
});

// ─── AMF0 PACKET PARSER ───────────────────────────────────────────────────────
// Reads the raw AMF0 remoting envelope and extracts:
//   • responseId  – e.g. \"/1\", \"/2\"  (used to build the reply target URI)
//   • methodName  – e.g. \"UserService.GetAppSettings\"
//
// AMF0 Remoting envelope layout:
//   [0-1]  version   (0x00 0x00)
//   [2-3]  header count
//   [4-5]  message count
//   then per-message:
//     [2]  target-uri length  (uint16BE)
//     [n]  target-uri string
//     [2]  response-uri length (uint16BE)
//     [n]  response-uri string  ← this is the responseId Flash gave us
//     [4]  body length (int32BE, -1 = unknown)
//     [n]  AMF0/3 body
function parseAMF0Envelope(buf) {
    try {
        let offset = 0;

        const version = buf.readUInt16BE(offset); offset += 2; // should be 0
        const headerCount = buf.readUInt16BE(offset); offset += 2;

        // Skip headers
        for (let i = 0; i < headerCount; i++) {
            const nameLen = buf.readUInt16BE(offset); offset += 2;
            offset += nameLen;          // header name
            offset += 1;               // mustUnderstand byte
            const valLen = buf.readInt32BE(offset); offset += 4;
            if (valLen > 0) offset += valLen;
        }

        const messageCount = buf.readUInt16BE(offset); offset += 2;

        // Read first message
        const targetLen = buf.readUInt16BE(offset); offset += 2;
        const targetUri = buf.slice(offset, offset + targetLen).toString('utf8'); offset += targetLen;

        const responseLen = buf.readUInt16BE(offset); offset += 2;
        const responseUri = buf.slice(offset, offset + responseLen).toString('utf8'); offset += responseLen;

        return { methodName: targetUri, responseId: responseUri };
    } catch (e) {
        console.warn('   -> [WARN] AMF0 envelope parse failed, using fallbacks:', e.message);
        return null;
    }
}

// ─── AMF PACKET BUILDER ───────────────────────────────────────────────────────
function buildAMFPacket(responseId, amf3Data) {
    // Target URI: e.g. \"/1/onResult\"
    const targetUri = responseId + '/onResult';
    const responseNull = 'null';

    // AMF0 Packet Header
    const header = Buffer.alloc(6);
    header.writeUInt16BE(0, 0); // AMF0 Version
    header.writeUInt16BE(0, 2); // 0 Headers
    header.writeUInt16BE(1, 4); // 1 Message

    const tBuf = Buffer.alloc(2 + Buffer.byteLength(targetUri));
    tBuf.writeUInt16BE(Buffer.byteLength(targetUri), 0);
    tBuf.write(targetUri, 2);

    const rBuf = Buffer.alloc(2 + Buffer.byteLength(responseNull));
    rBuf.writeUInt16BE(Buffer.byteLength(responseNull), 0);
    rBuf.write(responseNull, 2);

    const lBuf = Buffer.alloc(4);
    lBuf.writeUInt32BE(amf3Data.length + 1, 0); // +1 for the 0x11 AMF3 marker

    // 0x11 = AMF0 \"switch to AMF3\" marker
    const markerBuf = Buffer.from([0x11]);

    return Buffer.concat([header, tBuf, rBuf, lBuf, markerBuf, amf3Data]);
}

// AMF3 null body — used as the universal default reply for un-implemented
// services so the AS3 client doesn't choke trying to parse an empty 200.
const AMF3_NULL = Buffer.from([0x01]);

// ─── GATEWAY ROUTE ────────────────────────────────────────────────────────────
app.post('/Gateway.aspx', express.raw({ type: '*/*' }), async (req, res) => {
    const method = req.query.method;
    if (!method) return res.status(200).send();

    // --- Parse the AMF0 envelope to get the correct responseId ---
    let responseId = '/1'; // safe fallback

    const parsed = parseAMF0Envelope(req.body);
    if (parsed) {
        if (parsed.responseUri && /^\/\d+$/.test(parsed.responseUri.trim())) {
            responseId = parsed.responseUri.trim();
        } else if (parsed.responseUri && parsed.responseUri.trim()) {
            const m = parsed.responseUri.match(/(\/\d+)/);
            if (m) responseId = m[1];
        }
    } else {
        const headerString = req.body.subarray(0, 500).toString('latin1');
        const matches = [...headerString.matchAll(/(?<![a-zA-Z0-9._])(\/[0-9]+)(?![a-zA-Z0-9._/])/g)];
        if (matches.length > 0) {
            responseId = matches[matches.length - 1][1];
        }
    }

    const scriptName = method.split('.').pop();
    const scriptPath = path.join(__dirname, 'services', `${scriptName}.js`);

    console.log(`   -> [AMF Request] method=\"${method}\" | script=\"${scriptName}\" | responseId=\"${responseId}\"`);

    // Helper: build the final AMF wire packet from raw AMF3 bytes and send.
    const sendAMF = (amf3Data) => {
        const finalPacket = buildAMFPacket(responseId, amf3Data);
        res.setHeader('Content-Type', 'application/x-amf');
        res.status(200).send(finalPacket);
    };

    if (fs.existsSync(scriptPath)) {
        try {
            // Clear require cache in dev so you can edit scripts without restarting
            delete require.cache[require.resolve(scriptPath)];

            const handler = require(scriptPath);
            const responseData = await Promise.resolve(handler.execute(req));

            // Allow scripts to return { __rawAMF3__: Buffer } to bypass libamf entirely
            let amf3Data;
            if (responseData && Buffer.isBuffer(responseData.__rawAMF3__)) {
                console.log(`   -> [AMF Response] Using raw AMF3 bytes from script`);
                amf3Data = responseData.__rawAMF3__;
            } else {
                console.log(`   -> [AMF Response] Serializing:`, JSON.stringify(responseData).substring(0, 200));
                const rawAmf3 = libamf.serialize(responseData, libamf.AMF3);
                amf3Data = Buffer.isBuffer(rawAmf3) ? rawAmf3 : Buffer.from(rawAmf3);
            }
            console.log(`   -> [AMF Response] AMF3 bytes (first 40):`, amf3Data.subarray(0, 40).toString('hex'));

            sendAMF(amf3Data);
        } catch (error) {
            console.error(`   -> [ERROR] Failed to run ${scriptName}.js:`, error);
            // Don't 500 — that aborts the whole AMF call queue on the client.
            // Reply with AMF3 null so the client moves on.
            sendAMF(AMF3_NULL);
        }
    } else {
        // No handler yet → reply with AMF3 null so the client doesn't choke
        // on an empty body. Drop a TODO line for the dev.
        console.log(`   -> [MISSING SCRIPT]: Create services/${scriptName}.js — replying AMF3 null`);
        sendAMF(AMF3_NULL);
    }
});

// ─── SOAP / XML ───────────────────────────────────────────────────────────────
app.all(/^\/.*WebService\/User\/UserService\.asmx/i, (req, res) => {
    console.log(`   -> [SOAP SERVICE]: UserService`);
    res.type('text/xml');
    res.send(`<?xml version=\"1.0\" encoding=\"utf-8\"?><wsdl:definitions xmlns:wsdl=\"http://schemas.xmlsoap.org/wsdl/\" targetNamespace=\"http://tempuri.org/\"><wsdl:portType name=\"UserServiceSoap\" /></wsdl:definitions>`);
});

// ─── CATCH-ALL ────────────────────────────────────────────────────────────────
app.use((req, res) => {
    res.status(200).send('OK');
});

app.listen(PORT, () => {
    console.log(`=========================================`);
    console.log(`🚀 MSP AMF Gateway running on port ${PORT}`);
    console.log(`=========================================`);
});