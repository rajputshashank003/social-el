#!/usr/bin/env bash
set -o errexit  # Exit on error
chmod +x bin/rails
bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
