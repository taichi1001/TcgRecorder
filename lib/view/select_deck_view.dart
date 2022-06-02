import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
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
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '最近使用したデッキ',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            const _RecentlyUsedView(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '一覧',
                  style: Theme.of(context).textTheme.caption,
                ),
                CupertinoButton(
                  onPressed: () {
                    // recordListViewNotifier.toggleSort();
                  },
                  child: Text(
                    // ConvertSortString.convert(context, sort),
                    '新しい順',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ],
            ),
            const _AllListView(),
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
        return Container(
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).colorScheme.surface,
          child: Text(
            list[index - 1].deck,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      }),
      separatorBuilder: ((context, index) {
        return const Divider(
          indent: 16,
          thickness: 1,
          height: 0,
        );
      }),
      itemCount: list.length + 1,
    );
  }
}

class _AllListView extends HookConsumerWidget {
  const _AllListView({key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(gameDeckListProvider);
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: ((context, index) {
        if (index == 0 || index == list.length + 1) {
          return Container();
        }
        return Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          color: Theme.of(context).colorScheme.surface,
          child: Text(
            list[index - 1].deck,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      }),
      separatorBuilder: ((context, index) {
        return const Divider(
          indent: 16,
          thickness: 1,
          height: 0,
        );
      }),
      itemCount: list.length + 1,
    );
  }
}
