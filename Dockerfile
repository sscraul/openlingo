FROM oven/bun:1

WORKDIR /app

COPY package.json bun.lock ./
RUN bun install --frozen-lockfile

COPY . .
RUN BETTER_AUTH_BASE_URL=http://localhost:3000 \
    BETTER_AUTH_SECRET=build-only-secret-change-at-runtime \
    OPENAI_API_KEY=build-only-key \
    bun run build

ENV NODE_ENV=production
ENV HOSTNAME=0.0.0.0
ENV PORT=3000

EXPOSE 3000

CMD ["bun", "run", "start"]
