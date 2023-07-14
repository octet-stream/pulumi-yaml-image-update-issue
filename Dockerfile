FROM node:20-alpine as base

RUN apk add --no-cache libc6-compat
RUN npm i -g pnpm@8

FROM base as build

RUN mkdir -p /usr/src/pulumi-yaml-image-update-issue
WORKDIR /usr/src/pulumi-yaml-image-update-issue

COPY package.json /usr/src/pulumi-yaml-image-update-issue/
COPY pnpm-lock.yaml /usr/src/pulumi-yaml-image-update-issue/

RUN pnpm i --frozen-lockfile --ignore-scripts

COPY . /usr/src/pulumi-yaml-image-update-issue/

RUN pnpm build

FROM base as run

RUN mkdir -p /usr/opt/pulumi-yaml-image-update-issue

COPY --from=build /usr/src/pulumi-yaml-image-update-issue/dist /usr/opt/pulumi-yaml-image-update-issue/dist/
COPY --from=build /usr/src/pulumi-yaml-image-update-issue/public /usr/opt/pulumi-yaml-image-update-issue/public/
COPY --from=build /usr/src/pulumi-yaml-image-update-issue/package.json /usr/opt/pulumi-yaml-image-update-issue/
COPY --from=build /usr/src/pulumi-yaml-image-update-issue/pnpm-lock.yaml /usr/opt/pulumi-yaml-image-update-issue/

WORKDIR /usr/opt/pulumi-yaml-image-update-issue

RUN pnpm i -P --frozen-lockfile --ignore-scripts
# RUN echo "Success"

ENV HOST=0.0.0.0
ENV PORT=3000

EXPOSE 3000
CMD ["pnpm", "run", "start"]
