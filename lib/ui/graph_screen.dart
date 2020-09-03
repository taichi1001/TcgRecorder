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
        ),
      ],
      child: const _Graph(),
    );
  }
}

class _Graph extends StatelessWidget {
  const _Graph({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.select((GraphModel model) => model.selectedGame.game)),
      ),
      body: Center(
        child: Column(
          children: const [
            _WinRateGraph(),
            _UseDeckPercentageGraph(),
          ],
        ),
      ),
    );
  }
}

class _WinRateGraph extends StatelessWidget {
  const _WinRateGraph({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class _UseDeckPercentageGraph extends StatelessWidget {
  const _UseDeckPercentageGraph({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCircularChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CircularSeries>[
          PieSeries<DeckPercentageData, String>(
            enableTooltip: true,
            dataSource: context.select((GraphModel model) => model.useDeckPercentageList),
            pointColorMapper: (DeckPercentageData data, _) => data.color,
            xValueMapper: (DeckPercentageData data, _) => data.deck.deck,
            yValueMapper: (DeckPercentageData data, _) => data.percentage,
          )
        ],
      ),
    );
  }
}
