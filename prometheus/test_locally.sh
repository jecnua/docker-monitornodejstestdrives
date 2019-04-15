#!/bin/sh
# No need to expose any port :)

export GOSS_WAIT_OPTS="-r 90s -s 1s > /dev/null"

PROMETHEUS_VERSION='v2.9.0'
GRAFANA_VERSION='6.1.3'

make

docker network create nodejs_prom
# docker build . -t jecnua/nodejs-monitor-testapp

docker rm -f nodejs-monitor-testapp
docker run \
  --name nodejs-monitor-testapp \
  --network nodejs_prom \
  -d \
  -p 3001:3001 \
  jecnua/monitor-nodejs-prom:dev-latest

docker rm -f prometheus
docker run --name prometheus \
  --network nodejs_prom \
  -v "$PWD"/prometheus.yml:/etc/prometheus/prometheus.yml:ro \
  -d \
  -p 9090:9090 \
  "quay.io/prometheus/prometheus:$PROMETHEUS_VERSION"

docker rm -f grafana
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
  "grafana/grafana:$GRAFANA_VERSION"
