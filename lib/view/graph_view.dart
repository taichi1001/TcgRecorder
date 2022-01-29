import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:tcg_recorder2/selector/game_record_list_selector.dart';
import 'package:tcg_recorder2/view/component/custom_scaffold.dart';
import 'package:tcg_recorder2/view/game_data_grid.dart';

class GraphView extends HookConsumerWidget {
  const GraphView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordList = ref.watch(gameRecordListProvider);
    return DefaultTabController(
      length: 2,
      child: CustomScaffold(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
        appBarBottom: TabBar(
          labelColor: const Color(0xFF18204E),
          unselectedLabelColor: Colors.black38,
          indicator: MaterialIndicator(
            color: const Color(0xFF18204E),
            horizontalPadding: 16,
            height: 3,
          ),
          tabs: const [
            Tab(
              icon: Icon(
                Icons.table_rows,
                // color: Colors.black,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.pie_chart_outline,
                // color: Colors.black,
              ),
            )
          ],
        ),
        body: TabBarView(
          children: [
            Center(
              child: recordList.isEmpty ? const Center(child: Text('このゲームの記録はありません')) : const GameDataGrid(),
            ),
            Center(
              child: recordList.isEmpty ? const Center(child: Text('このゲームの記録はありません')) : const Text('グラフ'),
            ),
          ],
        ),
      ),
    );
  }
}
