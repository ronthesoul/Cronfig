#!/usr/bin/env bash
MESSAGE="$1"
WEBHOOK="$2"

curl -X POST -H 'Content-type: application/json' \
  --data "{\"text\":\"$MESSAGE\"}" "$WEBHOOK"
