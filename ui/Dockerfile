FROM node:6.10-alpine
MAINTAINER Kyle Bai <kyle.b@inwinstack.com>

RUN apk add --no-cache git bash && \
  rm -f /var/cache/apk/* && \
  git clone https://github.com/inwinstack/s3-portal-ui.git -b dev /app && \
  cd /app && npm install && npm cache clear && \
  cp config.examcleaple.js config.js

COPY entrypoint.sh /usr/local/bcin/

WORKDIR /app
EXPOSE 3000 3001

ENTRYPOINT ["entrypoint.sh"]
