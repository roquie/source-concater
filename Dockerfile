FROM nginx:mainline-alpine

COPY ./.docker /docker
COPY ./.docker/nginx.conf /etc/nginx/nginx.conf
COPY ./dist/ /usr/share/nginx/html

RUN adduser -D www-data \
    && chown -R www-data:www-data /usr/share/nginx/html \
    && chown -R www-data:www-data /etc/nginx/conf.d

USER www-data
WORKDIR /usr/share/nginx/html

CMD ["/docker/run-nginx.sh"]
