import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tcg_recorder2/entity/win_rate_data.dart';

part 'game_win_rate_data_source_state.freezed.dart';

@freezed
abstract class GameWinRateDataSourceState with _$GameWinRateDataSourceState {
  factory GameWinRateDataSourceState({
    GameWinRateDataSource? gameWinRateDataSource,
  }) = _GameWinRateDataSourceState;
}

class GameWinRateDataSource extends DataGridSource {
  GameWinRateDataSource({
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
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(dataGridCell.value.toString()),
          );
        },
      ).toList(),
    );
  }
}
