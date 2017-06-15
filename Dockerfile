FROM nginx:mainline-alpine

COPY ./dist/ /usr/share/nginx/html
