// services/IsActorNameUsed.js
// Returns AMF3 boolean: true (0x03) = name taken, false (0x02) = available.
// Fix notes:
//   - The previous version grabbed the FIRST printable string > 2 chars in the
//     packet, which sometimes matched packet headers, not the username.
//   - Now uses a real AMF0/AMF3 string-finder and picks the LAST string in the
//     args body (the username is always the last argument the client sends).
const db = require('../db.js');

function parseStrings(body) {
    const strings = [];
    let i = 0;
    while (i < body.length - 2) {
        const marker = body[i];
        if (marker === 0x06) {                       // AMF3 string
            const lenByte = body[i + 1];
            if (lenByte & 0x80) {
                let uVal = 0, j = i + 1, shifts = 0;
                while (j < body.length && shifts < 4) {
                    const b = body[j++];
                    if (shifts < 3) { uVal = (uVal << 7) | (b & 0x7f); if (!(b & 0x80)) break; }
                    else            { uVal = (uVal << 8) | b; break; }
                    shifts++;
                }
                const strLen = uVal >> 1;
                if (strLen > 0 && strLen < 512 && j + strLen <= body.length) {
                    const s = body.slice(j, j + strLen).toString('utf8');
                    if (/^[\x20-\x7E]+$/.test(s)) strings.push(s);
                    i = j + strLen; continue;
                }
            } else {
                const strLen = lenByte >> 1;
                if (strLen > 0 && strLen < 512 && i + 2 + strLen <= body.length) {
                    const s = body.slice(i + 2, i + 2 + strLen).toString('utf8');
                    if (/^[\x20-\x7E]+$/.test(s)) strings.push(s);
                    i += 2 + strLen; continue;
                }
            }
        } else if (marker === 0x02) {                // AMF0 string
            if (i + 2 < body.length) {
                const strLen = body.readUInt16BE(i + 1);
                if (strLen > 0 && strLen < 512 && i + 3 + strLen <= body.length) {
                    const s = body.slice(i + 3, i + 3 + strLen).toString('utf8');
                    if (/^[\x20-\x7E]+$/.test(s)) strings.push(s);
                    i += 3 + strLen; continue;
                }
            }
        }
        i++;
    }
    return strings;
}

module.exports = {
    execute: async function (req) {
        const strings = parseStrings(req.body);
        // The client sends only one user-controlled string (the name); pick the
        // last one in case the dispatcher leaves headers/method names in front.
        const name = (strings[strings.length - 1] || '').trim();
        console.log(`      => [IsActorNameUsed] strings=${JSON.stringify(strings)} name=\"${name}\"`);

        if (!name) return { __rawAMF3__: Buffer.from([0x02]) }; // false

        let isTaken = false;
        try {
            isTaken = await db.actorNameExists(name);
        } catch (e) {
            console.error('      => [IsActorNameUsed] DB error:', e.message);
        }

        console.log(`      => [IsActorNameUsed] \"${name}\" taken=${isTaken}`);
        return { __rawAMF3__: Buffer.from([isTaken ? 0x03 : 0x02]) };
    }
};