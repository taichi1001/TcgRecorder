import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/localization/l10n.dart';
import 'package:tcg_recorder/model/graph_model.dart';
import 'package:tcg_recorder/ui/parts/data_grid.dart';

class SelectDeckDetail extends StatelessWidget {
  const SelectDeckDetail({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<GraphModel>();
    final _size = MediaQuery.of(context).size;
    return Padding(
      padding:
          const EdgeInsets.only(top: 12, left: 8, right: 8), //cardはデフォルトで4のマージンがあるため、２つ目以降は16ではなく12
      child: DataGrid(
        source: model.selectDeckDetailDataGridSource,
        cellBuilder: (context, gridColumn, rowIndex) => Center(
          child: Container(
            width: _size.width * (35 / 100),
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Text(
              model.selectDeckDetailList[rowIndex].deck.deck,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        columns: [
          GridWidgetColumn(
              mappingName: 'deck', headerText: L10n.of(context).deckDetailScreenDeckName)
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
      ),
    );
  }
}
