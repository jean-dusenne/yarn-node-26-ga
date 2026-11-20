# yarn-node-26-ga

This template should help get you started developing with Vue 3 in Vite.

## Recommended IDE Setup

[VS Code](https://code.visualstudio.com/) + [Vue (Official)](https://marketplace.visualstudio.com/items?itemName=Vue.volar) (and disable Vetur).

## Recommended Browser Setup

- Chromium-based browsers (Chrome, Edge, Brave, etc.):
  - [Vue.js devtools](https://chromewebstore.google.com/detail/vuejs-devtools/nhdogjmejiglipccpnnnanhbledajbpd)
  - [Turn on Custom Object Formatter in Chrome DevTools](http://bit.ly/object-formatters)
- Firefox:
  - [Vue.js devtools](https://addons.mozilla.org/en-US/firefox/addon/vue-js-devtools/)
  - [Turn on Custom Object Formatter in Firefox DevTools](https://fxdx.dev/firefox-devtools-custom-object-formatters/)

## Type Support for `.vue` Imports in TS

TypeScript cannot handle type information for `.vue` imports by default, so we replace the `tsc` CLI with `vue-tsc` for type checking. In editors, we need [Volar](https://marketplace.visualstudio.com/items?itemName=Vue.volar) to make the TypeScript language service aware of `.vue` types.

## Customize configuration

See [Vite Configuration Reference](https://vite.dev/config/).

## Yarn Berry Setup

This project uses [Yarn Berry](https://yarnpkg.com/) (v4). Node 26 no longer bundles Corepack, so it must be installed separately:

```sh
npm i -g corepack
corepack enable
```

Corepack then uses the version pinned in the `packageManager` field of `package.json`.

How it was configured (already done, for reference):

```sh
yarn set version stable          # pins "packageManager" in package.json
yarn config set nodeLinker node-modules   # writes .yarnrc.yml
```

`nodeLinker: node-modules` is used instead of the default Plug'n'Play, whose ESM support is experimental and not well supported by Vite, Vitest and IDE tooling.

### Alternatives to Corepack

Corepack is the approach recommended by Yarn, and the one used here (locally, in CI and in Docker). Other options exist to get Yarn Berry on Node 26:

- **`@yarnpkg/cli-dist`**: `npm install -g @yarnpkg/cli-dist@<version>` installs Yarn directly, with no Corepack. The version can be read from `packageManager` with `node -p "require('./package.json').packageManager.split('@')[1].split('+')[0]"`. Simple, but the global install can conflict with a Corepack-managed `yarn` binary.
- **Committed release (`yarnPath`)**: `yarn set version stable --yarn-path` stores the Yarn binary in `.yarn/releases/` and references it from `.yarnrc.yml`. No global install needed beyond Node (`node .yarn/releases/yarn-<version>.cjs`), but it adds a ~3 MB file to the repository and requires un-ignoring `.yarn/releases` (already allowed in `.gitignore`).
- **Another Node version**: Node 24 and below still bundle Corepack, so only `corepack enable` is needed. This defeats the purpose of targeting Node 26.

### Docker

The [Dockerfile](./Dockerfile) builds the app on `node:26-alpine` and serves `dist/` with nginx (with an SPA fallback, see [nginx.conf](./nginx.conf)). Since Node 26 images have no Corepack, so the Dockerfile installs it (`npm install -g corepack && corepack enable`); Yarn is then resolved from `packageManager` in `package.json`, as in CI.

```sh
docker build -t yarn-node-26-ga .
docker run --rm -p 8080:80 yarn-node-26-ga
```

## Project Setup

```sh
yarn
```

### Compile and Hot-Reload for Development

```sh
yarn dev
```

### Type-Check, Compile and Minify for Production

```sh
yarn build
```

### Run Unit Tests with [Vitest](https://vitest.dev/)

```sh
yarn test:unit
```

### Lint with [ESLint](https://eslint.org/)

```sh
yarn lint
```
