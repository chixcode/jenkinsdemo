FROM huttopia/nginx-php-fpm

#Allows us to run lsof, the update repositories seem to be outof date.
# lsof -i :8080 should show nginx runs
RUN apt-get update
RUN apt-get install -y lsof
RUN apt-get install -y vim


# Mark index as index.php and listen on port 8080
EXPOSE 8080

# Copy our default configuration and override the default
COPY default /etc/nginx/sites-enabled/default

# To enable logs
RUN mkdir -p /var/log/app_engine/
# Copy so that health check alwars returns ok. This is only needed when running in managed VM mode on Google cloud
COPY ok /usr/share/nginx/www/_ah/start
COPY ok /usr/share/nginx/www/_ah/health

#Copy source code
ADD www/ /usr/share/nginx/www/

