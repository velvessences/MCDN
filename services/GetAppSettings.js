// services/GetAppSettings.js
const appSettings = require("../appSettings.js");

module.exports = {
    execute: function(req) {
        console.log("      => [AMF] Supplying AppSettings dictionary!");
        // We just return the JS object. server.js handles the binary encoding!
        return appSettings; 
    }
};