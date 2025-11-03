# Официальная лёгкая коробка n8n
FROM n8nio/n8n:latest

# Переключаемся на root, чтобы ставить пакеты
USER root

# 1. Ставим Puppeteer глобально
# 2. Качаем Chrome
# 3. Ставим нужные системные штуки через apk (а не apt-get!)
RUN npm install -g puppeteer@latest \
    && npx puppeteer browsers install chrome \
    && apk add --no-cache \
        dumb-init \
        ca-certificates \
        fontconfig \
        freetype \
        ttf-dejavu \
        ttf-droid \
        ttf-freefont \
        ttf-liberation

# Чиним права на конфиг (чтоб не ныло)
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# Возвращаемся к обычному юзеру
USER node

# Запускаем n8n правильно
ENTRYPOINT ["dumb-init", "--"]
CMD ["n8n", "start"]
