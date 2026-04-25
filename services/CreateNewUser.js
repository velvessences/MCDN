// services/CreateNewUser.js
// MSP private server — CreateNewUser (AMF3 typed response)
// Fix notes:
//   - Wrapper alias: \"MovieStarPlanet.WebService.User.UserService+CreateNewUserStatus\"
//     (registered in UserAmfServiceWeb.as).
//   - Inner actor MUST be typed \"MovieStarPlanet.DBML.ActorDetails\" (sealed).
//   - Date-typed AS3 fields MUST be AMF3 Date (0x08), not strings.
//   - The previous #1009 (\"null object reference\") was caused by the inner
//     `actor` being a plain Object: the AMF deserialiser couldn't coerce it
//     to ActorDetails, so CreateNewUserStatus._actor stayed null and the
//     post-login code crashed when it accessed .actor.<something>.
const db = require('../db.js');
const crypto = require('crypto');

// ── AMF3 encoder ─────────────────────────────────────────────────────────────
function encodeU29(n) {
    n = n >>> 0;
    if (n < 0x80)        return Buffer.from([n]);
    if (n < 0x4000)      return Buffer.from([((n >> 7) & 0x7f) | 0x80, n & 0x7f]);
    if (n < 0x200000)    return Buffer.from([((n >> 14) & 0x7f) | 0x80, ((n >> 7) & 0x7f) | 0x80, n & 0x7f]);
    return Buffer.from([((n >> 22) & 0x7f) | 0x80, ((n >> 15) & 0x7f) | 0x80, ((n >> 8) & 0x7f) | 0x80, n & 0xff]);
}
function rawStr(s)     { const b = Buffer.from(s, 'utf8'); return Buffer.concat([encodeU29((b.length << 1) | 1), b]); }
function amf3Null()    { return Buffer.from([0x01]); }
function amf3String(s) {
    if (s === null || s === undefined) return amf3Null();
    const str = String(s);
    if (str.length === 0) return Buffer.from([0x06, 0x01]);
    const b = Buffer.from(str, 'utf8');
    return Buffer.concat([Buffer.from([0x06]), encodeU29((b.length << 1) | 1), b]);
}
function amf3Int(n)    { n = (n | 0); if (n < -0x10000000 || n > 0x0FFFFFFF) return amf3Double(n); return Buffer.concat([Buffer.from([0x04]), encodeU29(n & 0x1FFFFFFF)]); }
function amf3Double(n) { const b = Buffer.alloc(9); b[0] = 0x05; b.writeDoubleBE(Number(n) || 0, 1); return b; }
function amf3Date(d) {
    let ms = 0;
    if (d instanceof Date)               ms = d.getTime();
    else if (typeof d === 'number')      ms = d;
    else if (typeof d === 'string' && d) { const t = Date.parse(d); ms = isNaN(t) ? 0 : t; }
    const b = Buffer.alloc(10);
    b[0] = 0x08; b[1] = 0x01;
    b.writeDoubleBE(ms, 2);
    return b;
}
function amf3EmptyArray() { return Buffer.from([0x09, 0x01, 0x01]); }

function typed(alias, props) {
    const parts = [Buffer.from([0x0A]), encodeU29((props.length << 4) | 0x03), rawStr(alias)];
    for (const [k]   of props) parts.push(rawStr(k));
    for (const [, v] of props) parts.push(v);
    return Buffer.concat(parts);
}

// ── Parse strings out of body ────────────────────────────────────────────────
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
        } else if (marker === 0x02) {
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

// ── Helpers ─────────────────────────────────────────────────────────────────
function buildHDetails(actorId) {
    return crypto.createHash('md5').update('wiurh2i' + actorId).digest('hex');
}

function buildTicket(actorId, password) {
    const header  = Buffer.from(JSON.stringify({alg:'HS256',typ:'JWT'})).toString('base64url');
    const now     = Math.floor(Date.now() / 1000);
    const payload = Buffer.from(JSON.stringify({ActorId: actorId, Password: password, iat: now, exp: now + 86400})).toString('base64url');
    const sig     = crypto.createHmac('sha256', 'msp_secret_key').update(header + '.' + payload).digest('base64url');
    return `${header}.${payload}.${sig}`;
}

// ── Build typed ActorDetails (alias = MovieStarPlanet.DBML.ActorDetails) ────
function buildActorDetails(a) {
    const epoch   = new Date(0);
    const farPast = new Date('2000-01-01T00:00:00Z');
    const created = a.created_at ? new Date(a.created_at) : new Date();
    const lastLog = a.last_login ? new Date(a.last_login) : new Date();

    return typed('MovieStarPlanet.DBML.ActorDetails', [
        ['ActorId',                     amf3Int(a.id)],
        ['Name',                        amf3String(a.username)],
        ['Level',                       amf3Int(a.level || 0)],
        ['_SkinSWF',                    amf3String(a.skin_swf || 'femaleskin')],
        ['SkinColor',                   amf3String(String(a.skin_color || 14654312))],
        ['NoseId',                      amf3Int(a.nose_id || 1)],
        ['EyeId',                       amf3Int(a.eye_id  || 1)],
        ['MouthId',                     amf3Int(a.mouth_id || 1)],
        ['Money',                       amf3Int(a.money || 0)],
        ['EyeColors',                   amf3String(a.eye_colors || '0x000000,0x000000,skincolor')],
        ['MouthColors',                 amf3String(a.mouth_colors || '')],
        ['Fame',                        amf3Double(a.fame || 0)],
        ['Fortune',                     amf3Int(a.fortune || 0)],
        ['FriendCount',                 amf3Int(a.friend_count || 0)],
        ['ProfileText',                 amf3String(a.profile_text || '')],
        ['Created',                     amf3Date(created)],
        ['LastLogin',                   amf3Date(lastLog)],
        ['Moderator',                   amf3Int(a.moderator || 0)],
        ['ProfileDisplays',             amf3Int(a.profile_displays || 0)],
        ['FavoriteMovie',               amf3String('')],
        ['FavoriteActor',               amf3String('')],
        ['FavoriteActress',             amf3String('')],
        ['FavoriteSinger',              amf3String('')],
        ['FavoriteSong',                amf3String('')],
        ['IsExtra',                     amf3Int(0)],
        ['HasUnreadMessages',           amf3Int(0)],
        ['InvitedByActorId',            amf3Int(-1)],
        ['PollTaken',                   amf3Int(0)],
        ['ValueOfGiftsReceived',        amf3Int(0)],
        ['ValueOfGiftsGiven',           amf3Int(0)],
        ['NumberOfGiftsGiven',          amf3Int(0)],
        ['NumberOfGiftsReceived',       amf3Int(0)],
        ['NumberOfAutographsReceived',  amf3Int(0)],
        ['NumberOfAutographsGiven',     amf3Int(0)],
        ['TimeOfLastAutographGiven',    amf3Date(epoch)],
        ['TimeOfLastAutographGivenStr', amf3String(epoch.toISOString())],
        ['FacebookId',                  amf3String('')],
        ['MembershipPurchasedDate',     amf3Date(farPast)],
        ['MembershipTimeoutDate',       amf3Date(farPast)],
        ['MembershipGiftRecievedDate',  amf3Date(farPast)],
        ['BehaviourStatus',             amf3Int(2)],
        ['LockedUntil',                 amf3Date(farPast)],
        ['LockedText',                  amf3String('')],
        ['BadWordCount',                amf3Int(0)],
        ['PurchaseTimeoutDate',         amf3Date(new Date())],
        ['EmailValidated',              amf3Int(0)],
        ['RetentionStatus',             amf3Int(0)],
        ['GiftStatus',                  amf3Int(2)],
        ['MarketingNextStepLogins',     amf3Int(1)],
        ['MarketingStep',               amf3Int(1)],
        ['TotalVipDays',                amf3Int(0)],
        ['RecyclePoints',               amf3Int(0)],
        ['EmailSettings',               amf3Int(0)],
        ['BestFriendId',                amf3Int(0)],
        ['BestFriendStatus',            amf3Int(0)],
        ['FriendCountVIP',              amf3Int(0)],
        ['ForceNameChange',             amf3Int(0)],
        ['CreationRewardStep',          amf3Int(0)],
        ['CreationRewardLastAwardDate', amf3Date(epoch)],
        ['NameBeforeDeleted',           amf3String('')],
        ['LastTransactionId',           amf3Int(0)],
        ['AllowCommunication',          amf3Int(1)],
        ['Diamonds',                    amf3Int(0)],
        ['PopUpStyleId',                amf3Int(0)],
        ['VipTier',                     amf3Int(0)],
        ['EyeShadowId',                 amf3Int(0)],
        ['EyeShadowColors',             amf3String('')],
        ['BoyFriend',                   amf3Null()],
        ['ActorPersonalInfo',           amf3Null()],
        ['ActorRelationships',          amf3EmptyArray()],
        ['ActorStatus',                 amf3Null()],
        ['CombatCategorisation',        amf3Null()],
        ['RoomLikes',                   amf3Int(0)],
    ]);
}

// ── CreateNewUserStatus wrapper (typed; setters do _actor = param1, etc.) ───
// Property names MUST match the AS3 setters: actor, ticket, hDetails, adCountryMap, amsHash, features
function buildCreateNewUserStatus(actor, ticket, hDetails) {
    return typed('MovieStarPlanet.WebService.User.UserService+CreateNewUserStatus', [
        ['actor',        buildActorDetails(actor)],
        ['ticket',       amf3String(ticket || '')],
        ['hDetails',     amf3String(hDetails || '')],
        ['adCountryMap', amf3EmptyArray()],
        ['amsHash',      amf3String('')],
        ['features',     amf3EmptyArray()],
    ]);
}

// Fail response: still typed, but we send a stub actor (NOT null) so the
// client's CreateNewUserStatus(param1) cast doesn't dereference null later.
// We give it ActorId = -2 (taken) or -1 (error); UI checks ActorId.
function buildFailResponse(failActorId, username) {
    const stub = {
        id: failActorId,
        username: username || '',
        skin_swf: 'femaleskin',
        skin_color: 14654312,
        nose_id: 1, eye_id: 1, mouth_id: 1,
        money: 0, level: 0, fame: 0,
    };
    return buildCreateNewUserStatus(stub, '', '');
}

// ── Main ────────────────────────────────────────────────────────────────────
module.exports = {
    execute: async function (req) {
        const strings  = parseStrings(req.body);
        const username = (strings[0] || '').trim();
        const password = strings[1] || '';
        const eyeColors = strings.find(s => s.includes(',') && s.includes('0x')) || '0x000000,0x000000,skincolor';
        const skinColor = strings.find(s => /^\d{7,8}$/.test(s)) || '14654312';

        // crude gender sniff (kept from existing impl)
        const maleIdx   = req.body.indexOf(0x03);
        const femaleIdx = req.body.indexOf(0x02);
        const isMale = maleIdx > 0 && (femaleIdx < 0 || maleIdx < femaleIdx);

        console.log(`      => [CreateNewUser] strings=${JSON.stringify(strings.slice(0, 4))}`);
        console.log(`      => [CreateNewUser] username=\"${username}\" male=${isMale}`);

        if (!username || !password) {
            console.log(`      => [CreateNewUser] FAILED — missing credentials`);
            return { __rawAMF3__: buildFailResponse(-1, username) };
        }

        let exists = false;
        try { exists = await db.actorNameExists(username); }
        catch (e) { console.error('      => [CreateNewUser] DB check error:', e.message); }

        if (exists) {
            console.log(`      => [CreateNewUser] name taken: \"${username}\"`);
            return { __rawAMF3__: buildFailResponse(-2, username) };
        }

        let newActor = null;
        try {
            newActor = await db.createActor({
                username, password,
                skin_swf:  isMale ? 'maleskin' : 'femaleskin',
                skin_color: parseInt(skinColor, 10) || 14654312,
                eye_colors: eyeColors,
                money: 500, level: 0, fame: 0,
            });
            if (!newActor) throw new Error('DB returned empty actor data');
        } catch (e) {
            console.error('      => [CreateNewUser] DB create error:', e.message);
            return { __rawAMF3__: buildFailResponse(-1, username) };
        }

        const ticket   = buildTicket(newActor.id, password);
        const hDetails = buildHDetails(newActor.id);

        try { await db.createSession(newActor.id, ticket, ''); }
        catch (e) { console.error('      => [CreateNewUser] Session warning:', e.message); }

        console.log(`      => [CreateNewUser] SUCCESS actorId=${newActor.id}`);
        return { __rawAMF3__: buildCreateNewUserStatus(newActor, ticket, hDetails) };
    }
};