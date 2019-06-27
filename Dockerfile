FROM ruby:2.6

RUN apt-get update && \
    apt-get install -y netcat openssh-client build-essential wget git-core libssl-dev libxml2 libxml2-dev libxslt1-dev libpq-dev && \
    (curl -sS https://deb.nodesource.com/setup_10.x | bash -) && \
    (curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -) && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn nodejs --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /app
RUN mkdir -p /root/.ssh/

WORKDIR /app

RUN ssh-keyscan -H github.com >> ~/.ssh/known_hosts

ENV GEM_HOME /app/vendor/bundle
ENV PATH $GEM_HOME/bin:$PATH
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_BIN $GEM_HOME/bin

RUN gem install bundler && \
    bundle config --global path "$BUNDLE_PATH" && \
    bundle config --global bin "$BUNDLE_BIN"
