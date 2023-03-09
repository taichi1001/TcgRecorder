import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/enum/bottom_tab_item.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/bottom_navigation_bar_provider.dart';
import 'package:tcg_manager/repository/dynamic_links_repository.dart';
import 'package:tcg_manager/view/graph_view.dart';
import 'package:tcg_manager/view/input_view.dart';
import 'package:tcg_manager/view/other_view.dart';
import 'package:tcg_manager/view/record_list_view.dart';

class BottomNavigationView extends HookConsumerWidget {
  const BottomNavigationView({
    Key? key,
  }) : super(key: key);

  List<BottomTabItem> get _items => BottomTabItem.values;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      ref.read(dynamicLinksRepository).linkRecive(context);
      return;
    }, const []);
    final views = [
      const InputView(),
      const GraphView(),
      const RecordListView(),
      const OtherView(),
    ];
    final bottomTabState = ref.watch(bottomNavigationBarNotifierProvider);
    final bottomTabNotifier = ref.watch(bottomNavigationBarNotifierProvider.notifier);
    final int currentIndex = _items.indexOf(bottomTabState.viewItem);
    return Scaffold(
      body: views[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.border_color),
            label: S.of(context).bottomInput,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.analytics_outlined),
            label: S.of(context).bottomData,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.import_contacts),
            label: S.of(context).bottomList,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: S.of(context).bottomOther,
          ),
        ],
        onTap: bottomTabNotifier.select,
        currentIndex: currentIndex,
      ),
    );
  }
}
