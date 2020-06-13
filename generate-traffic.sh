#!/bin/sh

set -eu

[ $# -ge 2 ] || {
  exho "usage: $0 target sleep-seconds [sleep-seconds2...sleep-secondsN]"
  exit 2
}

trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

generate_traffic() {
  while :; do
    trap 'break' SIGINT
    trap 'break' SIGTSTP
    curl -s $1 > /dev/null
    echo "$(date) curl @ $1 [< $2s]"
    sleep $((RANDOM % $2))
  done
}

target=$1
shift
for latency in $@; do
  generate_traffic $target $latency &
  pids+=($!)
done

RETCODE=0
for pid in ${pids[@]}; do
  wait $pid || RETCODE=1
done
exit $RETCODE
