import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/game_win_rate_data_source_provider.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
import 'package:tcg_manager/view/deck_data_grid.dart';

class GameDataGrid extends HookConsumerWidget {
  const GameDataGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final source = ref.watch(gameWinRateDataSourceProvider(context));
    return SfDataGridTheme(
      data: SfDataGridThemeData(
        frozenPaneElevation: 0,
        frozenPaneLineWidth: 1.5,
      ),
      child: SfDataGrid(
        source: source,
        frozenColumnsCount: 1,
        footerFrozenRowsCount: 1,
        verticalScrollPhysics: const ClampingScrollPhysics(),
        horizontalScrollPhysics: const ClampingScrollPhysics(),
        onCellTap: (details) {
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
      ),
    );
  }
}
