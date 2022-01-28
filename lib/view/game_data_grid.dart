import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
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
        : SfDataGridTheme(
            data: SfDataGridThemeData(
              headerColor: const Color(0xFF18204E),
            ),
            child: SfDataGrid(
              source: source,
              columns: [
                GridColumn(
                  columnName: 'デッキ名',
                  label: const Center(
                    child: Text(
                      'デッキ名',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  width: 100,
                ),
                GridColumn(
                  columnName: '試合数',
                  label: const Center(
                    child: Text(
                      '試合数',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  width: 75,
                ),
                GridColumn(
                  columnName: '勝',
                  label: const Center(
                    child: Text(
                      '勝',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  width: 60,
                ),
                GridColumn(
                  columnName: '負',
                  label: const Center(
                    child: Text(
                      '負',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  width: 60,
                ),
                GridColumn(
                  columnName: '勝率',
                  label: const Center(
                    child: Text(
                      '勝率',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  width: 85,
                ),
                GridColumn(
                  columnName: '先攻勝率',
                  label: const Center(
                    child: Text(
                      '先攻勝率',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  width: 85,
                ),
                GridColumn(
                  columnName: '後攻勝率',
                  label: const Center(
                    child: Text(
                      '後攻勝率',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  width: 80,
                ),
              ],
            ),
          );
  }
}
