// services/CreateTestException.js
// Stub — server fires & forgets. Returns AMF3 null.
const AMF3_NULL = Buffer.from([0x01]);
module.exports = { execute: async () => ({ __rawAMF3__: AMF3_NULL }) };