FROM n8nio/n8n:latest

# Устанавливаем Puppeteer и его браузер
USER root
RUN npm install puppeteer
RUN npx puppeteer browsers install chrome

# Возвращаем пользователя n8n
USER node

# Запускаем n8n как обычно
CMD ["n8n"]