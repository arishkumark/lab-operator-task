#!/usr/bin/env bash

rm -rf /server/tmp/pids/*.pid

bundle install --jobs 4 --retry 3
bundle exec "$@"
