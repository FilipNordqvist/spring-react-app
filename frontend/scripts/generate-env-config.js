const fs = require("fs");

const apiUrl = process.env.REACT_APP_API_URL || "http://localhost:8080";
const content = `window.__ENV__ = ${JSON.stringify({
  REACT_APP_API_URL: apiUrl,
})};\n`;

fs.writeFileSync("/app/build/env-config.js", content);
