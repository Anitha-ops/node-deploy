#!/bin/bash -xe

ARTIFACT=node-app
RELEASE_HASH=`buildkite-agent meta-data get node_app_version`

if [ "$BUILDKITE" == "true" ] && [ "$BUILDKITE_BRANCH" == "master" ]; then
  docker pull $ARTIFACT:staging_$RELEASE_HASH
  docker tag $ARTIFACT:staging_$RELEASE_HASH $ARTIFACT:release_$RELEASE_HASH
  docker tag $ARTIFACT:staging_$RELEASE_HASH $ARTIFACT:latest
  docker push $ARTIFACT:release_$RELEASE_HASH
  docker push $ARTIFACT:latest
fi

