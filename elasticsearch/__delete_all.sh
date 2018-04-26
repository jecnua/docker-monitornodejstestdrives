#!/bin/sh

docker stop es.local
docker rm es.local
docker stop kibana.local
docker rm kibana.local
docker stop nodejs-monitor-testapp-apm-server
docker rm nodejs-monitor-testapp-apm-server
docker stop nodejs-monitor-testapp-es
docker rm nodejs-monitor-testapp-es
