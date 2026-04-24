// services/GetCurrentPaymentPossibilities.js
module.exports = {
    execute: function(req) {
        console.log("      => [AMF] Supplying empty Payment Possibilities");
        // Returning an empty array tells the game there are no special offers to load right now
        return []; 
    }
};