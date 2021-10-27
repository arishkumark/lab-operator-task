#!/usr/bin/env bash

yarn install --no-cache --network-timeout 1000000

bundle exec "$@"
