FROM ruby:2.6.3-stretch

WORKDIR /app

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get update \
    && apt-get install -y nodejs mysql-client sudo

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list \
    && sudo apt-get update && sudo apt-get install yarn

COPY Gemfile Gemfile.lock /app/

RUN gem install bundler -v 2.1.4 && bundle install -j4 

EXPOSE 3000
VOLUME /app