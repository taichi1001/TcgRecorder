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
    return Center(
      child: Container(
        padding: const EdgeInsets.only(left: 30),
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
              child: Text(model.useDeckDetailList[rowIndex].deck.deck),
            );
          },
          columnWidthMode: ColumnWidthMode.auto,
          columns: [
            GridWidgetColumn(mappingName: 'deck', headerText: 'デッキ名'),
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
