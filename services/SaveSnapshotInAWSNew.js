// services/SaveSnapshotInAWSNew.js
// MSP private server — SnapshotService.SaveSnapshotInAWSNew
//
// Client signature (SnapshotAmfService.as):
//   SaveSnapshotInAWSNew(actorId:int, ids:Array, entityType:String, ext:String, image:ByteArray)
//
// Wire args (in this order):
//   [0] \"msp\"           (sessionTicketId)
//   [1] sessionID       (string ticket)
//   [2] actorId         (int)
//   [3] [actorId,...]   (array of ints)
//   [4] entityType      (\"room\" | \"roomMedium\" | \"roomProfile\" | \"look\" | ...)
//   [5] extension       (\"jpg\" | \"png\")
//   [6] imageBytes      (AMF3 ByteArray, marker 0x0C)
//
// Storage: writes to <repo>/uploads/entity-snapshots/{entityType}/{floor(id/10000)}/{id}.{ext}
// (matches the path SnapshotUtils.getSnapshotSourcePath builds on the client.)
//
// Response: AMF3 null (0x01) — the client passes a null callback for room
// snapshots so any well-formed AMF reply is enough.

const fs = require('fs');
const path = require('path');

// ── Tiny AMF3 reader (only what we need) ────────────────────────────────────
function readU29(buf, offset) {
    let result = 0;
    for (let i = 0; i < 3; i++) {
        if (offset >= buf.length) return null;
        const b = buf[offset++];
        if (i < 2) {
            result = (result << 7) | (b & 0x7f);
            if (!(b & 0x80)) return { value: result, offset };
        } else {
            result = (result << 7) | (b & 0x7f);
            if (!(b & 0x80)) return { value: result, offset };
        }
    }
    if (offset >= buf.length) return null;
    result = (result << 8) | buf[offset++];
    return { value: result, offset };
}

// Walk the body and pull out the FIRST AMF3 ByteArray (marker 0x0C) we find
// of reasonable size (>= 200 bytes — anything smaller is almost certainly the
// session ticket header, not an image).
function extractByteArray(body) {
    for (let i = 0; i < body.length - 4; i++) {
        if (body[i] !== 0x0C) continue;
        const u29 = readU29(body, i + 1);
        if (!u29) continue;
        // low bit must be 1 (inline, not a reference)
        if (!(u29.value & 1)) continue;
        const len = u29.value >> 1;
        if (len < 200 || len > 10 * 1024 * 1024) continue; // skip tiny / absurd
        if (u29.offset + len > body.length) continue;
        return { bytes: body.slice(u29.offset, u29.offset + len), offset: u29.offset + len };
    }
    return null;
}

// Pull all printable strings (same heuristic as Login/CreateNewUser).
function parseStrings(body) {
    const strings = [];
    let i = 0;
    while (i < body.length - 2) {
        const marker = body[i];
        if (marker === 0x06) {
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
                if (strLen > 0 && strLen < 1024 && j + strLen <= body.length) {
                    const s = body.slice(j, j + strLen).toString('utf8');
                    if (/^[\x20-\x7E]+$/.test(s)) strings.push(s);
                    i = j + strLen; continue;
                }
            } else {
                const strLen = lenByte >> 1;
                if (strLen > 0 && strLen < 1024 && i + 2 + strLen <= body.length) {
                    const s = body.slice(i + 2, i + 2 + strLen).toString('utf8');
                    if (/^[\x20-\x7E]+$/.test(s)) strings.push(s);
                    i += 2 + strLen; continue;
                }
            }
        }
        i++;
    }
    return strings;
}

// Pull the first plausible actor-id (AMF3 int marker 0x04 followed by a U29).
function extractFirstInt(body) {
    for (let i = 0; i < body.length - 2; i++) {
        if (body[i] !== 0x04) continue;
        const u29 = readU29(body, i + 1);
        if (!u29) continue;
        // sanity check — actor ids are typically small positive integers
        if (u29.value > 0 && u29.value < 0x0FFFFFFF) return u29.value;
    }
    return 0;
}

// Known entity types (lowercase, from EntityTypeType.EntityTypeAsString).
const ENTITY_TYPES = new Set([
    'fullSizeMovieStar', 'fullSizeLook', 'look', 'room', 'roomMedium', 'roomProfile',
    'movie', 'movieBig', 'moviestar', 'moviecompetition', 'scrapblog', 'scrapblogBig',
    'youtube', 'clubs', 'playlist', 'wallpost', 'diamondspecial', 'embeddedgame',
    'background', 'animation', 'item', 'clothes', 'pets', 'design', 'app',
    'socialShopping', 'boonieverse', 'boonieversesmall', 'pictureUpload',
]);

const EXT_WHITELIST = new Set(['jpg', 'jpeg', 'png', 'gif']);

// AMF3 null marker — the response body (after the 0x11 AMF3 switch byte
// added by server.js's buildAMFPacket).
const AMF3_NULL = Buffer.from([0x01]);

module.exports = {
    execute: async function (req) {
        const body = req.body;
        const strings = parseStrings(body);

        // Find entityType and extension from the parsed string list.
        let entityType = strings.find(s => ENTITY_TYPES.has(s)) || 'unknown';
        let ext        = strings.find(s => EXT_WHITELIST.has(s.toLowerCase())) || 'jpg';
        ext = ext.toLowerCase();

        const actorId = extractFirstInt(body);
        const image   = extractByteArray(body);

        console.log(`      => [SaveSnapshotInAWSNew] actorId=${actorId} entityType=\"${entityType}\" ext=\"${ext}\" imageBytes=${image ? image.bytes.length : 0}`);

        if (!image) {
            console.warn(`      => [SaveSnapshotInAWSNew] no image bytes found — returning success anyway`);
            return { __rawAMF3__: AMF3_NULL };
        }

        try {
            const folderNum = Math.floor(actorId / 10000);
            const dir  = path.join(__dirname, '..', 'uploads', 'entity-snapshots', entityType, String(folderNum));
            const file = path.join(dir, `${actorId}.${ext}`);
            fs.mkdirSync(dir, { recursive: true });
            fs.writeFileSync(file, image.bytes);
            console.log(`      => [SaveSnapshotInAWSNew] saved ${file} (${image.bytes.length} bytes)`);
        } catch (e) {
            console.error(`      => [SaveSnapshotInAWSNew] write failed:`, e.message);
            // still return success so the client UI doesn't show an error
        }

        return { __rawAMF3__: AMF3_NULL };
    }
};