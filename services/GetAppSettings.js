const appSettings = require("../appSettings.js");

console.log('✅ [GetAppSettings] LOADED v3 (dynamic AppSetting fix)');

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
    if (str === '') return Buffer.from([0x06, 0x01]);
    const b = Buffer.from(str, 'utf8');
    return Buffer.concat([Buffer.from([0x06]), encodeU29((b.length << 1) | 1), b]);
}

// DYNAMIC typed object — traits-info = 0x0B (dynamic flag on, 0 sealed traits)
function encodeDynamicTyped(alias, dynProps) {
    const parts = [
        Buffer.from([0x0A]),
        Buffer.from([0x0B]),
        encodeRawString(alias),
    ];
    for (const k of Object.keys(dynProps)) {
        parts.push(encodeRawString(k));
        parts.push(encodeAMF3String(String(dynProps[k])));
    }
    parts.push(Buffer.from([0x01])); // terminator
    return Buffer.concat(parts);
}

function encodeAMF3Array(items) {
    const parts = [Buffer.from([0x09]), encodeU29((items.length << 1) | 1), Buffer.from([0x01])];
    for (const item of items) parts.push(item);
    return Buffer.concat(parts);
}

module.exports = {
    execute: function(req) {
        const ALIAS = "MovieStarPlanet.WebService.User.UserService+AppSetting";
        const items = [];
        for (const key in appSettings) {
            items.push(encodeDynamicTyped(ALIAS, { name: key, value: String(appSettings[key]) }));
        }
        console.log(`      => [AMF] Supplying ${items.length} AppSettings (DYNAMIC alias=${ALIAS})`);
        return { __rawAMF3__: encodeAMF3Array(items) };
    }
};