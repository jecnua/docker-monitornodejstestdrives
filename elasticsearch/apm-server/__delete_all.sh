#!/bin/sh

docker stop es.local
docker rm es.local
docker stop kibana.local
docker rm kibana.local
ocker stop nodejs-monitor-testapp-apm-server
docker rm nodejs-monitor-testapp-apm-server
