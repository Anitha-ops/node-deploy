#!/bin/bash -xe

# this runs in the root context of the app

ARTIFACT=node-app
BRANCH=${BUILDKITE_BRANCH:-dev.1}
TAG=$(echo $BRANCH | tr "/" _)
HASH=$(git rev-parse --short HEAD)

docker build --no-cache -t $ARTIFACT -f Dockerfile .

# Tag and push (latest is only tagged for master)
docker tag $ARTIFACT $ARTIFACT:$TAG
docker tag $ARTIFACT $ARTIFACT:latest
if [ "$BUILDKITE" == "true" ]; then
  docker push $ARTIFACT:$TAG
fi

if [ "$BUILDKITE" == "true" ] && [ "$BUILDKITE_BRANCH" == "master" ]; then
  echo "Release staging docker image"
  docker tag $ARTIFACT $ARTIFACT:staging_$HASH
  docker push $ARTIFACT:staging_$HASH
# Exporting the Version number to be used in subsequent steps
  buildkite-agent meta-data set "node_app_version" $HASH
fi

