import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/provider/bottom_navigation_bar_provider.dart';
import 'package:tcg_manager/state/bottom_navigation_bar_state.dart';
import 'package:tcg_manager/view/graph_view.dart';
import 'package:tcg_manager/view/input_view.dart';
import 'package:tcg_manager/view/record_list_view.dart';

class BottomNavigationView extends HookConsumerWidget {
  const BottomNavigationView({
    Key? key,
  }) : super(key: key);

  List<BottomTabItem> get _items => BottomTabItem.values;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _views = [
      const InputView(),
      const GraphView(),
      const RecordListView(),
    ];
    final bottomTabState = ref.watch(bottomNavigationBarNotifierProvider);
    final bottomTabNotifier = ref.watch(bottomNavigationBarNotifierProvider.notifier);
    final int currentIndex = _items.indexOf(bottomTabState.viewItem);
    return MaterialApp(
      home: Scaffold(
        body: _views[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color(0xFF18204E),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.border_color,
              ),
              label: '入力',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart),
              label: 'グラフ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.import_contacts),
              label: '一覧',
            ),
          ],
          onTap: bottomTabNotifier.select,
          currentIndex: currentIndex,
        ),
      ),
    );
  }
}
