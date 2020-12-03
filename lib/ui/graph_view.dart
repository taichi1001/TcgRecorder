import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/localization/l10n.dart';
import 'package:tcg_recorder/model/graph_model.dart';
import 'package:tcg_recorder/ui/parts/data_screen/opponent_deck_percentage_chart.dart';
import 'package:tcg_recorder/ui/parts/data_screen/use_deck_detail.dart';
import 'package:tcg_recorder/ui/parts/data_screen/use_deck_percentage_chart.dart';
import 'package:tcg_recorder/ui/parts/data_screen/game_win_rate_chart.dart';

class GraphView extends StatelessWidget {
  const GraphView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Tab> _tabs = <Tab>[
      Tab(text: L10n.of(context).winRate),
      Tab(text: L10n.of(context).useageRate),
    ];
    return DefaultTabController(
      length: _tabs.length,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ColoredTabBar(
              color: Theme.of(context).buttonColor,
              tabBar: TabBar(
                labelColor: Colors.white,
                indicatorWeight: 0.1,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Theme.of(context).buttonColor,
                unselectedLabelColor: Colors.grey,
                tabs: _tabs,
              ),
            ),
            Container(
              height: 600,
              child: const TabBarView(
                children: [
                  _WinRateView(),
                  _UseageRateView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UseageRateView extends StatelessWidget {
  const _UseageRateView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.select((GraphModel model) => model.recordList).isEmpty
        ? Center(child: Text(L10n.of(context).noItem))
        : SingleChildScrollView(
            child: Column(
              children: const [
                UseDeckPercentageChart(),
                OpponentDeckPercentageChart(),
              ],
            ),
          );
  }
}

class _WinRateView extends StatelessWidget {
  const _WinRateView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.select((GraphModel model) => model.recordList).isEmpty
        ? Center(child: Text(L10n.of(context).noItem))
        : SingleChildScrollView(
            child: Column(
              children: const [
                GameWinRateChart(),
                UseDeckDetail(),
              ],
            ),
          );
  }
}

class ColoredTabBar extends Container implements PreferredSizeWidget {
  ColoredTabBar({
    Key key,
    this.color,
    this.tabBar,
  }) : super(key: key);

  final Color color;
  final TabBar tabBar;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Container(
        color: color,
        child: tabBar,
      );
}
