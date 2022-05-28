import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';

class DeckWinRateDataSource extends DataGridSource {
  DeckWinRateDataSource({
    required List<WinRateData> winRateDataList,
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
      return Text(
        cell.value.toString(),
        maxLines: 2,
        style: const TextStyle(
          fontSize: 12,
          overflow: TextOverflow.ellipsis,
        ),
      );
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
      return Text('${cell.value}%');
    }
    if (cell.columnName == '先攻勝率') {
      if (cell.value.isNaN) return const Text('-');
      return Text('${cell.value}%');
    }
    if (cell.columnName == '後攻勝率') {
      if (cell.value.isNaN) return const Text('-');
      return Text('${cell.value}%');
    }

    return const Text('test');
  }

  // 合計行をソート対象から外すための処理を追加している
  @override
  int compare(DataGridRow? a, DataGridRow? b, SortColumnDetails sortColumn) {
    if (a?.getCells().first.value == '合計' || b?.getCells().first.value == '合計') return 0;
    return super.compare(a, b, sortColumn);
  }
}
