#!/bin/bash

SUMMARY="$(curl -fs --max-time 0.3 http://whatthecommit.com/index.txt) $*"
ALERTNAME="${RANDOM} $*"
ALERTMANAGER_ENDPOINT='http://localhost:9093/api/v1/alerts'
START_AT=$(date -u +"%FT%TZ")
END_AT=$(date -v+5M -u +"%FT%TZ")

send_message() {
  local STATUS=${1:-firing}
  shift
  curl -XPOST ${ALERTMANAGER_ENDPOINT} -d '"[{
    "status": "'${STATUS}'",
    "labels": {
      "alertname": "'${ALERTNAME}'",
      "service": "test",
      "severity":"warning",
      "instance": "docker-test"
    },
    "annotations": {
      "summary": "'${SUMMARY}'",
      "message": "test message fired manually",
      "description": "no action is required"
    },
    "startsAt": "'${START_AT}'",
    "endsAt": "'${END_AT}'",
    "generatorURL": "http://localhost:9090/graph"
  }]"'
}

echo "firing up alert '${ALERTNAME}'"
send_message firing $@
echo ""
echo "press any key to resolve alert '${ALERTNAME}'"
read
echo "sending resolve"
send_message resolved $@
echo ""
echo "done!"
