FROM node:18-alpine
WORKDIR /app
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ .

ENV REACT_APP_API_URL=http://localhost:8080

RUN npm run build

RUN npm install -g serve

CMD ["sh", "-c", "serve -s build -l ${PORT:-3000}"]