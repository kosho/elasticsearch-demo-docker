#!/bin/bash
set -e

if [ "$1" = 'elasticsearch' ]; then
  exec gosu elasticsearch "$@" &
  exec gosu elasticsearch kibana
fi

exec "$@"

