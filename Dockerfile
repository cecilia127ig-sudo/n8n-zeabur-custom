FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    bash \
    curl \
    git \
    fontconfig \
    graphicsmagick \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g n8n

RUN mkdir -p /usr/share/fonts/truetype/custom
COPY fonts/ /usr/share/fonts/truetype/custom/
RUN chmod 644 /usr/share/fonts/truetype/custom/* && fc-cache -f -v

RUN useradd -m -u 1000 node
USER node

EXPOSE 5678
WORKDIR /home/node
CMD ["n8n", "start"]
