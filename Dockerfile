FROM node:latest as build

WORKDIR /app

COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build
RUN npm prune --omit=dev
# Remove unnecessary files
RUN rm -rf src static docker-compose.yml

CMD ["node", "./build/index.js"]

