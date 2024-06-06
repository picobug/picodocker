FROM alpine
RUN apk add --no-cache chromium nodejs npm && npm i -g puppeteer && npm cache clean --force && rm -rf /root/.cache && rm -rf /root/.npm
