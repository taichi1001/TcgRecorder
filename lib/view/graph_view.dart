import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:tcg_recorder2/view/component/custom_scaffold.dart';
import 'package:tcg_recorder2/view/game_data_grid.dart';

class GraphView extends HookConsumerWidget {
  const GraphView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: CustomScaffold(
        appBarBottom: TabBar(
          indicator: MaterialIndicator(
            color: Colors.black,
            horizontalPadding: 16,
          ),
          tabs: const [
            Tab(
              icon: Icon(
                Icons.timer_off,
                color: Colors.black,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.timer_off,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: const TabBarView(
          children: [
            Center(
              child: GameDataGrid(),
            ),
            Center(
              child: Text('グラフ'),
            ),
          ],
        ),
      ),
    );
  }
}
