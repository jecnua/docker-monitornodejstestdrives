# APM

- https://www.elastic.co/guide/en/apm/agent/nodejs/current/intro.html


  https://dimitraz.github.io/blog/post/docker-networking/

  docker --rm -d --name temp

  docker run \
    --rm \
    --name test \
    --network nodejs_apm \
    jecnua/nodejs-monitor-testapp-apm-server \
    apm-server -E setup.kibana.host=docker.for.mac.localhost:5601 -E output.elasticsearch.hosts=docker.for.mac.localhost:9200 setup --dashboards

## To run

    docker build . -t jecnua/nodejs-monitor-testapp-apm-server

    docker stop nodejs-monitor-testapp-apm-server
    docker rm nodejs-monitor-testapp-apm-server
    docker run --name nodejs-monitor-testapp-apm-server -d -p 8200:8200 jecnua/nodejs-monitor-testapp-apm-server

    docker stop nodejs-monitor-testapp-apm-server
    docker rm nodejs-monitor-testapp-apm-server
    docker run --name nodejs-monitor-testapp-apm-server -it jecnua/nodejs-monitor-testapp-apm-server /bin/bash

## Test it

    curl localhost:8200

## Delete it

    docker stop nodejs-monitor-testapp-apm-server
    docker rm nodejs-monitor-testapp-apm-server
