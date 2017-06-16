#!/usr/bin/env sh

port=${PORT:-8080}
export PORT=$port

envsubst < /docker/site.conf.template > /tmp/site.conf

mv /tmp/site.conf /etc/nginx/conf.d/default.conf

nginx -g "daemon off;"

