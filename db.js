// db.js — Supabase client, import this in any service
const SUPABASE_URL = 'https://ttiyeufwsofucnxhcaai.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR0aXlldWZ3c29mdWNueGhjYWFpIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3NzEzNzg1MiwiZXhwIjoyMDkyNzEzODUyfQ.YK9_EbHzAPYm5JfiqC_D8V5igG0DjtXhjYPsWH6J5MA';

async function query(table, method = 'GET', body = null, params = '') {
    const url = `${SUPABASE_URL}/rest/v1/${table}${params}`;
    const res = await fetch(url, {
        method,
        headers: {
            'apikey':        SUPABASE_KEY,
            'Authorization': `Bearer ${SUPABASE_KEY}`,
            'Content-Type':  'application/json',
            'Prefer':        method === 'POST' ? 'return=representation' : '',
        },
        body: body ? JSON.stringify(body) : null,
    });
    if (!res.ok) {
        const err = await res.text();
        throw new Error(`Supabase ${method} ${table}: ${err}`);
    }
    const text = await res.text();
    return text ? JSON.parse(text) : null;
}

// PostgREST `ilike` treats the value as a pattern, so `_` and `%` would
// false-match. We escape them so the pattern is an exact (case-insensitive)
// match. Written in plain ES5 to keep every editor/linter happy.
function escapePgLike(s) {
    var out = '';
    var str = String(s == null ? '' : s);
    for (var i = 0; i < str.length; i++) {
        var c = str.charAt(i);
        if (c === '\\' || c === '%' || c === '_') out += '\\';
        out += c;
    }
    return out;
}

module.exports = {
    // ── Actors ──────────────────────────────────────────────────────────────
    async getActorByUsername(username) {
        const pat = encodeURIComponent(escapePgLike(username));
        const rows = await query('actors', 'GET', null, `?username=ilike.${pat}&limit=1`);
        return rows?.[0] || null;
    },
    async getActorById(id) {
        const rows = await query('actors', 'GET', null, `?id=eq.${id}&limit=1`);
        return rows?.[0] || null;
    },
    async createActor(data) {
        const rows = await query('actors', 'POST', data);
        return rows?.[0] || null;
    },
    async updateActor(id, data) {
        return query('actors', 'PATCH', data, `?id=eq.${id}`);
    },
    async actorNameExists(username) {
        if (!username) return false;
        const pat = encodeURIComponent(escapePgLike(username));
        const rows = await query('actors', 'GET', null,
            `?username=ilike.${pat}&limit=1&select=id`);
        return Array.isArray(rows) && rows.length > 0;
    },

    // ── Sessions ────────────────────────────────────────────────────────────
    async createSession(actorId, ticket, ip) {
        return query('sessions', 'POST', { actor_id: actorId, ticket, ip });
    },
    async getSession(ticket) {
        const rows = await query('sessions', 'GET', null, `?ticket=eq.${encodeURIComponent(ticket)}&limit=1`);
        return rows?.[0] || null;
    },

    // ── Actor clothes ───────────────────────────────────────────────────────
    async getActorClothes(actorId) {
        return query('actor_clothes', 'GET', null, `?actor_id=eq.${actorId}&is_wearing=eq.1`);
    },
    async saveActorClothes(actorId, clothesId, color, isWearing) {
        return query('actor_clothes', 'POST', {
            actor_id: actorId,
            clothes_id: clothesId,
            color,
            is_wearing: isWearing ? 1 : 0,
        });
    },

    // ── Friends ─────────────────────────────────────────────────────────────
    async getFriends(actorId) {
        return query('friends', 'GET', null, `?actor_id=eq.${actorId}&status=eq.1`);
    },

    // ── Guestbook ───────────────────────────────────────────────────────────
    async getGuestbook(actorId, page = 0, pageSize = 3) {
        const offset = page * pageSize;
        return query('guestbook', 'GET', null,
            `?target_actor_id=eq.${actorId}&order=created_at.desc&limit=${pageSize}&offset=${offset}`);
    },

    // ── Messages ────────────────────────────────────────────────────────────
    async getUnreadCount(actorId) {
        const rows = await query('messages', 'GET', null,
            `?receiver_id=eq.${actorId}&is_read=eq.false&select=id`);
        return rows?.length || 0;
    },

    // ── News ────────────────────────────────────────────────────────────────
    async getNews(page = 0, pageSize = 1) {
        const offset = page * pageSize;
        return query('news', 'GET', null,
            `?order=created_at.desc&limit=${pageSize}&offset=${offset}&select=*`);
    },
    async getNewsCount() {
        const rows = await query('news', 'GET', null, `?select=id`);
        return rows?.length || 0;
    },

    // ── Bad-words list (optional table; safe if missing) ────────────────────
    async getBadWords() {
        try {
            const rows = await query('bad_words', 'GET', null, '?select=word');
            return rows || [];
        } catch (e) {
            return [];
        }
    },
};