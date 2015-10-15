FROM nginx
MAINTAINER Michael Boudreau <mkboudreau@yahoo.com>

RUN apt-get update && apt-get install -y wget vim

### INSTALL CONFD
RUN wget https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64
RUN mv confd-0.10.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd
RUN mkdir -p /etc/confd/conf.d /etc/confd/templates /etc/nginx/sites-enabled

COPY nginx.conf /etc/nginx/nginx.conf
COPY app-nginx.tmpl /etc/confd/templates/app-nginx.tmpl
COPY app-nginx.toml /etc/confd/conf.d/app-nginx.toml
COPY nginx-run.sh /

EXPOSE 80 443

ENTRYPOINT ["/nginx-run.sh"]
