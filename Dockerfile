FROM node:14-alpine as start
RUN apk add chromium
ENV NODE_ENV=development
ENV CHROME_BIN=/usr/bin/chromium-browser
WORKDIR /usr/src/app
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
RUN npm ci --cache ~/.npm --prefer-offline

FROM start as test
WORKDIR /usr/src/app
COPY . .
RUN npm run test:ci