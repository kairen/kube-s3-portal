FROM mhart/alpine-node:6
MAINTAINER Kyle Bai <kyle.b@inwinstack.com>

RUN apk add --no-cache git bash && \
  rm -f /var/cache/apk/* && \
  git clone https://github.com/kairen/s3-portal-ui.git -b demo/fix-user-list /app && \
  cd /app && npm install && npm cache clear && \
  cp config.example.js config.js

COPY entrypoint.sh /usr/local/bin/

WORKDIR /app
EXPOSE 3000 3001

ENTRYPOINT ["entrypoint.sh"]
