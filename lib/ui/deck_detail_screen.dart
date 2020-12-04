import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/localization/l10n.dart';
import 'package:tcg_recorder/model/graph_model.dart';
import 'package:tcg_recorder/ui/parts/chart/select_deck_detail.dart';
import 'package:tcg_recorder/ui/parts/chart/select_deck_win_rate_chart.dart';

class VsDeckDetailScreen extends StatelessWidget {
  const VsDeckDetailScreen({this.model, key}) : super(key: key);
  final GraphModel model;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GraphModel>.value(value: model),
      ],
      builder: (context, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: AppBar(
              title: Text(
                L10n.of(context).vsDeckDetailScreenTitle(
                  context.select((GraphModel model) => model.selectedDeck.deck),
                ),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          body: const _WinRateView(),
        );
      },
    );
  }
}

class _WinRateView extends StatelessWidget {
  const _WinRateView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          SelectDeckWinRateChart(),
          SelectDeckDetail(),
        ],
      ),
    );
  }
}
