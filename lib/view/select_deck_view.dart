import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/selector/recently_use_deck_selector.dart';

class SelectDeckView extends HookConsumerWidget {
  const SelectDeckView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ここが検索欄になる'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('最近使用したデッキ'),
            _RecentlyUsedView(),
            Text('一覧'),
            _AllListView(),
          ],
        ),
      ),
    );
  }
}

class _RecentlyUsedView extends HookConsumerWidget {
  const _RecentlyUsedView({key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(recentlyUseDeckProvider);
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: ((context, index) {
        if (index == 0 || index == list.length + 1) {
          return Container();
        }
        return ListTile(
          title: Text(list[index - 1].deck),
          tileColor: Theme.of(context).colorScheme.surface,
        );
      }),
      separatorBuilder: ((context, index) {
        return const Divider(
          indent: 16,
          thickness: 1,
          height: 0,
        );
      }),
      itemCount: list.length + 2,
    );
  }
}

class _AllListView extends HookConsumerWidget {
  const _AllListView({key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ['a', 'b', 'c', 'd', 'e'];
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: ((context, index) {
        return ListTile(
          title: Text(list[index]),
        );
      }),
      separatorBuilder: ((context, index) {
        return const Divider();
      }),
      itemCount: list.length,
    );
  }
}
