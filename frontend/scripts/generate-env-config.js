const fs = require("fs");

const apiUrl = process.env.REACT_APP_API_URL || "http://localhost:8080";
const outputPath = process.env.ENV_CONFIG_PATH || "./build/env-config.js";
const content = `window.__ENV__ = ${JSON.stringify({
  REACT_APP_API_URL: apiUrl,
})};\n`;

fs.writeFileSync(outputPath, content);
