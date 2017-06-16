#!/bin/sh

docker login -u $DOCKER_LOGIN -p $DOCKER_PASS
docker build -t $TRAVIS_REPO_SLUG:latest .
docker push $TRAVIS_REPO_SLUG
