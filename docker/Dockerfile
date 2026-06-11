FROM node:22-alpine

WORKDIR /app

RUN addgroup -S architecto && adduser -S architecto -G architecto

COPY package.json ./

RUN npm install --omit=dev

COPY src ./src

USER architecto

EXPOSE 3000

CMD ["node", "src/server.js"]

