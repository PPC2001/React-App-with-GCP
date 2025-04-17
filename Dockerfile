# Use an official Node image to build the app
FROM node:18 AS builder
WORKDIR /app
COPY . .
RUN npm install && npm run build

# Use nginx to serve the static files
FROM nginx:stable-alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


# Add health check
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget --quiet --tries=1 --spider http://localhost:80/ || exit 1

# Add proper Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf
