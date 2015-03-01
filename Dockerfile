FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev redis-server
RUN mkdir /uyd
WORKDIR /uyd
ADD Gemfile /uyd/Gemfile
ADD . /uyd

EXPOSE 3000
RUN bundle install
RUN rake db:setup
RUN rails s