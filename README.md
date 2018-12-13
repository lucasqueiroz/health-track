# Health Track ![](/coverage/coverage.svg) [![CircleCI](https://circleci.com/bb/lucasqueiroz/health-track/tree/master.svg?style=svg&circle-token=cfd713cfc28a0ca72bc0ead44b5926b17b5da682)](https://circleci.com/bb/lucasqueiroz/health-track/tree/master)

Health Track is a system for you to log your weight, height, workouts and eaten foods!
It makes it easier for you to keep track of your health.

You can check the project in production by following [this](https://healthtrack-demo.herokuapp.com) link.

## How to run it locally?

Health Track requires you to have docker and docker-compose installed on your machine.

1. Build the project
    1. Run `docker-compose build`
2. Migrate the database
    1. Run `docker-compose run web rake db:migrate`
3. Start the server
    1. Run `docker-compose up`
    2. You can now go to http://localhost:3000 and check the interface


## How to run the unit tests?

1. Build the project, if not done before
    1. Run `docker-compose build`
2. Migrate the database
    1. Run `docker-compose run --rm -e RAILS_ENV=test web rake db:migrate`
3. Run the tests
    1. Run `docker-compose run --rm -e RAILS_ENV=test web bundle exec rspec`

## API Documentation

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/132206963a3e58183c3d)

You can either click the `Run in Postman` button, or follow [this](https://documenter.getpostman.com/view/5305390/RzfjnU4L) link for a documentation.

## What technologies does it use?

1. Ruby (2.5.1)
2. Rails (5.2.2)
3. RSpec for unit tests
4. SimpleCov for test coverage
5. Heroku for production deployment
6. CircleCI for continuous integration
7. Docker and docker-compose for development server and database