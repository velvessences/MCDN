// services/SaveBirthInfoWithTicket.js  —  v3 (robust scan parser)
//
// Endpoint:
//   POST /Gateway.aspx?method=MovieStarPlanet.WebService.ActorService.AMFActorServiceForWeb.SaveBirthInfoWithTicket
// AS3:
//   amfCaller.callFunction(\"SaveBirthInfoWithTicket\",[ticket:String, month:int, year:int], false, callback, null)
// AS3 callback: function(result:int) — we must return AMF3 int 1 for success.

const db = require('../db.js');

console.log('✅ [SaveBirthInfoWithTicket] LOADED v3 (robust parser)');

// ── encoder ────────────────────────────────────────────────────────────────
function encodeU29(n) {
    n = n >>> 0;
    if (n < 0x80)        return Buffer.from([n]);
    if (n < 0x4000)      return Buffer.from([((n >> 7) & 0x7f) | 0x80, n & 0x7f]);
    if (n < 0x200000)    return Buffer.from([((n >> 14) & 0x7f) | 0x80, ((n >> 7) & 0x7f) | 0x80, n & 0x7f]);
    return Buffer.from([((n >> 22) & 0x7f) | 0x80, ((n >> 15) & 0x7f) | 0x80, ((n >> 8) & 0x7f) | 0x80, n & 0xff]);
}
function amf3Int(n) {
    n = (n | 0);
    return Buffer.concat([Buffer.from([0x04]), encodeU29(n & 0x1FFFFFFF)]);
}

// ── robust scan parser ────────────────────────────────────────────────────
// We scan the whole body for AMF3 markers and collect candidates:
//   0x06 string  -> ticket candidate (first long printable string)
//   0x04 int     -> number candidate
//   0x05 double  -> number candidate (truncate to int)
function readU29At(body, i) {
    let v = 0;
    for (let k = 0; k < 3 && i < body.length; k++) {
        const b = body[i++];
        if (b & 0x80) v = (v << 7) | (b & 0x7f);
        else          return { val: (v << 7) | b, next: i };
    }
    if (i >= body.length) return null;
    return { val: (v << 8) | body[i], next: i + 1 };
}

function parseArgs(body) {
    const out = { ticket: '', month: 0, year: 0 };
    const strings = [];
    const numbers = [];
    let i = 0;

    while (i < body.length) {
        const m = body[i];

        // AMF3 string
        if (m === 0x06) {
            const u = readU29At(body, i + 1);
            if (u && (u.val & 1) === 1) {
                const len = u.val >> 1;
                if (len >= 0 && len < 4096 && u.next + len <= body.length) {
                    const s = body.slice(u.next, u.next + len).toString('utf8');
                    if (/^[\x20-\x7E]+$/.test(s) && s.length >= 8) strings.push(s);
                    i = u.next + len; continue;
                }
            }
        }

        // AMF3 int
        if (m === 0x04) {
            const u = readU29At(body, i + 1);
            if (u) {
                let v = u.val;
                if (v & 0x10000000) v -= 0x20000000;
                if (v >= 0 && v <= 9999) numbers.push(v);
                i = u.next; continue;
            }
        }

        // AMF3 double
        if (m === 0x05 && i + 9 <= body.length) {
            const v = body.readDoubleBE(i + 1);
            if (Number.isFinite(v) && v >= 0 && v <= 9999) numbers.push(v | 0);
            i += 9; continue;
        }

        // AMF0 string (used inside the envelope)
        if (m === 0x02 && i + 3 <= body.length) {
            const len = body.readUInt16BE(i + 1);
            if (len > 0 && len < 4096 && i + 3 + len <= body.length) {
                const s = body.slice(i + 3, i + 3 + len).toString('utf8');
                if (/^[\x20-\x7E]+$/.test(s) && s.length >= 8 && s.includes('.')) strings.push(s);
                i += 3 + len; continue;
            }
        }

        i++;
    }

    if (strings.length > 0) out.ticket = strings[0];
    if (numbers.length >= 1) out.month = numbers[0];
    if (numbers.length >= 2) out.year  = numbers[1];
    return out;
}

function actorIdFromTicket(ticket) {
    try {
        const parts = String(ticket || '').split('.');
        if (parts.length < 2) return null;
        const payload = JSON.parse(Buffer.from(parts[1], 'base64url').toString('utf8'));
        return payload.ActorId || null;
    } catch { return null; }
}

module.exports = {
    execute: async function (req) {
        const { ticket, month, year } = parseArgs(req.body);
        const tShort = ticket ? ticket.substring(0, 30) + '...' : '(empty)';
        console.log(`      => [SaveBirthInfo] ticket=${tShort} month=${month} year=${year}`);

        const actorId = actorIdFromTicket(ticket);
        if (actorId) {
            try {
                await db.updateActor(actorId, { birth_month: month, birth_year: year });
                console.log(`      => [SaveBirthInfo] OK actorId=${actorId}`);
            } catch (e) {
                console.error(`      => [SaveBirthInfo] DB error (continuing):`, e.message);
            }
        } else {
            console.log(`      => [SaveBirthInfo] no ticket — skipping DB write, returning OK so registration continues`);
        }
        // ALWAYS return 1 — birth info is non-blocking, registration must continue.
        return { __rawAMF3__: amf3Int(1) };
    }
};