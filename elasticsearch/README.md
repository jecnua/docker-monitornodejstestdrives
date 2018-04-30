# Monitor nodejs application (Express) with elastic APM

[![](https://images.microbadger.com/badges/image/jecnua/monitor-nodejs-elasticapm.svg)](https://microbadger.com/images/jecnua/monitor-nodejs-elasticapm "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/jecnua/monitor-nodejs-elasticapm.svg)](https://microbadger.com/images/jecnua/monitor-nodejs-elasticapm "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/commit/jecnua/monitor-nodejs-elasticapm.svg)](https://microbadger.com/images/jecnua/monitor-nodejs-elasticapm "Get your own commit badge on microbadger.com")
[![](https://images.microbadger.com/badges/license/jecnua/monitor-nodejs-elasticapm.svg)](https://microbadger.com/images/jecnua/monitor-nodejs-elasticapm "Get your own license badge on microbadger.com")

![Dashboard](images/kibana_dash.png)

- [Node.js express](https://www.elastic.co/guide/en/apm/agent/nodejs/current/express.html)


## To build

    make

Or

    docker build . -t jecnua/jecnua/monitor-nodejs-elasticapm

## To run

    docker stop jecnua/monitor-nodejs-elasticapm
    docker rm jecnua/monitor-nodejs-elasticapm
    docker run \
      --name jecnua/monitor-nodejs-elasticapm \
      --network nodejs_apm \
      -d -p 3000:3000 \
      jecnua/jecnua/monitor-nodejs-elasticapm

## Test it

    curl localhost:3001
    while true; do curl localhost:3000; sleep 0.5; done

## Delete it

    docker stop jecnua/monitor-nodejs-elasticapm
    docker rm jecnua/monitor-nodejs-elasticapm
