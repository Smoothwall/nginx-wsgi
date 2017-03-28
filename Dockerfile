FROM nginx:1.11

RUN apt-get update -qq
RUN apt-get install -y \
	python3-dev \
	python3-pip \
	supervisor \
 && apt-get clean

# Install uWSGI
RUN pip3 install uwsgi
RUN rm /etc/nginx/conf.d/default.conf

# COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/conf.d/
COPY uwsgi.ini /etc/uwsgi/uwsgi.ini
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf


CMD ["/usr/bin/supervisord"]