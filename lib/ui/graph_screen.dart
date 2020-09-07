import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/model/graph_model.dart';
import 'package:tcg_recorder/ui/deck_detail_screen.dart';

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
        child: SingleChildScrollView(
          child: Column(
            children: const [
              _WinRateGraph(),
              _UseDeckPercentageGraph(),
              _UseDeckDetail(),
            ],
          ),
        ),
      ),
    );
  }
}

class _WinRateGraph extends StatelessWidget {
  const _WinRateGraph({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<GraphModel>();
    return SfCartesianChart(
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryYAxis: NumericAxis(
        maximum: 100,
        minimum: 0,
      ),
      primaryXAxis: DateTimeAxis(
        intervalType: DateTimeIntervalType.days,
      ),
      series: <ChartSeries>[
        LineSeries<WinRateData, DateTime>(
          name: 'Win Rate',
          enableTooltip: true,
          dataSource: model.winRateList,
          xValueMapper: (WinRateData data, _) => data.record.date,
          yValueMapper: (WinRateData data, _) => data.winRate,
        ),
      ],
    );
  }
}

class _UseDeckPercentageGraph extends StatelessWidget {
  const _UseDeckPercentageGraph({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<GraphModel>();
    return Container(
      // width: 200,
      height: 400,
      child: SfCircularChart(
        legend: Legend(
          isVisible: true,
          position: LegendPosition.right,
          overflowMode: LegendItemOverflowMode.wrap,
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CircularSeries>[
          PieSeries<DeckDetailData, String>(
            enableTooltip: true,
            dataSource: model.useDeckDetailList,
            pointColorMapper: (DeckDetailData data, _) => data.color,
            xValueMapper: (DeckDetailData data, _) => data.deck.deck,
            yValueMapper: (DeckDetailData data, _) => data.useageRate,
          )
        ],
      ),
    );
  }
}

class _UseDeckDetail extends StatelessWidget {
  const _UseDeckDetail({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<GraphModel>();
    return Center(
      child: Container(
        padding: const EdgeInsets.only(left: 30),
        child: SfDataGrid(
          source: model.useDeckDetailDataGridSource,
          cellBuilder: (BuildContext context, GridColumn column, int rowIndex) {
            return FlatButton(
              onPressed: () {
                model.selectedDeck = model.useDeckDetailList[rowIndex].deck;
                model.make();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => VsDeckDetailScreen(
                      deck: model.useDeckDetailList[rowIndex].deck,
                      model: model,
                    ),
                  ),
                );
              },
              child: Text(model.useDeckDetailList[rowIndex].deck.deck),
            );
          },
          columnWidthMode: ColumnWidthMode.auto,
          columns: [
            GridWidgetColumn(mappingName: 'deck', headerText: 'デッキ名'),
            GridNumericColumn(mappingName: 'matches', headerText: '試合'),
            GridTextColumn(mappingName: 'win', headerText: '勝'),
            GridTextColumn(mappingName: 'lose', headerText: '負'),
            GridNumericColumn(mappingName: 'winRate', headerText: '勝率'),
          ],
        ),
      ),
    );
  }
}
