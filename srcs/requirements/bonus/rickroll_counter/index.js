// Import required modules
const express = require('express'); // Express framework for creating the web server
const https   = require('https');   // Module to create HTTPS server
const fs      = require('fs');      // File system module to read certificate files
const path    = require('path');

// Create an Express application
const app = express();
// Set the port from environment variable PORT or default to 3000
const port = process.env.PORT || 3000;

// Enable serving static files from the "public" directory
app.use(express.static('public'));

// Middleware to enable CORS for all incoming requests
// This allows the service to be accessed from any origin
app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  next();
});

// Options for the HTTPS server: read the SSL certificate and key from disk
// These files should be located in /app/ssl inside the container
const options = {
  key:  fs.readFileSync('/app/ssl/server.key'), // Private key for SSL
  cert: fs.readFileSync('/app/ssl/server.crt')  // SSL certificate
};

// The path to the file containing the number of rolls.
const counterFilePath = path.join(__dirname, 'counter.txt');

// Function to load the counter value from file, defaulting to 0 if not present
function loadCounter() {
  try {
    const data = fs.readFileSync(counterFilePath, 'utf8');
    return parseInt(data, 10) || 0;
  } catch (err) {
    return 0;
  }
}

// Function to save the counter value to file
function saveCounter(value) {
  fs.writeFileSync(counterFilePath, value.toString());
}

// Variable for counting rolls.
let rickrollCount = loadCounter();

// Endpoint to trigger (increment) the Rickroll counter
// Each GET request to /rickroll increases the counter by one and returns the new count
app.get('/rickroll', (req, res) => {
  rickrollCount++;
  console.log(`Counter incremented: ${rickrollCount}`);
  saveCounter(rickrollCount);
  res.send(`${rickrollCount}`);
});

// Endpoint to retrieve the current counter value without incrementing it
app.get('/counter', (req, res) => {
  res.send(`${rickrollCount}`);
});

// Optional landing page for the counter service with a custom background image
app.get('/', (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <title>Rickroll Counter</title>
      <style>
        /* Styling for the landing page with a custom background image */
        body {
          font-family: Arial, sans-serif;
          text-align: center;
          padding: 20px;
          background: url('/rick-bg.jpg') no-repeat center center fixed;
          background-size: cover;
          color: #fff;
        }
        h1 {
          color: #0af;
        }
        a {
          color: #0af;
          text-decoration: none;
          font-size: 1.2em;
        }
        a:hover {
          text-decoration: underline;
        }
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

// Create an HTTPS server using the provided SSL options and the Express app,
// and start listening on the specified port
https.createServer(options, app).listen(port, () => {
  console.log(`Rickroll Counter Service (HTTPS) listening on port ${port}`);
});