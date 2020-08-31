import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/model/graph_model.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({this.game, key}) : super(key: key);
  final Game game;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GraphModel>(
          create: (context) => GraphModel(selectedGame: game),
          builder: (context, baz) {
            return Scaffold(
              appBar: AppBar(
                title: Text(game.game),
              ),
              body: Center(
                child: Container(
                  child: SfCartesianChart(
                    tooltipBehavior: TooltipBehavior(enable: true),
                    primaryXAxis: DateTimeAxis(),
                    series: <ChartSeries>[
                      LineSeries<WinRateData, DateTime>(
                        name: 'Win Rate',
                        enableTooltip: true,
                        dataSource: context.select((GraphModel model) => model.winRateList),
                        xValueMapper: (WinRateData data, _) => data.record.date,
                        yValueMapper: (WinRateData data, _) => data.winRate,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
      // child: Scaffold(
      //   appBar: AppBar(
      //     title: Text('Half yearly sales analysis'),
      //   ),
      //   body: Center(
      //     child: Container(
      //       child: SfCartesianChart(
      //         tooltipBehavior: TooltipBehavior(enable: true),
      //         primaryXAxis: DateTimeAxis(),
      //         series: <ChartSeries>[
      //           LineSeries<WinRateData, DateTime>(
      //             name: 'aaa',
      //             enableTooltip: true,
      //             dataSource: context.select((GraphModel model) => model.winRateList),
      //             xValueMapper: (WinRateData data, _) => data.record.date,
      //             yValueMapper: (WinRateData data, _) => data.winRate,
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
