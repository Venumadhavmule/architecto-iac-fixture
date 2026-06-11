FROM node:22-alpine AS deps

WORKDIR /app

COPY package.json ./

RUN npm install --omit=dev

FROM node:22-alpine AS runtime

WORKDIR /app

RUN addgroup -S architecto && adduser -S architecto -G architecto

COPY --from=deps /app/node_modules ./node_modules
COPY src ./src

USER architecto

EXPOSE 3000

CMD ["node", "src/server.js"]
