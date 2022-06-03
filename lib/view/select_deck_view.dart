import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/helper/convert_sort_string.dart';
import 'package:tcg_manager/provider/select_deck_view_provider.dart';
import 'package:tcg_manager/selector/recently_use_deck_selector.dart';
import 'package:tcg_manager/selector/sorted_deck_list_selector.dart';

class SelectDeckView extends HookConsumerWidget {
  const SelectDeckView({key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentlyUseDeckList = ref.watch(recentlyUseDeckProvider);
    final gameDeckList = ref.watch(sortedRecordListProvider);

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
            _DeckListView(deckList: recentlyUseDeckList),
            const _AllListViewTitle(),
            _DeckListView(deckList: gameDeckList),
          ],
        ),
      ),
    );
  }
}

class _AllListViewTitle extends HookConsumerWidget {
  const _AllListViewTitle({key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(selectDeckViewNotifierProvider.select((value) => value.sortType));
    final selectDeckViewNotifier = ref.watch(selectDeckViewNotifierProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '一覧',
          style: Theme.of(context).textTheme.caption,
        ),
        CupertinoButton(
          onPressed: () => selectDeckViewNotifier.changeSort(),
          child: Text(
            ConvertSortString.convert(context, sort),
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ],
    );
  }
}

class _DeckListView extends HookConsumerWidget {
  const _DeckListView({
    required this.deckList,
    key,
  }) : super(key: key);

  final List<Deck> deckList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: ((context, index) {
        if (index == 0 || index == deckList.length + 1) {
          return Container();
        }
        return Container(
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).colorScheme.surface,
          child: Text(
            deckList[index - 1].deck,
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
      itemCount: deckList.length + 1,
    );
  }
}
