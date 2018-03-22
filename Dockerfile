FROM ruby:2.5

RUN apt-get update && \
    apt-get install -qq -y netcat openssh-client build-essential apt-utils libcurl4-openssl-dev libssl-dev --fix-missing --no-install-recommends && \
    (curl -sS https://deb.nodesource.com/setup_8.x | bash -) && \
    (curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -) && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn nodejs libpq-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV NODE_ENV production
ENV RAILS_ENV production
ENV RACK_ENV production
ENV INSTALL_PATH /app

RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

COPY . .

RUN bundle install --without development test

EXPOSE 3000

ENTRYPOINT ./bin/entrypoint.sh
