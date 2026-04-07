FROM node:18-alpine
WORKDIR /app
COPY . .
RUN if [ -f proxy-ca.crt ]; then \
      cp proxy-ca.crt /etc/ssl/certs/proxy-ca.crt && \
      cat proxy-ca.crt >> /etc/ssl/certs/ca-certificates.crt; \
    fi
ENV NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt
RUN npm install

ARG REACT_APP_API_URL=http://localhost:8080
ENV REACT_APP_API_URL=$REACT_APP_API_URL

RUN npm run build

RUN npm install -g serve

CMD ["sh", "-c", "serve -s build -l ${PORT:-3000}"]