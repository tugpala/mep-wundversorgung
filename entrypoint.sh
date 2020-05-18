#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /data/tmp/pids/server.pid

no_rake_task=$NO_RAKE_TASK
if [ "$no_rake_task" == "" ]
then
echo "rake db:migrate start"
RAILS_ENV=$RAILS_ENV bundle exec rake db:migrate
echo "rake db:migrate end"

echo "rake seed:migrate start"
RAILS_ENV=$RAILS_ENV bundle exec rake seed:migrate
echo "rake seed:migrate end"
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
