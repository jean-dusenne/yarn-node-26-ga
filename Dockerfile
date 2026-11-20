# syntax=docker/dockerfile:1

# Node 26 images no longer ship Corepack: it is installed explicitly, then Yarn
# is resolved from the "packageManager" field of package.json.
FROM node:26-alpine AS build
WORKDIR /app
RUN npm install -g corepack && corepack enable

COPY package.json yarn.lock .yarnrc.yml ./
RUN yarn install --immutable

COPY . .
RUN yarn build-only

FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
