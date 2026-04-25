// services/GetAppSettings.js
//
// AppSetting.as originally had [RemoteClass(alias="com.moviestarplanet.session.valueobjects.AppSetting")]
// compiled into the SWF bytecode — the decompiler stripped it.
// We encode each item as a typed AMF3 object with that alias AND also as a
// dynamic object fallback, trying both the full package alias and short name.

const appSettings = require("../appSettings.js");

function encodeU29(n) {
    if (n < 0x80)     return Buffer.from([n]);
    if (n < 0x4000)   return Buffer.from([((n >> 7) & 0x7f) | 0x80, n & 0x7f]);
    if (n < 0x200000) return Buffer.from([((n >> 14) & 0x7f) | 0x80, ((n >> 7) & 0x7f) | 0x80, n & 0x7f]);
    return Buffer.from([((n >> 22) & 0x7f) | 0x80, ((n >> 15) & 0x7f) | 0x80, ((n >> 8) & 0x7f) | 0x80, n & 0xff]);
}

function encodeRawString(str) {
    const b = Buffer.from(str, 'utf8');
    return Buffer.concat([encodeU29((b.length << 1) | 1), b]);
}

function encodeAMF3String(str) {
    const b = Buffer.from(str, 'utf8');
    return Buffer.concat([Buffer.from([0x06]), encodeU29((b.length << 1) | 1), b]);
}

// Sealed typed object — Flash will try to instantiate the named AS3 class
function encodeTypedObject(alias, props) {
    const keys = Object.keys(props);
    const parts = [
        Buffer.from([0x0A]),
        encodeU29((keys.length << 4) | 0x03), // sealed, not dynamic
        encodeRawString(alias),
    ];
    for (const k of keys) parts.push(encodeRawString(k));
    for (const k of keys) parts.push(encodeAMF3String(String(props[k])));
    return Buffer.concat(parts);
}

function encodeAMF3Array(items) {
    const parts = [Buffer.from([0x09]), encodeU29((items.length << 1) | 1), Buffer.from([0x01])];
    for (const item of items) parts.push(item);
    return Buffer.concat(parts);
}

module.exports = {
    execute: function(req) {
        console.log("      => [AMF] Supplying AppSettings!");

        // Try the RemoteClass alias that would have been in the original compiled SWF
        // Ruffle resolves this alias to instantiate the real AppSetting AS3 class
        const ALIAS = "com.moviestarplanet.session.valueobjects.AppSetting";

        const items = [];
        for (const key in appSettings) {
            items.push(encodeTypedObject(ALIAS, { name: key, value: String(appSettings[key]) }));
        }

        console.log(`      => Sending ${items.length} entries with alias: ${ALIAS}`);
        return { __rawAMF3__: encodeAMF3Array(items) };
    }
};