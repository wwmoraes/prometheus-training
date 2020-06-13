#!/bin/bash

[ $# -ne 1 ] && {
  echo "usage: $0 <bot-webhook-url>"
  exit 2
}

WEBHOOK_URL=$1
shift


SUMMARY="$(curl -fs --max-time 0.3 http://whatthecommit.com/index.txt) $*"
START_AT=$(date -u +"%FT%TZ")
END_AT=$(date -v+5M -u +"%FT%TZ")

ALERTNAME="${RANDOM} $*"
GROUP_KEY="{}:{alertname='${ALERTNAME}' }"

HOSTNAME=$(hostname)
EXTERNAL_URL="https://${HOSTNAME}:9093"
GENERATOR_URL="http://${HOSTNAME}:9090/graph"

curl -v -k -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache"  -d '"{
  "version": "4",
  "groupKey": "'${GROUP_KEY}'",
  "status": "firing",
  "receiver": "general",
  "groupLabels": { "alertname": "'${ALERTNAME}'" },
  "commonLabels": {
    "alertname": "'${ALERTNAME}'",
    "instance": "docker-test",
    "service": "test",
    "severity": "warning"
  },
  "commonAnnotations": {
    "summary": "'${SUMMARY}'",
    "message": "test message fired manually",
    "description": "no action is required"
  },
  "externalURL": "'${EXTERNAL_URL}'",
  "alerts": [
    {
      "status": "firing",
      "labels": {
        "special-alert-label": "something distinct"
      },
      "startsAt": "'${START_AT}'",
      "endsAt": "'${END_AT}'",
      "generatorURL": "'${GENERATOR_URL}'"
    }
  ]
}"' "${WEBHOOK_URL}"
