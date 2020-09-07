import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:provider/provider.dart';
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
          appBar: AppBar(
            title: Text(context.select((GraphModel model) => model.selectedGame.game)),
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
    return Center(
      child: Container(
        padding: const EdgeInsets.only(left: 30),
        child: SfDataGrid(
          source: model.vsDeckDetailDataGridSource,
          columnWidthMode: ColumnWidthMode.auto,
          columns: [
            GridTextColumn(mappingName: 'deck', headerText: '対戦デッキ名'),
            GridNumericColumn(mappingName: 'matches', headerText: '試合'),
            GridTextColumn(mappingName: 'win', headerText: '勝'),
            GridTextColumn(mappingName: 'lose', headerText: '負'),
            GridNumericColumn(mappingName: 'winRate', headerText: '勝率'),
          ],
        ),
      ),
    );
  }
}
