# TODO: написать нормальный dockerfile
FROM ruby:3.1.0

RUN gem install bundler -v 2.3.3

WORKDIR /app
COPY . ./

RUN bundle config build.nokogiri --use-system-libraries
RUN bundle check || bundle install

CMD ["ruby", "exe/app"]
