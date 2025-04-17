# Stage 1: Build the Vite application
FROM node:18 AS builder
WORKDIR /app

# Copy package files first for better caching
COPY package*.json ./
RUN npm install

# Copy all files and build based on environment
COPY . .
ARG BUILD_ENV=prod
RUN npm run build:${BUILD_ENV}

# Stage 2: Nginx server
FROM nginx:stable-alpine
COPY --from=builder /app/dist /usr/share/nginx/html  # Vite outputs to /dist
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
