FROM nginx:stable

RUN apt-get update && \
    apt-get install -qq -y netcat --fix-missing --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /static

COPY ./nginx/wait-for.sh /bin/wait-for
COPY ./nginx/entrypoint.sh /entrypoint.sh
COPY ./nginx/nginx.tmpl /etc/nginx/nginx.tmpl
COPY ./public /static

ENTRYPOINT /entrypoint.sh
