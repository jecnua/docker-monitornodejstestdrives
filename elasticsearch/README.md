# Monitor nodejs application (Express) with elastic APM

- https://www.elastic.co/guide/en/apm/agent/nodejs/current/express.html

![Dashboard](images/kibana_dash.png)

## To build

    docker build . -t jecnua/nodejs-monitor-testapp-es

## To run

    docker stop nodejs-monitor-testapp-es
    docker rm nodejs-monitor-testapp-es
    docker run --name nodejs-monitor-testapp-es --network nodejs_apm -d -p 3000:3000 jecnua/nodejs-monitor-testapp-es

## Test it

    curl localhost:3001
    while true; do curl localhost:3000; sleep 0.5; done

## Delete it

    docker stop nodejs-monitor-testapp-es
    docker rm nodejs-monitor-testapp-es
