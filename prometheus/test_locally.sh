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
  -d \
  -p 9090:9090 \
  quay.io/prometheus/prometheus:v2.2.1

docker stop grafana
docker rm grafana
docker run -d --name=grafana \
  -e 'GF_INSTALL_PLUGINS=grafana-clock-panel,grafana-piechart-panel' \
  -e 'GF_AUTH_ANONYMOUS_ENABLED=true' \
  -e 'GF_AUTH_ANONYMOUS_ORG_ROLE=Viewer' \
  -e 'GF_SECURITY_ADMIN_PASSWORD=admin' \
  -e 'GF_ANALYTICS_REPORTING_ENABLED=false' \
  -v "$PWD"/providers.yml:/etc/grafana/provisioning/dashboards/providers.yaml:ro \
  -v "$PWD"/nodejs.json:/var/lib/grafana/dashboards/nodejs.json:ro \
  -v "$PWD"/prom.yml:/etc/grafana/provisioning/datasources/datasource.yaml:ro \
  -p 3000:3000 \
  grafana/grafana:5.1.0
