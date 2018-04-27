#!/bin/sh
# No need to expose any port :)

export GOSS_WAIT_OPTS="-r 90s -s 1s > /dev/null"

# docker network create nodejs_prom
docker build . -t jecnua/nodejs-monitor-testapp

docker stop nodejs-monitor-testapp
docker rm nodejs-monitor-testapp
docker run \
  --name nodejs-monitor-testapp \
  -d \
  -p 3001:3001 \
  jecnua/nodejs-monitor-testapp:latest
