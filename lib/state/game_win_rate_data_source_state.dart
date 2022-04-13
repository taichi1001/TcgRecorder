import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
import 'package:tcg_manager/view/deck_data_grid.dart';

class GameWinRateDataSource extends DataGridSource {
  GameWinRateDataSource({
    required List<WinRateData> winRateDataList,
    required this.context,
  }) {
    dataGridRows = winRateDataList
        .map<DataGridRow>(
          (winRateData) => DataGridRow(
            cells: [
              DataGridCell(columnName: 'デッキ名', value: winRateData.deck),
              DataGridCell(columnName: '試合数', value: winRateData.matches),
              DataGridCell(columnName: '勝', value: winRateData.win),
              DataGridCell(columnName: '負', value: winRateData.loss),
              DataGridCell(columnName: '勝率', value: winRateData.winRate),
              DataGridCell(columnName: '先攻勝率', value: winRateData.winRateOfFirst),
              DataGridCell(columnName: '後攻勝率', value: winRateData.winRateOfSecond),
            ],
          ),
        )
        .toList();
  }
  List<DataGridRow> dataGridRows = [];
  final BuildContext context;

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
        (dataGridCell) {
          return Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _buildChild(dataGridCell),
            ),
          );
        },
      ).toList(),
    );
  }

  Widget _buildChild(DataGridCell cell) {
    if (cell.columnName == 'デッキ名') {
      if (cell.value == '合計') {
        return Text(cell.value.toString());
      } else {
        return TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            minimumSize: MaterialStateProperty.all(Size.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      Expanded(child: DeckDataGrid(deck: cell.value)),
                      const AdaptiveBannerAd(),
                    ],
                  ),
                ),
              ),
            );
          },
          child: Text(
            cell.value.toString(),
            maxLines: 2,
            style: Theme.of(context).textTheme.overline?.copyWith(
                  decoration: TextDecoration.underline,
                  overflow: TextOverflow.ellipsis,
                  leadingDistribution: TextLeadingDistribution.even,
                  height: 1,
                ),
          ),
        );
      }
    }
    if (cell.columnName == '試合数') {
      return Text(cell.value.toString());
    }
    if (cell.columnName == '勝') {
      return Text(cell.value.toString());
    }
    if (cell.columnName == '負') {
      return Text(cell.value.toString());
    }
    if (cell.columnName == '勝率') {
      if (cell.value.isNaN) return const Text('-');
      return Text(cell.value.toString() + '%');
    }
    if (cell.columnName == '先攻勝率') {
      if (cell.value.isNaN) return const Text('-');
      return Text(cell.value.toString() + '%');
    }
    if (cell.columnName == '後攻勝率') {
      if (cell.value.isNaN) return const Text('-');
      return Text(cell.value.toString() + '%');
    }

    return const Text('test');
  }
}
