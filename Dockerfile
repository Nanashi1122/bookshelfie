FROM ruby:3.3.0

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -

RUN apt-get update -qq && \
    apt-get install -y nodejs default-mysql-client && \
    npm install -g yarn


WORKDIR /bookshelfie

COPY Gemfile /bookshelfie/Gemfile
COPY Gemfile.lock /bookshelfie/Gemfile.lock

RUN bundle install

COPY . /bookshelfie

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
