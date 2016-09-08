FROM busybox:latest
MAINTAINER Oskar Hane <oh@oskarhane.com>
RUN mkdir -p /var/lib/mysql && mkdir -p /var/www/html
VOLUME ["/var/lib/mysql", "/var/www/html"]
