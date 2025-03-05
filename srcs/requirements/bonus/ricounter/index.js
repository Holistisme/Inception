/******************************************************************************
 * A Node.js/Express service that manages a Rickroll counter over HTTPS.
 * - Serves static files from /public.
 * - Maintains a counter in a text file.
 * - Provides endpoints for triggering and viewing the counter.
 ******************************************************************************/
const express = require('express');
const https   = require('https');
const fs      = require('fs');
const path    = require('path');

const app  = express();
const port = process.env.PORT || 3000;

// Serve any static files in /public
app.use(express.static('public'));

// Allow CORS for demonstration purposes
app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  next();
});

// SSL key/cert paths
const options = {
  key:  fs.readFileSync('/app/ssl/server.key'),
  cert: fs.readFileSync('/app/ssl/server.crt')
};

// File where the counter is stored
const counterFilePath = path.join(__dirname, 'counter.txt');

// Load the current counter from disk
function loadCounter() {
  try {
    const data = fs.readFileSync(counterFilePath, 'utf8');
    return parseInt(data, 10) || 0;
  } catch (err) {
    return 0;
  }
}

// Save the counter value to disk
function saveCounter(value) {
  fs.writeFileSync(counterFilePath, value.toString());
}

let rickrollCount = loadCounter();

// Endpoint that increments the counter
app.get('/rickroll', (req, res) => {
  rickrollCount++;
  console.log(`Counter incremented: ${rickrollCount}`);
  saveCounter(rickrollCount);
  res.send(`${rickrollCount}`);
});

// Endpoint that returns the current counter
app.get('/counter', (req, res) => {
  res.send(`${rickrollCount}`);
});

// Default route (simple HTML page)
app.get('/', (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <title>Rickroll Counter</title>
      <style>
        body {
          font-family: Arial, sans-serif;
          text-align: center;
          padding: 20px;
          background: url('/rick-bg.jpg') no-repeat center center fixed;
          background-size: cover;
          color: #fff;
        }
        h1 { color: #0af; }
        a {
          color: #0af;
          text-decoration: none;
          font-size: 1.2em;
        }
        a:hover { text-decoration: underline; }
      </style>
    </head>
    <body>
      <h1>Rickroll Counter</h1>
      <p>Rickroll count: <strong>${rickrollCount}</strong></p>
      <p><a href="/rickroll">Trigger Rickroll</a></p>
    </body>
    </html>
  `);
});

// Start the HTTPS server
https.createServer(options, app).listen(port, () => {
  console.log(`Rickroll Counter Service (HTTPS) listening on port ${port}`);
});