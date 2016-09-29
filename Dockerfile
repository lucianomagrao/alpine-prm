FROM alpine:3.4

MAINTAINER Luciano Mores <leslau@gmail.com>

ADD exclude /
ADD config-rsyncd-crond /
ADD lighttpd.conf /etc/lighttpd/lighttpd.conf

RUN \
		apk update && \
		apk add --no-cache rsync lighttpd && \
		mkdir -p /var/www/localhost/htdocs/alpine/

EXPOSE 80

VOLUME /var/www/localhost/htdocs/alpine/

ENTRYPOINT [ "/config-rsyncd-crond" ]

CMD [ "lighttpd", "-f", "/etc/lighttpd/lighttpd.conf", "-D" ]
