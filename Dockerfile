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
