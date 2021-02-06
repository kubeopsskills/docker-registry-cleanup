#!/bin/bash
#
# A helper script for ENTRYPOINT.

set -e

[[ ${DEBUG} == true ]] && set -x

if [ -n "${DELAYED_START}" ]; then
  sleep ${DELAYED_START}
fi

# ----- Crontab Generation ------
cleanup_croninterval="1 0 0 * * *"

if [ -n "${CLEANUP_INTERVAL}" ]; then
  case "$CLEANUP_INTERVAL" in
    hourly)
      cleanup_croninterval='@hourly'
    ;;
    daily)
      cleanup_croninterval='@daily'
    ;;
    weekly)
      cleanup_croninterval='@weekly'
    ;;
    monthly)
      cleanup_croninterval='@monthly'
    ;;
    yearly)
      cleanup_croninterval='@yearly'
    ;;
    *)
      cleanup_croninterval="1 0 0 * * *"
    ;;
  esac
fi

if [ -n "${CLEANUP_CRONSCHEDULE}" ]; then
  cleanup_croninterval=${CLEANUP_CRONSCHEDULE}
fi

# ----- Cron Start ------

if [ "$1" = 'cron' ]; then
  exec /usr/bin/go-cron "${cleanup_croninterval}" /bin/bash -c "/usr/bin/dockercleanup.d/docker-registry-cleanup.sh"
fi

#-----------------------

exec "$@"