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

# 下載 Noto Sans CJK TC（繁中）OTF，放入系統 fonts 目錄，更新 font cache
RUN apk add --no-cache curl fontconfig && \
  mkdir -p /usr/share/fonts/noto-cjk && \
  curl -L -o /usr/share/fonts/noto-cjk/NotoSansCJKtc-Regular.otf \
    https://raw.githubusercontent.com/googlefonts/noto-cjk/main/Sans/OTF/TraditionalChinese/NotoSansCJKtc-Regular.otf && \
  fc-cache -f



RUN npm install n8n-nodes-puppeteer

ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

USER node
