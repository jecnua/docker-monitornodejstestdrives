# Example with prometheus

All the nodejs code is from [[https://github.com/RisingStack/example-prometheus-nodejs]]
They are MIT and I stay MIT :)

Uses:

## To run

    docker build . -t jecnua/nodejs-monitor-testapp
    docker run --name nodejs-monitor-testapp -d -p 3001:3001 jecnua/nodejs-monitor-testapp:latest

## Test it

    curl localhost:3001
    localhost:3001/metrics

## Delete it

    docker stop nodejs-monitor-testapp
    docker rm nodejs-monitor-testapp
