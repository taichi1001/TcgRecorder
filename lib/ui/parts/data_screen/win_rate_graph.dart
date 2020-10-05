import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/localization/l10n.dart';
import 'package:tcg_recorder/model/graph_model.dart';

class WinRateGraph extends StatelessWidget {
  const WinRateGraph({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<GraphModel>();
    return Container(
      width: 400,
      height: 200,
      child: SfCartesianChart(
        title: ChartTitle(
          text: L10n.of(context).winRateGraphTitle,
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        trackballBehavior: TrackballBehavior(
          enable: true,
          tooltipSettings: InteractiveTooltip(),
        ),
        primaryYAxis: NumericAxis(
          maximum: 100,
          minimum: 0,
        ),
        primaryXAxis: NumericAxis(
          isVisible: false,
        ),
        // margin: const EdgeInsets.only(
        //   left: 50,
        //   right: 50,
        //   top: 40,
        // ),
        series: <ChartSeries>[
          LineSeries<WinRateData, int>(
              name: 'Win Rate',
              enableTooltip: true,
              dataSource: model.winRateList,
              xValueMapper: (WinRateData data, _) => data.count,
              yValueMapper: (WinRateData data, _) => data.winRate,
              animationDuration: 0),
        ],
      ),
    );
  }
}
