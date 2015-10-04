FROM debian:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
	curl \
	unzip \
	apache2 \
	php5 \
	php5-mysql \
	php5-gd \
	supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN curl -o /tmp/fever.zip http://feedafever.com/gateway/public/fever.zip
RUN rm /var/www/html/index.html
RUN unzip -j /tmp/fever.zip -d /var/www/html
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

CMD ["/usr/bin/supervisord"]