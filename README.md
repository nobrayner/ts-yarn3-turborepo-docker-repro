# ts-yarn3-turborepo-docker-repro
A small repro of issues trying to setup a monorepo

# Context
After a `yarn install`, `yarn dev` works fine and runs the service with nodemon with no issues.

The problem comes when trying to build the service and turn it into a Docker image. Try running `docker-compose up --build` to build the image.

Error that keeps occuring is as follows:
```
Building some-service
Sending build context to Docker daemon  151.1MB
Step 1/11 : FROM node:slim as base
 ---> 4948d3c1f469
Step 2/11 : WORKDIR /app
 ---> Using cache
 ---> 2e82236cc266
Step 3/11 : RUN apt-get update
 ---> Using cache
 ---> cf92dd7476c8
Step 4/11 : COPY . /app
 ---> 3446778f1076
Step 5/11 : RUN npm install -g turbo &&     turbo prune --scope=@scope/some-service &&     cp -R .yarn .yarnrc.yml tsconfig.json out/ &&     cd out &&     yarn install &&     yarn build --filter=@scope/some-service &&     yarn plugin import workspace-tools &&     yarn workspaces focus --all --production &&     rm -rf node_modules/.cache .yarn/.cache
 ---> Running in b11e4d08ea40

added 2 packages, and audited 3 packages in 6s

found 0 vulnerabilities
npm notice 
npm notice New minor version of npm available! 8.15.0 -> 8.17.0
npm notice Changelog: <https://github.com/npm/cli/releases/tag/v8.17.0>
npm notice Run `npm install -g npm@8.17.0` to update!
npm notice 
Generating pruned monorepo for @scope/some-service in /app/out
 - Added @scope/some-service
 - Added @scope/utils
Internal Error: Assertion failed: Expected the lockfile entry to have a resolution field (@cspotcode/source-map-support@npm:^0.8.0)
    at ze.setupResolutions (/app/out/.yarn/releases/yarn-3.2.2.cjs:439:579)
    at async ze.find (/app/out/.yarn/releases/yarn-3.2.2.cjs:436:1533)
    at async um.execute (/app/out/.yarn/releases/yarn-3.2.2.cjs:499:12090)
    at async um.validateAndExecute (/app/out/.yarn/releases/yarn-3.2.2.cjs:345:673)
    at async ws.run (/app/out/.yarn/releases/yarn-3.2.2.cjs:359:2087)
    at async ws.runExit (/app/out/.yarn/releases/yarn-3.2.2.cjs:359:2271)
    at async i (/app/out/.yarn/releases/yarn-3.2.2.cjs:446:12696)
    at async t (/app/out/.yarn/releases/yarn-3.2.2.cjs:446:10914)
The command '/bin/sh -c npm install -g turbo &&     turbo prune --scope=@scope/some-service &&     cp -R .yarn .yarnrc.yml tsconfig.json out/ &&     cd out &&     yarn install &&     yarn build --filter=@scope/some-service &&     yarn plugin import workspace-tools &&     yarn workspaces focus --all --production &&     rm -rf node_modules/.cache .yarn/.cache' returned a non-zero code: 1
ERROR: Service 'some-service' failed to build : Build failed
```
