# Monitor nodejs vm with prometheus

- https://github.com/siimon/prom-client App metrics
- https://github.com/SimenB/node-prometheus-gc-stats GC metrics

All the nodejs code is from [RisingStack/example-prometheus-nodejs](https://github.com/RisingStack/example-prometheus-nodejs)

They are MIT and I am MIT :)

## To run

    $ docker build . -t jecnua/nodejs-monitor-testapp
    $ docker run --name nodejs-monitor-testapp -d -p 3001:3001 jecnua/nodejs-monitor-testapp:latest

## Test it

    $ curl localhost:3001
    $ curl localhost:3001/metrics

# Metrics

    $ curl -s localhost:3001/metrics | grep -v '#' | sort | uniq

    nodejs_active_handles_total 3 1524830290927
    nodejs_active_requests_total 2 1524830290927
    nodejs_eventloop_lag_seconds 0.000271353 1524830290927
    nodejs_heap_size_total_bytes 18748000 1524830290927
    nodejs_heap_size_used_bytes 10510888 1524830290927
    nodejs_version_info{version="v4.2.6",major="4",minor="2",patch="6"} 1
    process_heap_bytes 88152000 1524830290927
    process_max_fds 524288
    process_open_fds 12 1524830290927
    process_resident_memory_bytes 29280000 1524830290927
    process_start_time_seconds 1524830260
    process_virtual_memory_bytes 1174488000 1524830290927

With gc

no metric with node 4

## Delete it

    docker stop nodejs-monitor-testapp
    docker rm nodejs-monitor-testapp
