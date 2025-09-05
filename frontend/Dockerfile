# Dockerfile for Next.js frontend
FROM node:24-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install # install all deps (dev + prod)
COPY . .
RUN npm run build

FROM node:24-alpine AS runner
WORKDIR /app
COPY --from=builder /app .
RUN rm -rf node_modules # remove all node_modules
RUN npm install --omit=dev # install only prod deps
EXPOSE 8080
ENV PORT=8080
CMD ["npm", "start"]
