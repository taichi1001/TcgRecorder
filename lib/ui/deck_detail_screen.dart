import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/localization/l10n.dart';
import 'package:tcg_recorder/entity/deck.dart';
import 'package:tcg_recorder/model/graph_model.dart';

class VsDeckDetailScreen extends StatelessWidget {
  const VsDeckDetailScreen({key, this.deck, this.model}) : super(key: key);
  final Deck deck;
  final GraphModel model;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<GraphModel>.value(value: model)],
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
          body: const _VsDeckDetail(),
        );
      },
    );
  }
}

class _VsDeckDetail extends StatelessWidget {
  const _VsDeckDetail({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<GraphModel>();
    final _size = MediaQuery.of(context).size;
    return SfDataGrid(
      source: model.vsDeckDetailDataGridSource,
      cellBuilder: (context, column, index) {
        return Center(
          child: Container(
            width: _size.width * (35 / 100),
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Text(
              model.vsDeckDetailList[index].deck.deck,
              textAlign: TextAlign.left,
            ),
          ),
        );
      },
      footerFrozenRowsCount: 1,
      columns: [
        GridWidgetColumn(mappingName: 'deck', headerText: L10n.of(context).deckDetailScreenDeckName)
          ..textAlignment = Alignment.centerLeft
          ..headerTextAlignment = Alignment.centerLeft
          ..softWrap = true
          ..headerTextSoftWrap = true
          ..width = _size.width * (35 / 100),
        GridNumericColumn(
            mappingName: 'matches', headerText: L10n.of(context).deckDetailScreenMatches)
          ..width = _size.width * (19 / 100)
          ..headerTextAlignment = Alignment.center
          ..textAlignment = Alignment.center
          ..headerTextOverflow = TextOverflow.visible,
        GridTextColumn(mappingName: 'win', headerText: L10n.of(context).deckDetailScreenWin)
          ..width = _size.width * (13 / 100)
          ..headerTextAlignment = Alignment.center
          ..textAlignment = Alignment.center,
        GridTextColumn(mappingName: 'lose', headerText: L10n.of(context).deckDetailScreenLose)
          ..width = _size.width * (13 / 100)
          ..headerTextAlignment = Alignment.center
          ..textAlignment = Alignment.center,
        GridNumericColumn(
            mappingName: 'winRate', headerText: L10n.of(context).deckDetailScreenWinRate)
          ..width = _size.width * (20 / 100)
          ..headerTextAlignment = Alignment.center
          ..textAlignment = Alignment.center,
      ],
    );
  }
}
