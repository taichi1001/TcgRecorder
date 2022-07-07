import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/use_deck_data_by_game_provider.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
import 'package:tcg_manager/view/deck_data_grid.dart';

class GameDataGrid extends HookConsumerWidget {
  const GameDataGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameWinRateDataList = ref.watch(totalAddedToUseDeckDataByGameProvider);
    return gameWinRateDataList.when(
      data: (gameWinRateDataList) {
        final source = _GameWinRateDataSource(winRateDataList: gameWinRateDataList, context: context);
        return SfDataGrid(
          source: source,
          frozenColumnsCount: 1,
          footerFrozenRowsCount: 1,
          allowSorting: true,
          allowMultiColumnSorting: true,
          allowTriStateSorting: true,
          verticalScrollPhysics: const ClampingScrollPhysics(),
          horizontalScrollPhysics: const ClampingScrollPhysics(),
          isScrollbarAlwaysShown: true,
          onCellTap: (details) {
            final dataIndex = details.rowColumnIndex.rowIndex;
            if (dataIndex == 0) return; // カラム名が書いてある列がタップされた場合
            if (dataIndex == source.dataGridRows.length) return; // 合計カラムがタップされた場合
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      Expanded(
                        child: DeckDataGrid(deck: source.effectiveRows[details.rowColumnIndex.rowIndex - 1].getCells().first.value),
                      ),
                      const AdaptiveBannerAd(),
                    ],
                  ),
                ),
              ),
            );
          },
          columns: [
            GridColumn(
              columnName: 'デッキ名',
              label: Center(
                child: Text(
                  S.of(context).tableDeckName,
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
        );
      },
      error: (error, stack) => Text('$error'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _GameWinRateDataSource extends DataGridSource {
  _GameWinRateDataSource({
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
        return Text(S.of(context).tableSum);
      } else {
        return Text(
          cell.value.toString(),
          maxLines: 2,
          style: Theme.of(context).textTheme.overline?.copyWith(
                overflow: TextOverflow.ellipsis,
                leadingDistribution: TextLeadingDistribution.even,
                height: 1,
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
