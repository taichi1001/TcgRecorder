import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/localization/l10n.dart';
import 'package:tcg_recorder/model/graph_model.dart';
import 'package:tcg_recorder/ui/parts/deck_pie_chart.dart';

class UseDeckPercentageChart extends StatelessWidget {
  const UseDeckPercentageChart({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<GraphModel>();
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
      child: DeckPieChart(
        title: L10n.of(context).useDeckPercentageGraphTitle,
        source: model.useDeckGraphDetailList,
      ),
    );
  }
}
