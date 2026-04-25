// services/Login.js
// MSP private server — Login (AMF3 typed response)
// Fix notes:
//   - Actor alias must be \"MovieStarPlanet.DBML.ActorDetails\"
//     (registered in UserSessionRegistrator.as).
//   - Date-typed AS3 fields MUST be sent as AMF3 Date (0x08), not strings.
//     Otherwise AVM2 throws TypeError #1034 (\"cannot convert Object to ActorDetails\").
//   - Only emit fields that actually exist on AS3 ActorDetails (sealed traits).
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
function amf3False()   { return Buffer.from([0x02]); }
function amf3True()    { return Buffer.from([0x03]); }
function amf3String(s) {
    if (s === null || s === undefined) return amf3Null();
    const str = String(s);
    if (str.length === 0) return Buffer.from([0x06, 0x01]); // empty-string ref
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
    b[0] = 0x08; b[1] = 0x01;            // 0x01 = inline (no ref), no traits for date
    b.writeDoubleBE(ms, 2);
    return b;
}
function amf3Array(items) {
    const parts = [Buffer.from([0x09]), encodeU29((items.length << 1) | 1), Buffer.from([0x01])];
    for (const i of items) parts.push(i);
    return Buffer.concat(parts);
}
function amf3EmptyArray() { return Buffer.from([0x09, 0x01, 0x01]); }

// Sealed typed object (registered class alias). props is an Array<[name, valueBuffer]>.
function typed(alias, props) {
    const parts = [Buffer.from([0x0A]), encodeU29((props.length << 4) | 0x03), rawStr(alias)];
    for (const [k]   of props) parts.push(rawStr(k));
    for (const [, v] of props) parts.push(v);
    return Buffer.concat(parts);
}

// Anonymous dynamic object (used for LoginStatus2 / LoginStatus wrappers — they
// are deserialised via LoginStatus2.fromObject, so they must be plain Objects).
function dynamic(props) {
    const parts = [Buffer.from([0x0A, 0x0B, 0x01])]; // dynamic, no traits, empty class name
    for (const [k, v] of Object.entries(props)) {
        parts.push(rawStr(k));
        parts.push(v);
    }
    parts.push(Buffer.from([0x01])); // dynamic-members terminator (empty string)
    return Buffer.concat(parts);
}

// ── Parse strings out of the request body ───────────────────────────────────
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
function buildHash(status, actorId, moderator, money, diamonds, fame, level) {
    // Matches LoginStatus2.getToHashValues + the secret prefix from the SWF.
    const str = 'idu!2*;d' + status + actorId + moderator + money + diamonds + fame + level;
    return crypto.createHash('md5').update(str).digest('hex');
}

function buildTicket(actorId, password) {
    const header  = Buffer.from(JSON.stringify({alg:'HS256',typ:'JWT'})).toString('base64url');
    const now     = Math.floor(Date.now() / 1000);
    const payload = Buffer.from(JSON.stringify({ActorId: actorId, Password: password, iat: now, exp: now + 86400})).toString('base64url');
    const sig     = crypto.createHmac('sha256', 'msp_secret_key').update(header + '.' + payload).digest('base64url');
    return `${header}.${payload}.${sig}`;
}

// ── Build typed ActorDetails (alias = MovieStarPlanet.DBML.ActorDetails) ────
// IMPORTANT: only include fields declared on AS3 ActorDetails. Order is the
// order of sealed traits we send; AMF3 doesn't require the AS3 declaration
// order, but every name MUST exist on the AS3 class.
function buildActorDetails(a) {
    const epoch  = new Date(0);
    const farPast = new Date('2000-01-01T00:00:00Z');
    const created  = a.created_at  ? new Date(a.created_at)  : new Date();
    const lastLog  = a.last_login  ? new Date(a.last_login)  : new Date();
    const membPur  = a.membership_purchased_date     ? new Date(a.membership_purchased_date)     : farPast;
    const membTo   = a.membership_timeout_date       ? new Date(a.membership_timeout_date)       : farPast;
    const membGift = a.membership_gift_received_date ? new Date(a.membership_gift_received_date) : farPast;
    const lockUntil = a.locked_until ? new Date(a.locked_until) : farPast;
    const purchTo   = a.purchase_timeout_date ? new Date(a.purchase_timeout_date) : new Date();
    const lastAuto  = a.time_of_last_autograph_given ? new Date(a.time_of_last_autograph_given) : epoch;

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
        ['Moderator',                   amf3Int(a.moderator || 0)],          // setter on AS3
        ['ProfileDisplays',             amf3Int(a.profile_displays || 0)],
        ['FavoriteMovie',               amf3String(a.favorite_movie    || '')],
        ['FavoriteActor',               amf3String(a.favorite_actor    || '')],
        ['FavoriteActress',             amf3String(a.favorite_actress  || '')],
        ['FavoriteSinger',              amf3String(a.favorite_singer   || '')],
        ['FavoriteSong',                amf3String(a.favorite_song     || '')],
        ['IsExtra',                     amf3Int(a.is_extra || 0)],
        ['HasUnreadMessages',           amf3Int(a.has_unread_messages || 0)],
        ['InvitedByActorId',            amf3Int(a.invited_by_actor_id != null ? a.invited_by_actor_id : -1)],
        ['PollTaken',                   amf3Int(a.poll_taken || 0)],
        ['ValueOfGiftsReceived',        amf3Int(a.value_of_gifts_received || 0)],
        ['ValueOfGiftsGiven',           amf3Int(a.value_of_gifts_given    || 0)],
        ['NumberOfGiftsGiven',          amf3Int(a.number_of_gifts_given   || 0)],
        ['NumberOfGiftsReceived',       amf3Int(a.number_of_gifts_received || 0)],
        ['NumberOfAutographsReceived',  amf3Int(a.number_of_autographs_received || 0)],
        ['NumberOfAutographsGiven',     amf3Int(a.number_of_autographs_given    || 0)],
        ['TimeOfLastAutographGiven',    amf3Date(lastAuto)],
        ['TimeOfLastAutographGivenStr', amf3String(lastAuto.toISOString())],
        ['FacebookId',                  amf3String(a.facebook_id || '')],
        ['MembershipPurchasedDate',     amf3Date(membPur)],
        ['MembershipTimeoutDate',       amf3Date(membTo)],
        ['MembershipGiftRecievedDate',  amf3Date(membGift)],
        ['BehaviourStatus',             amf3Int(a.behaviour_status != null ? a.behaviour_status : 2)],
        ['LockedUntil',                 amf3Date(lockUntil)],
        ['LockedText',                  amf3String(a.locked_text || '')],
        ['BadWordCount',                amf3Int(a.bad_word_count || 0)],
        ['PurchaseTimeoutDate',         amf3Date(purchTo)],
        ['EmailValidated',              amf3Int(a.email_validated || 0)],
        ['RetentionStatus',             amf3Int(a.retention_status || 0)],
        ['GiftStatus',                  amf3Int(a.gift_status != null ? a.gift_status : 2)],
        ['MarketingNextStepLogins',     amf3Int(a.marketing_next_step_logins || 1)],
        ['MarketingStep',               amf3Int(a.marketing_step || 1)],
        ['TotalVipDays',                amf3Int(a.total_vip_days || 0)],
        ['RecyclePoints',               amf3Int(a.recycle_points || 0)],
        ['EmailSettings',               amf3Int(a.email_settings || 0)],
        ['BestFriendId',                amf3Int(a.best_friend_id || 0)],
        ['BestFriendStatus',            amf3Int(a.best_friend_status || 0)],
        ['FriendCountVIP',              amf3Int(a.friend_count_vip || 0)],
        ['ForceNameChange',             amf3Int(a.force_name_change || 0)],
        ['CreationRewardStep',          amf3Int(0)],
        ['CreationRewardLastAwardDate', amf3Date(epoch)],
        ['NameBeforeDeleted',           amf3String('')],
        ['LastTransactionId',           amf3Int(0)],
        ['AllowCommunication',          amf3Int(a.allow_communication != null ? a.allow_communication : 1)],
        ['Diamonds',                    amf3Int(0)],
        ['PopUpStyleId',                amf3Int(0)],
        ['VipTier',                     amf3Int(a.vip_tier || 0)],
        ['EyeShadowId',                 amf3Int(a.eye_shadow_id || 0)],
        ['EyeShadowColors',             amf3String('')],
        ['BoyFriend',                   amf3Null()],
        ['ActorPersonalInfo',           amf3Null()],
        ['ActorRelationships',          amf3EmptyArray()],
        ['ActorStatus',                 amf3Null()],
        ['CombatCategorisation',        amf3Null()],
        ['RoomLikes',                   amf3Int(a.room_likes || 0)],
    ]);
}

// ── Build the LoginStatus2 wrapper (anonymous, fromObject parses it) ─────────
function buildLoginStatus2(actor, status, ticket) {
    const hash = buildHash(status, actor.id, actor.moderator || 0, actor.money || 0, 0, actor.fame || 0, actor.level || 0);

    const loginStatus = dynamic({
        status:               amf3String(status),
        actor:                buildActorDetails(actor),
        statusDetails:        amf3String(''),
        actorLocale:          amf3Array([amf3String('en_US')]),
        lbs:                  amf3EmptyArray(),
        userType:             amf3String(''),
        adCountryMap:         amf3EmptyArray(),
        postLoginSeq:         amf3Null(),
        previousLastLogin:    amf3String(actor.last_login || ''),
        version:              amf3String('1.0'),
        userIp:               amf3Int(0),
        ticket:               amf3String(ticket),
        piggyBank:            amf3Null(),
        purchaseTypeId:       amf3Int(0),
        mutedUntil:           amf3Null(),
        helpMessage:          amf3String(''),
        amsHash:              amf3String(''),
        combatCategorisation: amf3Null(),
    });

    return dynamic({
        loginStatus: loginStatus,
        hDetails:    amf3String(''),
        hash:        amf3String(hash),
    });
}

// Failure response — actor is null, hash is empty, client just reads .status.
function buildFailResponse(status = 'InvalidCredentials') {
    const loginStatus = dynamic({
        status:               amf3String(status),
        actor:                amf3Null(),
        statusDetails:        amf3String(''),
        actorLocale:          amf3EmptyArray(),
        lbs:                  amf3EmptyArray(),
        userType:             amf3String(''),
        adCountryMap:         amf3EmptyArray(),
        postLoginSeq:         amf3Null(),
        previousLastLogin:    amf3String(''),
        version:              amf3String('1.0'),
        userIp:               amf3Int(0),
        ticket:               amf3String(''),
        piggyBank:            amf3Null(),
        purchaseTypeId:       amf3Int(0),
        mutedUntil:           amf3Null(),
        helpMessage:          amf3String(''),
        amsHash:              amf3String(''),
        combatCategorisation: amf3Null(),
    });
    return dynamic({
        loginStatus: loginStatus,
        hDetails:    amf3String(''),
        hash:        amf3String(''),
    });
}

// ── Main ────────────────────────────────────────────────────────────────────
module.exports = {
    execute: async function (req) {
        const strings  = parseStrings(req.body);
        const username = (strings[0] || '').trim();
        const password = strings[1] || '';

        console.log(`      => [Login] strings=${JSON.stringify(strings.slice(0, 4))}`);
        console.log(`      => [Login] username=\"${username}\"`);

        if (!username || !password) {
            console.log(`      => [Login] FAILED — missing credentials`);
            return { __rawAMF3__: buildFailResponse('InvalidCredentials') };
        }

        let actor = null;
        try { actor = await db.getActorByUsername(username); }
        catch (e) { console.error('      => [Login] DB error:', e.message); return { __rawAMF3__: buildFailResponse('Error') }; }

        if (!actor) {
            console.log(`      => [Login] FAILED — user not found: \"${username}\"`);
            return { __rawAMF3__: buildFailResponse('InvalidCredentials') };
        }
        if (actor.password !== password) {
            console.log(`      => [Login] FAILED — wrong password for ${actor.id}`);
            return { __rawAMF3__: buildFailResponse('InvalidCredentials') };
        }

        const ticket = buildTicket(actor.id, actor.password);
        try {
            await db.createSession(actor.id, ticket, '');
            await db.updateActor(actor.id, { last_login: new Date().toISOString() });
        } catch (e) { console.error('      => [Login] Session/update warning:', e.message); }

        console.log(`      => [Login] SUCCESS actorId=${actor.id}`);
        return { __rawAMF3__: buildLoginStatus2(actor, 'Success', ticket) };
    }
};