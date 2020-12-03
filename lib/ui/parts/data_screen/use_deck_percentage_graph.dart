import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/localization/l10n.dart';
import 'package:tcg_recorder/model/graph_model.dart';

class UseDeckPercentageGraph extends StatelessWidget {
  const UseDeckPercentageGraph({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<GraphModel>();
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
      child: Card(
        color: Theme.of(context).cardColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Container(
          width: 400,
          height: 280,
          child: SfCircularChart(
            title: ChartTitle(
              text: L10n.of(context).useDeckPercentageGraphTitle,
            ),
            legend: Legend(
              isVisible: true,
              position: LegendPosition.right,
              overflowMode: LegendItemOverflowMode.scroll,
              width: '40%',
            ),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CircularSeries>[
              PieSeries<DeckDetailData, String>(
                enableTooltip: true,
                dataSource: model.useDeckGraphDetailList,
                pointColorMapper: (DeckDetailData data, _) => data.color,
                xValueMapper: (DeckDetailData data, _) => data.deck.deck,
                yValueMapper: (DeckDetailData data, _) => data.useageRate,
                animationDuration: 0,
                radius: '100%',
              )
            ],
          ),
        ),
      ),
    );
  }
}
