import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tcg_recorder2/provider/game_win_rate_data_source_provider.dart';

class GameDataGrid extends HookConsumerWidget {
  const GameDataGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final source = ref.watch(gameWinRateDataSourceNotifierProvider).gameWinRateDataSource;
    return source == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SfDataGrid(
            source: source,
            columns: [
              GridColumn(
                columnName: 'デッキ名',
                label: const Text('デッキ名'),
              ),
              GridColumn(
                columnName: '試合数',
                label: const Text('試合数'),
              ),
              GridColumn(
                columnName: '勝',
                label: const Text('勝'),
              ),
              GridColumn(
                columnName: '負',
                label: const Text('負'),
              ),
              GridColumn(
                columnName: '勝率',
                label: const Text('勝率'),
              ),
              GridColumn(
                columnName: '先攻勝率',
                label: const Text('先攻勝率'),
              ),
              GridColumn(
                columnName: '後攻勝率',
                label: const Text('後攻勝率'),
              ),
            ],
          );
  }
}
