# Берём официальную коробку n8n
FROM n8nio/n8n:latest

# Ставим Puppeteer и браузер
USER root
RUN npm install -g puppeteer@latest \
    && npx puppeteer browsers install chrome \
    && apt-get update && apt-get install -y dumb-init

# Чиним права на конфиг (чтоб не ругался)
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# Возвращаемся к обычному юзеру
USER node

# Запускаем n8n через dumb-init (чтоб команда "n8n" работала)
ENTRYPOINT ["dumb-init", "--"]
CMD ["n8n", "start"]
