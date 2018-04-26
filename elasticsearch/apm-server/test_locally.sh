#!/bin/sh
# No need to expose any port :)

export GOSS_WAIT_OPTS="-r 90s -s 1s > /dev/null"

docker network create nodejs_apm

# Run es but disable xpack.security
docker stop es.local
docker rm es.local
docker run -d \
  -p 9200:9200 \
  --name es.local \
  --network nodejs_apm \
  -e "xpack.security.enabled=false" \
  -e "http.host=0.0.0.0" \
  -e "transport.host=127.0.0.1" \
  docker.elastic.co/elasticsearch/elasticsearch:6.2.4

# Wait until it responds
echo "Waiting for elasticsearch to start up..."
until $(curl --output /dev/null --silent --head --fail http://localhost:9200); do
    printf '.'
    sleep 2
done
echo " "

docker stop kibana.local
docker rm kibana.local
docker run \
  -d \
  --name kibana.local \
  -e server.name="localhost" \
  --network nodejs_apm \
  -p 5601:5601 \
  -e ELASTICSEARCH_URL='http://docker.for.mac.localhost:9200' \
  docker.elastic.co/kibana/kibana:6.2.4

docker stop nodejs-monitor-testapp-apm-server
docker rm nodejs-monitor-testapp-apm-server
docker run \
  --name nodejs-monitor-testapp-apm-server \
  --network nodejs_apm \
  -d \
  -p 8200:8200 \
  jecnua/nodejs-monitor-testapp-apm-server
