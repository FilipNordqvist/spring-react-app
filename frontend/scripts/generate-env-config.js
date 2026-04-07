const fs = require("fs");

const defaultApiUrl = "http://localhost:8080";
const rawApiUrl = process.env.REACT_APP_API_URL || defaultApiUrl;
let apiUrl = defaultApiUrl;

try {
  const parsed = new URL(rawApiUrl);
  if (parsed.protocol === "http:" || parsed.protocol === "https:") {
    apiUrl = parsed.href.replace(/\/$/, "");
  } else {
    console.warn(
      `Unsupported protocol in REACT_APP_API_URL (${parsed.protocol}), using default`
    );
  }
} catch (error) {
  console.warn(`Invalid REACT_APP_API_URL, using default: ${error.message}`);
}

const outputPath = process.env.ENV_CONFIG_PATH || "./build/env-config.js";
const content = `window.__ENV__ = ${JSON.stringify({
  REACT_APP_API_URL: apiUrl,
})};\n`;

try {
  fs.writeFileSync(outputPath, content);
} catch (error) {
  console.error(`Failed to write env config to ${outputPath}: ${error.message}`);
  process.exit(1);
}
