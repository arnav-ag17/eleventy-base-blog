# ---- Build & Serve Eleventy static site ----
FROM node:20-alpine

# Avoid interactive prompts; speed up npm
ENV NODE_ENV=production \
    NPM_CONFIG_FUND=false \
    NPM_CONFIG_AUDIT=false \
    PORT=8080

WORKDIR /app

# Install deps
COPY package*.json ./
RUN npm ci

# Copy source and build
COPY . .
RUN npm run build   # outputs to ./_site

# Lightweight static server
RUN npm i -g http-server

EXPOSE 8080
CMD ["http-server", "_site", "-p", "8080", "-a", "0.0.0.0"]
