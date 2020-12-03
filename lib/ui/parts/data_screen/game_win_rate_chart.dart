import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/localization/l10n.dart';
import 'package:tcg_recorder/model/graph_model.dart';
import 'package:tcg_recorder/ui/parts/win_rate_chart.dart';

class GameWinRateChart extends StatelessWidget {
  const GameWinRateChart({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<GraphModel>();
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
      child: WinRateChart(
        title: L10n.of(context).winRateGraphTitle,
        source: model.winRateList,
      ),
    );
  }
}
