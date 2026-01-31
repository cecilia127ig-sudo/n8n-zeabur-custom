FROM docker.n8n.io/n8nio/n8n:1.121.2

USER root

# Chromium + 依賴 + 中文字體
RUN apk add --no-cache \
  chromium \
  nss \
  freetype \
  harfbuzz \
  ca-certificates \
  ttf-freefont \
  fontconfig \
  noto-fonts-cjk

# 安裝 Puppeteer community node
RUN npm install n8n-nodes-puppeteer

# 指定 puppeteer 用系統 chromium（唔好去搵/下載 Chrome 144）
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

USER node
