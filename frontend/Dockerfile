FROM node:18-alpine
WORKDIR /app
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ .

RUN npm run build

RUN npm install -g serve

CMD ["sh", "-c", "printf 'window.__ENV__ = { REACT_APP_API_URL: \"%s\" };\\n' \"${REACT_APP_API_URL:-http://localhost:8080}\" > /app/build/env-config.js && serve -s build -l ${PORT:-3000}"]
