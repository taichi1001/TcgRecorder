import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/localization/l10n.dart';
import 'package:tcg_recorder/model/graph_model.dart';

class OpponentDeckPercentageGraph extends StatelessWidget {
  const OpponentDeckPercentageGraph({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<GraphModel>();
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        width: 400,
        height: 280,
        child: SfCircularChart(
          title: ChartTitle(
            text: L10n.of(context).opponentDeckPercentageGraphTitle,
          ),
          legend: Legend(
            isVisible: true,
            position: LegendPosition.right,
            overflowMode: LegendItemOverflowMode.scroll,
          ),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <CircularSeries>[
            PieSeries<DeckDetailData, String>(
              enableTooltip: true,
              dataSource: model.opponentDeckDetailList,
              pointColorMapper: (DeckDetailData data, _) => data.color,
              xValueMapper: (DeckDetailData data, _) => data.deck.deck,
              yValueMapper: (DeckDetailData data, _) => data.useageRate,
              animationDuration: 0,
              radius: '100%',
            )
          ],
        ),
      ),
    );
  }
}
