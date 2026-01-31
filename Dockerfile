FROM docker.n8n.io/n8nio/n8n:1.121.2

USER root

RUN apk add --no-cache \
  chromium \
  nss \
  freetype \
  harfbuzz \
  ca-certificates \
  ttf-freefont \
  fontconfig
# 下載 Noto CJK（繁中 TC）字體，放入系統 fonts 目錄，更新 font cache
RUN apk add --no-cache curl unzip && \
  mkdir -p /usr/share/fonts/noto-cjk && \
  curl -L -o /tmp/NotoSansCJKtc-hinted.zip \
    https://github.com/notofonts/noto-cjk/releases/latest/download/NotoSansCJKtc-hinted.zip && \
  unzip -o /tmp/NotoSansCJKtc-hinted.zip -d /usr/share/fonts/noto-cjk && \
  rm -f /tmp/NotoSansCJKtc-hinted.zip && \
  fc-cache -f

RUN npm install n8n-nodes-puppeteer

ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

USER node
