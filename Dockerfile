FROM ruby:2.5.1

RUN apt-get update && \
    apt-get install -y nodejs

ENV APP_HOME /app
ENV RAILS_ENV development

RUN mkdir $APP_HOME
COPY . $APP_HOME
WORKDIR $APP_HOME

RUN gem install bundler && \
    bundle install

EXPOSE 3000
CMD ["rails", "s", "-b", "0.0.0.0", "-p", "3000"]