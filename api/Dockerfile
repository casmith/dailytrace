# Dockerfile for NestJS API
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM node:20-alpine AS runner
WORKDIR /app
COPY --from=builder /app .
EXPOSE 8081
ENV PORT=8081
CMD ["npm", "run", "start:prod"]
