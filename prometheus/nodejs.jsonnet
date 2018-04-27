local grafana = import "grafonnet/grafana.libsonnet";
local dashboard = grafana.dashboard;
local row = grafana.row;
local singlestat = grafana.singlestat;
local prometheus = grafana.prometheus;

dashboard.new(
    "Node.JS",
    tags=["nodejs"],
)
.addRow(
    row.new()
    .addPanel(
        singlestat.new(
            "uptime",
            format="s",
            datasource="prometheus",
            span=2,
            valueName="current",
        )
        .addTarget(
            prometheus.target(
                "nodejs_heap_size_total_bytes{}",
            )
        )
        .addTarget(
            prometheus.target(
                "nodejs_heap_size_used_bytes{}",
            )
        )
    )
)
