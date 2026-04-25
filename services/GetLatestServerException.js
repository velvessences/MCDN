// services/GetLatestServerException.js
// Stub — client expects an object with { Version, Exception } so it can
// fire a CHECK_VERSION event. We send a dynamic anonymous object with
// empty fields so the client just no-ops.
function encodeU29(n) {
    n = n >>> 0;
    if (n < 0x80)     return Buffer.from([n]);
    if (n < 0x4000)   return Buffer.from([((n >> 7) & 0x7f) | 0x80, n & 0x7f]);
    if (n < 0x200000) return Buffer.from([((n >> 14) & 0x7f) | 0x80, ((n >> 7) & 0x7f) | 0x80, n & 0x7f]);
    return Buffer.from([((n >> 22) & 0x7f) | 0x80, ((n >> 15) & 0x7f) | 0x80, ((n >> 8) & 0x7f) | 0x80, n & 0xff]);
}
function rawStr(s) {
    const b = Buffer.from(s, 'utf8');
    return Buffer.concat([encodeU29((b.length << 1) | 1), b]);
}
function amf3String(s) {
    const str = String(s || '');
    if (str.length === 0) return Buffer.from([0x06, 0x01]);
    const b = Buffer.from(str, 'utf8');
    return Buffer.concat([Buffer.from([0x06]), encodeU29((b.length << 1) | 1), b]);
}
function dynamic(props) {
    const parts = [Buffer.from([0x0A, 0x0B, 0x01])]; // dynamic, no traits, empty class
    for (const [k, v] of Object.entries(props)) {
        parts.push(rawStr(k));
        parts.push(v);
    }
    parts.push(Buffer.from([0x01])); // dynamic-members terminator
    return Buffer.concat(parts);
}

module.exports = {
    execute: async function () {
        return {
            __rawAMF3__: dynamic({
                Version:   amf3String('1.0'),
                Exception: amf3String(''),
            }),
        };
    }
};