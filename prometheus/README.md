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

# jsonnet lin

    jsonnet -J ~/path/grafonnet-lib nodejs.jsonnet > tmp.tmp
    sed -e 's/\\u0001//g' tmp.tmp > nodejs.json # BUG?

# Metrics

    $ curl -s localhost:3001/metrics | grep -v '#' | sort | uniq

    nodejs_active_handles_total 3 1524833326603
    nodejs_active_requests_total 2 1524833326603
    nodejs_eventloop_lag_seconds 0.000390078 1524833326604
    nodejs_external_memory_bytes 41404 1524833326603
    nodejs_heap_size_total_bytes 13451264 1524833326603
    nodejs_heap_size_used_bytes 10057512 1524833326603
    nodejs_heap_space_size_available_bytes{space="code"} 0 1524833326603
    nodejs_heap_space_size_available_bytes{space="large_object"} 1486003712 1524833326603
    nodejs_heap_space_size_available_bytes{space="map"} 80 1524833326603
    nodejs_heap_space_size_available_bytes{space="new"} 801136 1524833326603
    nodejs_heap_space_size_available_bytes{space="old"} 1004160 1524833326603
    nodejs_heap_space_size_total_bytes{space="code"} 2097152 1524833326603
    nodejs_heap_space_size_total_bytes{space="large_object"} 0 1524833326603
    nodejs_heap_space_size_total_bytes{space="map"} 1069056 1524833326603
    nodejs_heap_space_size_total_bytes{space="new"} 1572864 1524833326603
    nodejs_heap_space_size_total_bytes{space="old"} 8712192 1524833326603
    nodejs_heap_space_size_used_bytes{space="code"} 1254816 1524833326603
    nodejs_heap_space_size_used_bytes{space="large_object"} 0 1524833326603
    nodejs_heap_space_size_used_bytes{space="map"} 648120 1524833326603
    nodejs_heap_space_size_used_bytes{space="new"} 745616 1524833326603
    nodejs_heap_space_size_used_bytes{space="old"} 7411128 1524833326603
    nodejs_version_info{version="v8.11.1",major="8",minor="11",patch="1"} 1
    process_cpu_seconds_total 0.07 1524833326603
    process_cpu_system_seconds_total 0.03 1524833326603
    process_cpu_user_seconds_total 0.04 1524833326603
    process_heap_bytes 84926464 1524833326604
    process_max_fds 524288
    process_open_fds 12 1524833326603
    process_resident_memory_bytes 38666240 1524833326604
    process_start_time_seconds 1524832966
    process_virtual_memory_bytes 1211887616 1524833326604

With gc

WARNING: GC metrics collection doesn't work in node4 (ubuntu default - EOL)

    $ curl -s localhost:3001/metrics | grep -v '#' | sort | uniq

    nodejs_active_handles_total 3 1524832852543
    nodejs_active_requests_total 2 1524832852543
    nodejs_eventloop_lag_seconds 0.000269526 1524832852543
    nodejs_external_memory_bytes 369084 1524832852543
    nodejs_gc_pause_seconds_total{gctype="Scavenge"} 0.004776847
    nodejs_gc_reclaimed_bytes_total{gctype="Scavenge"} 2779920
    nodejs_gc_runs_total{gctype="Scavenge"} 1
    nodejs_heap_size_total_bytes 13451264 1524832852543
    nodejs_heap_size_used_bytes 10919592 1524832852543
    nodejs_heap_space_size_available_bytes{space="code"} 0 1524832852543
    nodejs_heap_space_size_available_bytes{space="large_object"} 1486003712 1524832852543
    nodejs_heap_space_size_available_bytes{space="map"} 80 1524832852543
    nodejs_heap_space_size_available_bytes{space="new"} 136768 1524832852543
    nodejs_heap_space_size_available_bytes{space="old"} 913648 1524832852543
    nodejs_heap_space_size_total_bytes{space="code"} 2097152 1524832852543
    nodejs_heap_space_size_total_bytes{space="large_object"} 0 1524832852543
    nodejs_heap_space_size_total_bytes{space="map"} 1069056 1524832852543
    nodejs_heap_space_size_total_bytes{space="new"} 1572864 1524832852543
    nodejs_heap_space_size_total_bytes{space="old"} 8712192 1524832852543
    nodejs_heap_space_size_used_bytes{space="code"} 1265568 1524832852543
    nodejs_heap_space_size_used_bytes{space="large_object"} 0 1524832852543
    nodejs_heap_space_size_used_bytes{space="map"} 670648 1524832852543
    nodejs_heap_space_size_used_bytes{space="new"} 1409984 1524832852543
    nodejs_heap_space_size_used_bytes{space="old"} 7575560 1524832852543
    nodejs_version_info{version="v8.11.1",major="8",minor="11",patch="1"} 1
    process_cpu_seconds_total 0.09999999999999999 1524832852542
    process_cpu_system_seconds_total 0.02 1524832852542
    process_cpu_user_seconds_total 0.08 1524832852542
    process_heap_bytes 84914176 1524832852543
    process_max_fds 524288
    process_open_fds 12 1524832852543
    process_resident_memory_bytes 39030784 1524832852543
    process_start_time_seconds 1524832372
    process_virtual_memory_bytes 1211879424 1524832852543

## Delete it

    docker stop nodejs-monitor-testapp
    docker rm nodejs-monitor-testapp
