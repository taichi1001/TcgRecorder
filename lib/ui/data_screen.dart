import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/localization/l10n.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/model/graph_model.dart';
import 'package:tcg_recorder/repository/deck_repository.dart';
import 'package:tcg_recorder/repository/record_repository.dart';
import 'package:tcg_recorder/ui/graph_view.dart';
import 'package:tcg_recorder/ui/record_list_view.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({this.game, key}) : super(key: key);
  final Game game;

  @override
  Widget build(BuildContext context) {
    final List<Tab> _tabs = <Tab>[
      Tab(text: L10n.of(context).graphTabName),
      Tab(text: L10n.of(context).listTabName),
    ];
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GraphModel>(
          create: (context) => GraphModel(
            selectedGame: game,
            deckRepo: kIsWeb ? DeckRepo() : DeckRepo(),
            recordRepo: kIsWeb ? RecordRepo() : RecordRepo(),
          ),
          builder: (context, baz) {
            context.select((GraphModel model) => model.make2());
            return DefaultTabController(
              length: _tabs.length,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(L10n.of(context).dataScreenTitle(
                    context.select((GraphModel model) => model.selectedGame.game),
                  )),
                  bottom: TabBar(
                    tabs: _tabs,
                  ),
                ),
                body: TabBarView(
                  children: [
                    const GraphView(),
                    RecordListView(
                      game: game,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
