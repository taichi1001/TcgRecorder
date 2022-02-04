import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tcg_manager/provider/deck_win_rate_data_source_provider.dart';

class DeckDataGrid extends HookConsumerWidget {
  const DeckDataGrid({
    Key? key,
    required this.deck,
  }) : super(key: key);

  final String deck;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final source = ref.watch(deckWinRateDataSourceNotifierProvider(deck)).deckWinRateDataSource;
    return source == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              centerTitle: false,
              title: Text(
                deck,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            backgroundColor: Colors.white,
            body: SfDataGridTheme(
              data: SfDataGridThemeData(
                headerColor: const Color(0xFF18204E),
                frozenPaneElevation: 0,
                frozenPaneLineWidth: 1.5,
              ),
              child: SfDataGrid(
                source: source,
                frozenColumnsCount: 1,
                footerFrozenRowsCount: 1,
                columns: [
                  GridColumn(
                    columnName: 'デッキ名',
                    label: const Center(
                      child: Text(
                        '対戦デッキ名',
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
                    width: 85,
                  ),
                ],
              ),
            ),
          );
  }
}
