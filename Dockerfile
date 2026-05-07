# Build stage
FROM node:24-alpine AS builder

WORKDIR /build

# Install pnpm
RUN npm install -g pnpm@9.10.0

# Copy backend files
COPY backend/package.json backend/pnpm-lock.yaml ./

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy source
COPY backend/src ./src
COPY backend/medusa-config.ts ./medusa-config.ts
COPY backend/tsconfig.json ./tsconfig.json

# Build
RUN pnpm build || true

# Runtime stage
FROM node:24-alpine

WORKDIR /app

# Install pnpm
RUN npm install -g pnpm@9.10.0

# Copy from builder
COPY --from=builder /build/node_modules ./node_modules
COPY --from=builder /build/dist ./dist
COPY --from=builder /build/package.json ./package.json
COPY --from=builder /build/pnpm-lock.yaml ./pnpm-lock.yaml

# Copy src for runtime
COPY backend/src ./src
COPY backend/medusa-config.ts ./medusa-config.ts

# Expose port
EXPOSE 9000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD node -e "require('http').get('http://localhost:9000/health', (r) => {if (r.statusCode !== 200) throw new Error(r.statusCode)})"

# Start
CMD ["pnpm", "start"]
