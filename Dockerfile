FROM n8nio/n8n:latest

USER root
RUN apk add --no-cache fontconfig
RUN mkdir -p /usr/share/fonts/truetype/custom
COPY fonts/ /usr/share/fonts/truetype/custom/
RUN chmod 644 /usr/share/fonts/truetype/custom/* && fc-cache -f -v
USER node
