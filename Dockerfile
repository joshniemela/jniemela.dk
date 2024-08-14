FROM node:latest as build

WORKDIR /app

COPY package*.json ./

RUN apt-get update && \
    apt-get install -y patchelf
RUN npm install
COPY . ./
RUN npm run build
RUN npm prune --omit=dev
# Move src/lib/hs2048-binary to app
COPY src/lib/hs2048-binary ./

# Remove unnecessary files
RUN rm -rf src static docker-compose.yml


RUN patchelf --set-interpreter /lib64/ld-linux-x86-64.so.2 ./hs2048-binary
# Why do i need this...
ENV LC_ALL=C.UTF-8
ENV HS2048_BINARY_PATH=/app/hs2048-binary
CMD ["node", "./build/index.js"]

