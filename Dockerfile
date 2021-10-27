FROM ruby:3.0.2-alpine as builder

ARG environment=development
ENV RAILS_ENV=$environment
ENV NODE_ENV=$environment
ENV NODE_OPTIONS=--max_old_space_size=4096

# add packages required to build dependencies
RUN apk --update --no-cache add \
    bash \
    build-base \
    git \
    g++ \
    gnupg \
    imagemagick \
    make \
    postgresql-dev \
    tzdata \
    yarn

RUN mkdir /server
ADD . /server

WORKDIR /server

RUN bundle install --jobs 4 --retry 3
RUN yarn install --no-cache --network-timeout 1000000

ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "c"]
