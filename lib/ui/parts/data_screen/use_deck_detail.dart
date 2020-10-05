import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/model/graph_model.dart';
import 'package:tcg_recorder/ui/deck_detail_screen.dart';

class UseDeckDetail extends StatelessWidget {
  const UseDeckDetail({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<GraphModel>();
    final _size = MediaQuery.of(context).size;
    return Container(
      height: 350,
      child: SfDataGrid(
        source: model.useDeckDetailDataGridSource,
        cellBuilder: (BuildContext context, GridColumn column, int rowIndex) {
          return FlatButton(
            onPressed: () {
              model.selectedDeck = model.useDeckDetailList[rowIndex].deck;
              model.make();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => VsDeckDetailScreen(
                    deck: model.useDeckDetailList[rowIndex].deck,
                    model: model,
                  ),
                ),
              );
            },
            child: Container(
              width: _size.width * (35 / 100),
              child: Text(
                model.useDeckDetailList[rowIndex].deck.deck,
                textAlign: TextAlign.left,
              ),
            ),
          );
        },
        columns: [
          GridWidgetColumn(mappingName: 'deck', headerText: 'デッキ名')
            ..textAlignment = Alignment.centerLeft
            ..headerTextAlignment = Alignment.centerLeft
            ..softWrap = true
            ..headerTextSoftWrap = true
            ..width = _size.width * (35 / 100),
          GridNumericColumn(mappingName: 'matches', headerText: '試合')
            ..width = _size.width * (15 / 100)
            ..headerTextAlignment = Alignment.center
            ..textAlignment = Alignment.center
            ..headerTextOverflow = TextOverflow.visible,
          GridTextColumn(mappingName: 'win', headerText: '勝')
            ..width = _size.width * (15 / 100)
            ..headerTextAlignment = Alignment.center
            ..textAlignment = Alignment.center,
          GridTextColumn(mappingName: 'lose', headerText: '負')
            ..width = _size.width * (15 / 100)
            ..headerTextAlignment = Alignment.center
            ..textAlignment = Alignment.center,
          GridNumericColumn(mappingName: 'winRate', headerText: '勝率')
            ..width = _size.width * (20 / 100)
            ..headerTextAlignment = Alignment.center
            ..textAlignment = Alignment.center,
        ],
      ),
    );
  }
}
