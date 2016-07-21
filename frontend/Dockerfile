FROM node:5.11.0

MAINTAINER Kyle Bai (kyle.b@inwinstack.com)

# Install custom application
RUN cd /opt/ && \
    git clone https://github.com/chaoen/s3-portal-ui.git -b feature-user-list app/ && \
    cd app/ && npm install && \
    npm install browser-sync-webpack-plugin@1.0.3 && \
    cp config.example.js config.js

COPY boot_run.sh /etc/boot_run.sh
RUN chown root.root /etc/boot_run.sh && chmod 700 /etc/boot_run.sh

# Show expose port
EXPOSE 3000 3001

ENTRYPOINT ["/etc/boot_run.sh"]
