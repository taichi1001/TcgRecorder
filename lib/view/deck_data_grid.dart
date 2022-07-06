import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/opponent_deck_data_by_use_deck_provider.dart';

class DeckDataGrid extends HookConsumerWidget {
  const DeckDataGrid({
    Key? key,
    required this.deck,
  }) : super(key: key);

  final String deck;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameWinRateDataList = ref.watch(opponentDeckDataByUseDeckProvider(deck));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          deck,
          style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
      ),
      body: gameWinRateDataList.when(
        data: (gameWinRateDataList) {
          final source = _DeckWinRateDataSource(winRateDataList: gameWinRateDataList);
          return SfDataGridTheme(
            data: SfDataGridThemeData(
              frozenPaneElevation: 0,
              frozenPaneLineWidth: 1.5,
            ),
            child: SfDataGrid(
              source: source,
              frozenColumnsCount: 1,
              footerFrozenRowsCount: 1,
              allowSorting: true,
              allowMultiColumnSorting: true,
              allowTriStateSorting: true,
              verticalScrollPhysics: const ClampingScrollPhysics(),
              horizontalScrollPhysics: const ClampingScrollPhysics(),
              isScrollbarAlwaysShown: true,
              columns: [
                GridColumn(
                  columnName: 'デッキ名',
                  label: Center(
                    child: Text(
                      S.of(context).tableOpponentDeckName,
                      style: const TextStyle(),
                    ),
                  ),
                  width: 100,
                ),
                GridColumn(
                  columnName: '試合数',
                  label: Center(
                    child: Text(
                      S.of(context).tableGames,
                      style: const TextStyle(),
                    ),
                  ),
                  width: 75,
                ),
                GridColumn(
                  columnName: '勝',
                  label: Center(
                    child: Text(
                      S.of(context).tableWin,
                      style: const TextStyle(),
                    ),
                  ),
                  width: 60,
                ),
                GridColumn(
                  columnName: '負',
                  label: Center(
                    child: Text(
                      S.of(context).tableLoss,
                      style: const TextStyle(),
                    ),
                  ),
                  width: 60,
                ),
                GridColumn(
                  columnName: '勝率',
                  label: Center(
                    child: Text(
                      S.of(context).tableWinRate,
                      style: const TextStyle(),
                    ),
                  ),
                  width: 85,
                ),
                GridColumn(
                  columnName: '先攻勝率',
                  label: Center(
                    child: Text(
                      S.of(context).tableFirstWinRate,
                      style: const TextStyle(),
                    ),
                  ),
                  width: 85,
                ),
                GridColumn(
                  columnName: '後攻勝率',
                  label: Center(
                    child: Text(
                      S.of(context).tableSecondWinRate,
                      style: const TextStyle(),
                    ),
                  ),
                  width: 85,
                ),
              ],
            ),
          );
        },
        error: (error, stack) => Text(error.toString()),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}

class _DeckWinRateDataSource extends DataGridSource {
  _DeckWinRateDataSource({
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
