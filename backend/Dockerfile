FROM tutum/apache-php

MAINTAINER Kyle Bai (kyle.b@inwinstack.com)

# Install custom PHP application
RUN apt-get update && apt-get install -yq git nmap && rm -rf /var/lib/apt/lists/*
RUN rm -fr /app
RUN cd / && \
    git clone https://github.com/inwinstack/s3-portal-api.git -b dev app && \
    cd /app && composer install && cp .env.example .env && \
    mkdir storage/tmpfile

COPY boot_run.sh /etc/boot_run.sh
COPY s3-backend.conf /etc/apache2/sites-available/s3-backend.conf
RUN chown root.root /etc/boot_run.sh && chmod 700 /etc/boot_run.sh

# Show expose port
EXPOSE 80

ENTRYPOINT ["/etc/boot_run.sh"]
