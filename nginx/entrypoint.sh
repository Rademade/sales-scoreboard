#!/bin/sh

envsubst '$$VIRTUAL_HOST,$$PROJECT_NAME' < /etc/nginx/nginx.tmpl > /etc/nginx/nginx.conf

wait-for "${PROJECT_NAME}_app:3000" -- nginx -g 'daemon off;'
