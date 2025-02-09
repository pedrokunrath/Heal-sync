# This Dockerfile uses Fullstaq Ruby with jemalloc and only supports amd64.
FROM buildpack-deps:20.04

ARG RUBY_VERSION=3.3.0-jemalloc
ENV RAILS_ENV=development
ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_PATH="$GEM_HOME"
ENV BUNDLE_SILENCE_ROOT_WARNING=1
ENV BUNDLE_APP_CONFIG="$GEM_HOME"
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH $GEM_HOME/bin:$BUNDLE_PATH/gems/bin:/usr/lib/fullstaq-ruby/versions/${RUBY_VERSION}/bin:$PATH

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends imagemagick libpq-dev \
    fonts-inter fonts-liberation ca-certificates libasound2 libatk-bridge2.0-0 libatk1.0-0 libc6 libcairo2 libcups2 \
    libdbus-1-3 libexpat1 libfontconfig1 libgbm1 libgcc1 libglib2.0-0 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0  \
    libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6  \
    libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 lsb-release wget xdg-utils && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt

RUN curl -SLf https://raw.githubusercontent.com/fullstaq-labs/fullstaq-ruby-server-edition/main/fullstaq-ruby.asc | apt-key add - && \
    echo "deb https://apt.fullstaqruby.org ubuntu-20.04 main" > /etc/apt/sources.list.d/fullstaq-ruby.list && \
    apt-get update -q && \
    apt-get install --assume-yes -q --no-install-recommends fullstaq-ruby-${RUBY_VERSION} && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt

ARG BUNDLER_VERSION=2.5.3
RUN gem install "bundler:~>$BUNDLER_VERSION" --no-document && \
    gem update --system && \
    gem cleanup

ARG NODE_VERSION=20.12.2
RUN curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
  && tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
  && rm "node-v$NODE_VERSION-linux-x64.tar.xz" \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs

ARG YARN_VERSION=1.22.22
RUN curl -fsSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
  && mkdir -p /opt \
  && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/ \
  && ln -s /opt/yarn-v$YARN_VERSION/bin/yarn /usr/local/bin/yarn \
  && ln -s /opt/yarn-v$YARN_VERSION/bin/yarnpkg /usr/local/bin/yarnpkg \
  && rm yarn-v$YARN_VERSION.tar.gz

# App
WORKDIR /app
COPY ./Gemfile* /app/
RUN bundle config --local without "production test omit" && bundle install --jobs $(nproc) --retry 5
COPY package.json yarn.lock /app/
RUN yarn install
COPY docker-entrypoint.sh /app/docker-entrypoint.sh
COPY . /app

RUN bin/rails assets:precompile
RUN yarn build
RUN yarn build:css
RUN chmod ug+x /app/docker-entrypoint.sh

ENTRYPOINT [ "/app/docker-entrypoint.sh" ]
CMD [ "bin/rails", "s", "-p", "3000", "-b", "0.0.0.0" ]

EXPOSE 3000
