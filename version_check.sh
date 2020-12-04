#!/bin/bash -e
RELEASE_HASH=`buildkite-agent meta-data get ndoe_app_version`

while  [ `curl -s  -H "Content-Type: application/json" -d '{"query": "query {healthCheckContacts {version {commit}}}"}' \
  https://$ENDPOINT/version | jq -r '.data.healthCheckNodeapp.version.commit'` != $RELEASE_HASH ]; \
  do
    echo "Waiting for the new POD to start"
    sleep 2
  done

echo "Pod started Successfully"

