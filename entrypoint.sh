#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

if [ "${RAILS_ENV}" = "production" ]
then
    bundle exec rails assets:precompile RAILS_ENV=production
    bundle exec rails db:migrate RAILS_ENV=production
    bundle exec rails db:seed_fu RAILS_ENV=production
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"