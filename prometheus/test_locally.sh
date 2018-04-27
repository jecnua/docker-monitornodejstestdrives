#!/bin/sh
# No need to expose any port :)

export GOSS_WAIT_OPTS="-r 90s -s 1s > /dev/null"

docker network create nodejs_prom
# docker build . -t jecnua/nodejs-monitor-testapp

docker stop nodejs-monitor-testapp
docker rm nodejs-monitor-testapp
docker run \
  --name nodejs-monitor-testapp \
  --network nodejs_prom \
  -d \
  -p 3001:3001 \
  jecnua/nodejs-monitor-testapp:latest

docker stop prometheus
docker rm prometheus
docker run --name prometheus \
  --network nodejs_prom \
  -v "$PWD"/prometheus.yml:/etc/prometheus/prometheus.yml:ro \
  -d -p 9090:9090 quay.io/prometheus/prometheus
