import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/graph_view_settings_provider.dart';
import 'package:tcg_manager/provider/opponent_deck_data_by_game_provider.dart';
import 'package:tcg_manager/provider/opponent_deck_data_by_use_deck_provider.dart';
import 'package:tcg_manager/provider/use_deck_data_by_game_provider.dart';
import 'package:tcg_manager/provider/use_deck_data_by_opponent_deck_provider.dart';
import 'package:tcg_manager/state/graph_view_settings_state.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
import 'package:tcg_manager/view/data_view/data_view.dart';

class UseDeckGameDataGrid extends HookConsumerWidget {
  const UseDeckGameDataGrid({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final winRateData = ref.watch(totalAddedToUseDeckDataByGameProvider);
    return winRateData.when(
      data: (data) => _GameDataGrid(winRateData: data, isUseDeckData: true),
      error: (error, stack) => Text(error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class OpponentDeckGameDataGrid extends HookConsumerWidget {
  const OpponentDeckGameDataGrid({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final winRateData = ref.watch(totalAddedToOpponentDeckDataByGameProvider);
    return winRateData.when(
      data: (data) => _GameDataGrid(winRateData: data, isUseDeckData: false),
      error: (error, stack) => Text(error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _GameDataGrid extends HookConsumerWidget {
  const _GameDataGrid({
    required this.winRateData,
    required this.isUseDeckData,
    key,
  }) : super(key: key);

  final List<WinRateData> winRateData;
  final bool isUseDeckData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final graphViewSettings = ref.watch(graphViewSettingsNotifierProvider);
    final isAggregated = ref.watch(isAggregatedDataProvider);

    final source = GameWinRateDataSource(winRateDataList: winRateData, context: context);
    return SfDataGridTheme(
      data: SfDataGridThemeData(
        sortIcon: SortIcon(source: source),
      ),
      child: SfDataGrid(
        source: source,
        frozenColumnsCount: 1,
        footerFrozenRowsCount: isAggregated ? 0 : 1,
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
                      child: _DeckDataGrid(
                        deck: source.effectiveRows[details.rowColumnIndex.rowIndex - 1].getCells().first.value,
                        isUseDeckData: isUseDeckData,
                      ),
                    ),
                    const AdaptiveBannerAd(),
                  ],
                ),
              ),
            ),
          );
        },
        columns: _getGridColumns(context, graphViewSettings),
      ),
    );
  }
}

class _DeckDataGrid extends HookConsumerWidget {
  const _DeckDataGrid({
    Key? key,
    required this.deck,
    required this.isUseDeckData,
  }) : super(key: key);

  final String deck;
  final bool isUseDeckData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<WinRateData>> winRateDataList;
    if (isUseDeckData) {
      winRateDataList = ref.watch(opponentDeckDataByUseDeckProvider(deck));
    } else {
      winRateDataList = ref.watch(useDeckDataByOpponentDeckProvider(deck));
    }
    final graphViewSettings = ref.watch(graphViewSettingsNotifierProvider);
    final isAggregated = ref.watch(isAggregatedDataProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(deck),
        elevation: 0.0,
      ),
      body: winRateDataList.when(
        data: (gameWinRateDataList) {
          final source = GameWinRateDataSource(winRateDataList: gameWinRateDataList, context: context);
          return SfDataGridTheme(
            data: SfDataGridThemeData(
              frozenPaneElevation: 0,
              frozenPaneLineWidth: 1.5,
              sortIcon: SortIcon(source: source),
            ),
            child: SfDataGrid(
              source: source,
              frozenColumnsCount: 1,
              footerFrozenRowsCount: isAggregated ? 0 : 1,
              allowSorting: true,
              allowMultiColumnSorting: true,
              allowTriStateSorting: true,
              verticalScrollPhysics: const ClampingScrollPhysics(),
              horizontalScrollPhysics: const ClampingScrollPhysics(),
              isScrollbarAlwaysShown: true,
              columns: _getGridColumns(context, graphViewSettings),
            ),
          );
        },
        error: (error, stack) => Text(error.toString()),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class SortIcon extends StatelessWidget {
  const SortIcon({
    super.key,
    required this.source,
  });

  final GameWinRateDataSource source;

  @override
  Widget build(BuildContext context) {
    Widget? icon;
    String columnName = '';
    context.visitAncestorElements((element) {
      if (element is GridHeaderCellElement) {
        columnName = element.column.columnName;
      }

      return true;
    });

    var column = source.sortedColumns.where((element) => element.name == columnName).firstOrNull;

    if (column != null) {
      if (column.sortDirection == DataGridSortDirection.ascending) {
        icon = const Padding(padding: EdgeInsets.symmetric(horizontal: 4), child: Icon(Icons.arrow_circle_up_rounded, size: 16));
      } else if (column.sortDirection == DataGridSortDirection.descending) {
        icon = const Padding(padding: EdgeInsets.symmetric(horizontal: 4), child: Icon(Icons.arrow_circle_down_rounded, size: 16));
      }
    }
    return icon ?? const SizedBox();
  }
}

List<GridColumn> _getGridColumns(BuildContext context, GraphViewSettingsState settings) {
  return [
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
      visible: settings.matches,
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
      visible: settings.firstMatches,
      columnName: '先攻試合数',
      label: const Center(
        child: Text(
          '先攻試合数',
          style: TextStyle(),
        ),
      ),
      width: 75,
    ),
    GridColumn(
      visible: settings.secondMatches,
      columnName: '後攻試合数',
      label: const Center(
        child: Text(
          '後攻試合数',
          style: TextStyle(),
        ),
      ),
      width: 75,
    ),
    GridColumn(
      visible: settings.win,
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
      visible: settings.loss,
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
      visible: settings.draw,
      columnName: '引き分け',
      label: const Center(
        child: Text(
          '引き分け',
          style: TextStyle(),
        ),
      ),
      width: 60,
    ),
    GridColumn(
      visible: settings.firstMatchesWin,
      columnName: '先攻勝',
      label: const Center(
        child: Text(
          '先攻勝',
          style: TextStyle(),
        ),
      ),
      width: 60,
    ),
    GridColumn(
      visible: settings.firstMatchesLoss,
      columnName: '先攻負',
      label: const Center(
        child: Text(
          '先攻負',
          style: TextStyle(),
        ),
      ),
      width: 60,
    ),
    GridColumn(
      visible: settings.firstMatchesDraw,
      columnName: '先攻引き分け',
      label: const Center(
        child: Text(
          '先攻引き分け',
          style: TextStyle(),
        ),
      ),
      width: 60,
    ),
    GridColumn(
      visible: settings.secondMatchesWin,
      columnName: '後攻勝',
      label: const Center(
        child: Text(
          '後攻勝',
          style: TextStyle(),
        ),
      ),
      width: 60,
    ),
    GridColumn(
      visible: settings.secondMatchesLoss,
      columnName: '後攻負',
      label: const Center(
        child: Text(
          '後攻負',
          style: TextStyle(),
        ),
      ),
      width: 60,
    ),
    GridColumn(
      visible: settings.secondMatchesDraw,
      columnName: '後攻引き分け',
      label: const Center(
        child: Text(
          '後攻引き分け',
          style: TextStyle(),
        ),
      ),
      width: 60,
    ),
    GridColumn(
      visible: settings.winRate,
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
      visible: settings.firstWinRate,
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
      visible: settings.secondWinRate,
      columnName: '後攻勝率',
      label: Center(
        child: Text(
          S.of(context).tableSecondWinRate,
          style: const TextStyle(),
        ),
      ),
      width: 85,
    ),
  ];
}

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
              DataGridCell(columnName: '先攻試合数', value: winRateData.firstMatches),
              DataGridCell(columnName: '後攻試合数', value: winRateData.secondMatches),
              DataGridCell(columnName: '勝', value: winRateData.win),
              DataGridCell(columnName: '負', value: winRateData.loss),
              DataGridCell(columnName: '引き分け', value: winRateData.draw),
              DataGridCell(columnName: '先攻勝', value: winRateData.firstMatchesWin),
              DataGridCell(columnName: '先攻負', value: winRateData.firstMatchesLoss),
              DataGridCell(columnName: '先攻引き分け', value: winRateData.firstMatchesDraw),
              DataGridCell(columnName: '後攻勝', value: winRateData.secondMatchesWin),
              DataGridCell(columnName: '後攻負', value: winRateData.secondMatchesLoss),
              DataGridCell(columnName: '後攻引き分け', value: winRateData.secondMatchesDraw),
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
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
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
    if (cell.columnName == '先攻試合数') {
      return Text(cell.value.toString());
    }
    if (cell.columnName == '後攻試合数') {
      return Text(cell.value.toString());
    }
    if (cell.columnName == '勝') {
      return Text(cell.value.toString());
    }
    if (cell.columnName == '負') {
      return Text(cell.value.toString());
    }
    if (cell.columnName == '引き分け') {
      return Text(cell.value.toString());
    }
    if (cell.columnName == '先攻勝') {
      return Text(cell.value.toString());
    }
    if (cell.columnName == '先攻負') {
      return Text(cell.value.toString());
    }
    if (cell.columnName == '先攻引き分け') {
      return Text(cell.value.toString());
    }
    if (cell.columnName == '後攻勝') {
      return Text(cell.value.toString());
    }
    if (cell.columnName == '後攻負') {
      return Text(cell.value.toString());
    }
    if (cell.columnName == '後攻引き分け') {
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
