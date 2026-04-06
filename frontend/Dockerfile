# Stage 1: Build
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve med Nginx
FROM nginx:stable-alpine
# Kopiera den byggda mappen (dist för Vite, build för CRA)
COPY --from=build /app/dist /usr/share/nginx/html
# Kopiera en enkel nginx-config för att hantera React-routing (valfritt men bra)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]