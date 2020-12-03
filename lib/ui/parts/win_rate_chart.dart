import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tcg_recorder/model/graph_model.dart';
import 'package:tcg_recorder/ui/parts/line_chart.dart';

class WinRateChart extends StatelessWidget {
  const WinRateChart({
    @required this.source,
    this.title,
    key,
  }) : super(key: key);

  final List<WinRateData> source;
  final String title;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      title: title,
      series: <ChartSeries>[
        LineSeries<WinRateData, int>(
          name: 'Win Rate',
          enableTooltip: true,
          dataSource: source,
          xValueMapper: (WinRateData data, _) => data.count,
          yValueMapper: (WinRateData data, _) => data.winRate,
          animationDuration: 0,
        ),
      ],
    );
  }
}
