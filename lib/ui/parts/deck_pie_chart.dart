import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tcg_recorder/model/graph_model.dart';
import 'package:tcg_recorder/ui/parts/pie_chart.dart';

class DeckPieChart extends StatelessWidget {
  const DeckPieChart({
    @required this.source,
    this.title,
    key,
  }) : super(key: key);

  final List<DeckDetailData> source;
  final String title;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      title: title,
      series: <CircularSeries>[
        PieSeries<DeckDetailData, String>(
          enableTooltip: true,
          dataSource: source,
          pointColorMapper: (DeckDetailData data, _) => data.color,
          xValueMapper: (DeckDetailData data, _) => data.deck.deck,
          yValueMapper: (DeckDetailData data, _) => data.useageRate,
          animationDuration: 0,
          radius: '90%',
        ),
      ],
    );
  }
}
