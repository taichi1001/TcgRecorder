import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/view/graph_view.dart';
import 'package:tcg_manager/view/input_view/input_view.dart';
import 'package:tcg_manager/view/other_view.dart';
import 'package:tcg_manager/view/record_list_view.dart';
import 'package:tcg_manager/view/share_view/share_view.dart';

final bottomNavItems = [
  const InputView(),
  const GraphView(),
  const RecordListView(),
  const ShareView(),
  const OtherView(),
];

final bottomNavItemProvider = Provider((ref) {
  return bottomNavItems[ref.watch(selectIndexProvider)];
});

final selectIndexProvider = StateProvider((ref) => 0);

class BottomNavigationView extends HookConsumerWidget {
  const BottomNavigationView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(bottomNavItemProvider),
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
          const BottomNavigationBarItem(
            icon: Icon(Icons.share),
            label: 'シェア',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: S.of(context).bottomOther,
          ),
        ],
        onTap: (value) => ref.read(selectIndexProvider.notifier).state = value,
        currentIndex: ref.watch(selectIndexProvider),
      ),
    );
  }
}
