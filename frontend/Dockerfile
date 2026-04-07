FROM node:18-alpine
WORKDIR /app
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ .

RUN npm run build

RUN npm install -g serve

CMD ["sh", "-c", "API_URL=\"${REACT_APP_API_URL:-http://localhost:8080}\"; API_URL_ESCAPED=$(printf '%s' \"$API_URL\" | sed 's/[\\\\\"]/\\\\&/g'); printf 'window.__ENV__ = { REACT_APP_API_URL: \"%s\" };\\n' \"$API_URL_ESCAPED\" > /app/build/env-config.js; exec serve -s build -l ${PORT:-3000}"]
