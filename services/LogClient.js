// services/LogClient.js
// Stub — same payload as ClientLog but called via logClient() (non-blocking,
// fire-and-forget). Just acknowledges the call.
const AMF3_NULL = Buffer.from([0x01]);
module.exports = {
    execute: async function (req) {
        console.log(`      => [LogClient] ${req.body.length} bytes`);
        return { __rawAMF3__: AMF3_NULL };
    }
};