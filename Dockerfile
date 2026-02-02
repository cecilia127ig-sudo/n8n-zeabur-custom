FROM debian:bookworm-slim

# Install Node.js
RUN apt-get update && apt-get install -y \
    curl \
    git \
&& curl -fsSL https://deb.nodesource.com/setup_20.x | sh - \
&& apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install fontconfig
RUN apt-get update && apt-get install -y fontconfig && rm -rf /var/lib/apt/lists/*

# Install n8n globally
RUN npm install -g n8n

# Create fonts directory
RUN mkdir -p /usr/share/fonts/truetype/custom
COPY fonts/ /usr/share/fonts/truetype/custom/
RUN chmod 644 /usr/share/fonts/truetype/custom/* && fc-cache -f -v

# Create n8n user
RUN useradd -m -u 1000 node
USER node

EXPOSE 3000
WORKDIR /home/node
CMD ["n8n", "start"]
