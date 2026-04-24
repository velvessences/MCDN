// services/GetRandomLookByLikes.js
module.exports = {
    execute: function(req) {
        console.log("      => [AMF] Triggering fallback offline avatars");
        // Returning LookId: 0 tricks the game into skipping the database and drawing local avatars!
        return { LookId: 0 }; 
    }
};