import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/model/graph_model.dart';
import 'package:tcg_recorder/repository/deck_repository.dart';
import 'package:tcg_recorder/repository/record_repository.dart';
import 'package:tcg_recorder/ui/parts/graph_screen/opponent_deck_percentage_graph.dart';
import 'package:tcg_recorder/ui/parts/graph_screen/use_deck_detail.dart';
import 'package:tcg_recorder/ui/parts/graph_screen/use_deck_percentage_graph.dart';
import 'package:tcg_recorder/ui/parts/graph_screen/win_rate_graph.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({this.game, key}) : super(key: key);
  final Game game;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GraphModel>(
          create: (context) => GraphModel(
            selectedGame: game,
            deckRepo: kIsWeb ? DeckRepo() : DeckRepo(),
            recordRepo: kIsWeb ? RecordRepo() : RecordRepo(),
          ),
        ),
      ],
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = <Tab>[
      const Tab(text: 'WinRate', icon: Icon(Icons.directions_car)),
      const Tab(text: 'UseRate', icon: Icon(Icons.directions_bike)),
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.select((GraphModel model) => model.selectedGame.game)),
          bottom: TabBar(
            tabs: tabs,
          ),
        ),
        body: const TabBarView(
          children: [
            _WinRateView(),
            _UseageRateView(),
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
    return SingleChildScrollView(
      child: Column(
        children: const [
          UseDeckPercentageGraph(),
          _Divider(),
          OpponentDeckPercentageGraph(),
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
    return SingleChildScrollView(
      child: Column(
        children: const [
          WinRateGraph(),
          _Divider(),
          UseDeckDetail(),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      indent: 20,
      endIndent: 20,
      color: Colors.black,
    );
  }
}
