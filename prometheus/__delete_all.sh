#!/bin/sh

docker stop nodejs-monitor-testapp
docker rm nodejs-monitor-testapp
docker stop prometheus
docker rm prometheus
docker stop grafana
docker rm grafana
