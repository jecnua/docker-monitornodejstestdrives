#!/bin/sh
# No need to expose any port :)

export GOSS_WAIT_OPTS="-r 90s -s 1s > /dev/null"

# FOR MAC
NETWORK='nodejs_apm'
TARGET_HOST='docker.for.mac.localhost'
# FOR LINUX
NETWORK='host'
TARGET_HOST='localhost'
# IMAGES
ELASTIC_STACK_VERSION='7.0.0'

docker network create nodejs_apm

# Run es but disable xpack.security
docker stop es.local
docker rm es.local
docker run -d \
  --rm \
  -p 9200:9200 \
  --name es.local \
  --network $NETWORK \
  -e xpack.monitoring.collection.enabled="true" \
  -e "xpack.security.enabled=false" \
  -e "http.host=0.0.0.0" \
  -e "transport.host=127.0.0.1" \
  "docker.elastic.co/elasticsearch/elasticsearch:$ELASTIC_STACK_VERSION"

# Wait until it responds
echo "Waiting for elasticsearch to start up..."
until curl --output /dev/null --silent --head --fail http://localhost:9200; do
    printf '.'
    sleep 2
done
echo " "

docker stop kibana.local
docker rm kibana.local
docker run \
  -d \
  --rm \
  --name kibana.local \
  -e xpack.monitoring.collection.enabled="true" \
  -e server.name="localhost" \
  -e ELASTICSEARCH_HOSTS="http://$TARGET_HOST:9200" \
  --network $NETWORK \
  -p 5601:5601 \
  "docker.elastic.co/kibana/kibana:$ELASTIC_STACK_VERSION"
  # -e ELASTICSEARCH_URL="http://$TARGET_HOST:9200" \ # in 6.x

  # Wait until it responds
  echo "Waiting for kibana to start up..."
  until curl --output /dev/null --silent --head --fail http://localhost:5601; do
      printf '.'
      sleep 2
  done
  echo " "

docker stop nodejs-monitor-testapp-apm-server
docker rm nodejs-monitor-testapp-apm-server
docker run \
  --rm \
  --name nodejs-monitor-testapp-apm-server \
  --network $NETWORK \
  -d \
  -p 8200:8200 \
  jecnua/nodejs-monitor-testapp-apm-server

# PUSH DASHBOARD
# Disabled in 7.0.0
# docker run \
#   --rm \
#   --name test \
#   --network $NETWORK \
#   jecnua/nodejs-monitor-testapp-apm-server \
#   apm-server -E setup.kibana.host=$TARGET_HOST:5601 -E output.elasticsearch.hosts=$TARGET_HOST:9200 setup --dashboards
