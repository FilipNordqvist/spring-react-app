FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Installera 'serve' för att serva den färdiga build-mappen
RUN npm install -g serve

# Kör på Railways port
CMD ["sh", "-c", "serve -s build -l ${PORT:-3000}"]