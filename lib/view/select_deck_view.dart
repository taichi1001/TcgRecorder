import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/helper/convert_sort_string.dart';
import 'package:tcg_manager/provider/input_view_provider.dart';
import 'package:tcg_manager/provider/select_deck_view_provider.dart';
import 'package:tcg_manager/selector/recently_use_deck_selector.dart';
import 'package:tcg_manager/selector/sorted_deck_list_selector.dart';

class SelectDeckView extends HookConsumerWidget {
  const SelectDeckView({key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentlyUseDeckList = ref.watch(recentlyUseDeckProvider);
    final gameDeckList = ref.watch(sortedRecordListProvider);
    final searchTextController = useTextEditingController();
    final searchFocusNode = useFocusNode();
    final isSearch = useState(false);

    searchFocusNode.addListener(() {
      isSearch.value = searchFocusNode.hasFocus;
    });

    searchTextController.addListener(() {
      print(searchTextController.text);
    });

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchTextController,
          focusNode: searchFocusNode,
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Visibility(
          visible: !isSearch.value,
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
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
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
      ),
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
    final inputViewNotifier = ref.watch(inputViewNotifierProvider.notifier);
    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: ((context, index) {
        if (index == 0 || index == deckList.length + 1) {
          return Container(
            key: UniqueKey(),
          );
        }
        return GestureDetector(
          key: Key(deckList[index - 1].deckId.toString()),
          // onTap: () {
          //   inputViewNotifier.selectUseDeck(deckList[index - 1]);
          //   Navigator.pop(context);
          // },
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surface,
            child: Text(
              deckList[index - 1].deck,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        );
      }),
      onReorder: (oldIndex, newIndex) {
        if (oldIndex - 1 < newIndex - 1) {
          newIndex -= 1;
        }
        final deck = deckList.removeAt(oldIndex - 1);
        deckList.insert(newIndex - 1, deck);
        ref.read(sortedRecordListProvider.notifier).state = deckList;
      },
      // separatorBuilder: ((context, index) {
      //   return const Divider(
      //     indent: 16,
      //     thickness: 1,
      //     height: 0,
      //   );
      // }),
      itemCount: deckList.length + 1,
    );
  }
}
