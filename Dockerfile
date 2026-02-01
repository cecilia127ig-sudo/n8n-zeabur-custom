FROM n8nio/n8n:latest

USER root
RUN apt-get update && apt-get install -y fontconfig && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /usr/share/fonts/truetype/custom
COPY fonts/ /usr/share/fonts/truetype/custom/
RUN chmod 644 /usr/share/fonts/truetype/custom/* && fc-cache -f -v
USER node
