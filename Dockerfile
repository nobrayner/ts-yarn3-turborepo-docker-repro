FROM node:16-slim as base

# Create app directory
WORKDIR /app

RUN apt-get update
COPY . /app

RUN npm install -g turbo && \
    turbo prune --scope=@scope/some-service && \
    cp -R .yarn .yarnrc.yml yarn.lock tsconfig.json out/ && \
    cd out && \
    yarn install && \
    yarn build --filter=@scope/some-service && \
    yarn plugin import workspace-tools && \
    yarn workspaces focus --all --production && \
    rm -rf node_modules/.cache .yarn/.cache .turbo src && \
    find ./services ./packages \( -name "src" -o -name ".turbo" \) -type d -exec rm -rf {} +



FROM node:16-slim as some-service

ENV NODE_ENV=production

WORKDIR /app

COPY --chown=node:node --from=base /app/out .

WORKDIR /app/services/some-service

CMD ["yarn", "start"]
