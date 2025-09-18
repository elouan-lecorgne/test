# Build backend
FROM golang:1.21-alpine AS backend
WORKDIR /app
COPY backend/ ./
RUN go mod tidy && go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

# Build frontend
FROM node:18-alpine AS frontend
WORKDIR /app
COPY frontend/ ./
RUN npm ci && npm run build

# Final image
FROM alpine:latest
RUN apk --no-cache add ca-certificates nginx
WORKDIR /root/

# Copy backend
COPY --from=backend /app/main ./

# Copy frontend
COPY --from=frontend /app/build /var/www/html

# Nginx config
RUN echo 'events{worker_connections 1024;}http{server{listen 80;root /var/www/html;index index.html;location /{try_files $uri $uri/ /index.html;}location /api{proxy_pass http://127.0.0.1:8080;}}}' > /etc/nginx/nginx.conf

# Start script
RUN echo '#!/bin/sh\n./main &\nnginx -g "daemon off;"' > /start.sh && chmod +x /start.sh

EXPOSE 80
CMD ["/start.sh"]