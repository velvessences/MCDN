const express = require('express');
const app = express();
const PORT = 8080;

// 1. Log EVERY single request before anything else happens
app.use((req, res, next) => {
    console.log(`\n[NETWORK] ${req.method} ${req.url}`);
    next();
});

// 2. Host the assets
app.use(express.static('public'));

// 3. Read the raw AMF data
app.use(express.raw({ type: '*/*', limit: '50mb' }));

// 4. THE INTERCEPTOR
app.use((req, res) => {
    console.log(`🔥 INCOMING API REQUEST!`);
    
    if (req.body && req.body.length > 0) {
        console.log(`Data Payload: ${req.body.length} bytes received.`);
        
        // Scan the binary data for readable English letters/numbers
        let readableText = req.body.toString('ascii').replace(/[^a-zA-Z0-9_.]/g, ' ');
        // Clean up the extra spaces so it's easier to read
        readableText = readableText.replace(/\s+/g, ' ').trim();
        
        console.log(`Hidden Text:  ${readableText}`);
    }
    console.log('========================================');

    // Still sending a blank OK just to keep the connection open
    res.status(200).send("OK");
});

app.listen(PORT, () => {
    console.log(`🚀 MSP Custom Server is LIVE!`);
    console.log(`📡 Listening on http://localhost:${PORT}`);
    console.log(`Waiting for the game to connect...\n`);
});