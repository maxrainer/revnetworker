FROM neurodebian:nd14.04
MAINTAINER rainer@nts.at

RUN apt-get update && apt-get -y install apache2 && apt-get clean

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_RUN_DIR /var/run/apache2

COPY ./apache-ssl.conf /etc/apache2/sites-enabled/apache-ssl.conf

RUN /bin/mkdir -p /opt/apache/ssl
RUN /bin/ln -sf /etc/apache2/sites-available/default-ssl /etc/apache2/sites-enabled/001-default-ssl
RUN /bin/ln -sf /etc/apache2/mods-available/ssl.conf /etc/apache2/mods-enabled/
RUN /bin/ln -sf /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled/
RUN /bin/ln -sf /etc/apache2/mods-available/proxy.load /etc/apache2/mods-enabled/
RUN /bin/ln -sf /etc/apache2/mods-available/proxy_http.load /etc/apache2/mods-enabled/
RUN /bin/ln -sf /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/
RUN /bin/ln -sf /etc/apache2/mods-available/socache_shmcb.load /etc/apache2/mods-enabled/
RUN /bin/rm -f /etc/apache2/sites-enabled/000-default.conf
RUN /bin/rm -f /etc/apache2/sites-enabled/001-default-ssl

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

EXPOSE 80 443
