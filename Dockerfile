FROM node:22-alpine AS base
# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
RUN apk add --no-cache libc6-compat

# Enable corepack to use pnpm
RUN corepack enable

WORKDIR /app

FROM base AS deps
COPY . .
RUN pnpm install && pnpm store prune
RUN npm run build
ENV NODE_ENV production
ENV PORT 3000
EXPOSE 3000
CMD ["npm", "run", "start"]

