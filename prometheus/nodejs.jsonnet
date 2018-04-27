local grafana = import "grafonnet/grafana.libsonnet";
local dashboard = grafana.dashboard;
local row = grafana.row;
local graphPanel = grafana.graphPanel;
local singlestat = grafana.singlestat;
local prometheus = grafana.prometheus;

dashboard.new(
    "Node.JS",
    tags=["nodejs","prometheus"],
)
.addRow(
    row.new()
    .addPanel(
      graphPanel.new(
          'nodejs memory',
          span=6,
          format='bytes',
          fill=0,
          min=0,
          decimals=2,
          datasource='prometheus',
          legend_values=true,
          legend_min=true,
          legend_max=true,
          legend_current=true,
          legend_total=false,
          legend_avg=true,
          legend_alignAsTable=true,
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
