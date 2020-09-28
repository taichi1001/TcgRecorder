import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/model/graph_model.dart';

class WinRateGraph extends StatelessWidget {
  const WinRateGraph({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<GraphModel>();
    return Container(
      width: 200,
      height: 100,
      child: SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        primaryYAxis: NumericAxis(
          maximum: 100,
          minimum: 0,
        ),
        primaryXAxis: DateTimeAxis(
          intervalType: DateTimeIntervalType.days,
        ),
        margin: const EdgeInsets.only(
          left: 50,
          right: 50,
          top: 40,
        ),
        series: <ChartSeries>[
          LineSeries<WinRateData, DateTime>(
              name: 'Win Rate',
              enableTooltip: true,
              dataSource: model.winRateList,
              xValueMapper: (WinRateData data, _) => data.record.date,
              yValueMapper: (WinRateData data, _) => data.winRate,
              animationDuration: 0),
        ],
      ),
    );
  }
}
