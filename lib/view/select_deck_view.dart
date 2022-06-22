import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/enum/sort.dart';
import 'package:tcg_manager/helper/convert_sort_string.dart';
import 'package:tcg_manager/provider/input_view_provider.dart';
import 'package:tcg_manager/provider/select_deck_view_provider.dart';
import 'package:tcg_manager/selector/recently_use_deck_selector.dart';
import 'package:tcg_manager/selector/sorted_deck_list_selector.dart';

class SelectDeckView extends HookConsumerWidget {
  const SelectDeckView({key}) : super(key: key);

  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(BuildContext rootContext, WidgetRef ref) {
    final recentlyUseDeckList = ref.watch(recentlyUseDeckProvider);
    final gameDeckList = ref.watch(sortedDeckListProvider);
    final searchTextController = useTextEditingController(text: '');
    final searchFocusNode = useFocusNode();
    final isSearch = useState(false);

    searchFocusNode.addListener(() {
      isSearch.value = searchFocusNode.hasFocus;
    });

    searchTextController.addListener(() {
      print(searchTextController.text);
    });

    return Material(
      child: Navigator(
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (context2) => Builder(
            builder: (context) => Scaffold(
              appBar: AppBar(
                leading: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
                actions: [
                  TextButton(
                    onPressed: searchTextController.text == ''
                        ? null
                        : () {
                            print(searchTextController.text);
                            searchTextController.text = '';
                          },
                    child: Text(
                      'クリア',
                      style: searchTextController.text == ''
                          ? Theme.of(context).textTheme.caption?.copyWith(color: Colors.grey)
                          : Theme.of(context).textTheme.caption,
                    ),
                  ),
                ],
                titleSpacing: 0,
                backgroundColor: Theme.of(context).colorScheme.surface,
                title: TextField(
                  controller: searchTextController,
                  focusNode: searchFocusNode,
                  decoration: const InputDecoration(
                    labelText: '検索',
                  ),
                ),
              ),
              // 最後までスクロールした時に出るアニメーションを消すために入れている
              body: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: NestedScrollView(
                  controller: ScrollController(),
                  headerSliverBuilder: (context, innnerBoxIsScrolled) => [], // headerは必要ないため空を返す
                  body: SingleChildScrollView(
                    controller: ModalScrollController.of(context),
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
                          _DeckListView(
                            deckList: recentlyUseDeckList,
                            rootContext: rootContext,
                          ),
                          const _AllListViewTitle(),
                          _DeckListView(
                            deckList: gameDeckList,
                            rootContext: rootContext,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
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
          Row(
            children: [
              if (sort == Sort.custom)
                CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReordableDeckView(),
                      ),
                    );
                  },
                  child: Text(
                    '並び替え',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
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
        ],
      ),
    );
  }
}

class _DeckListView extends HookConsumerWidget {
  const _DeckListView({
    required this.deckList,
    required this.rootContext,
    key,
  }) : super(key: key);

  final List<Deck> deckList;
  final BuildContext rootContext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputViewNotifier = ref.watch(inputViewNotifierProvider.notifier);
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: ((context, index) {
        if (index == 0 || index == deckList.length + 1) {
          return Container();
        }
        return GestureDetector(
          onTap: () {
            inputViewNotifier.selectUseDeck(deckList[index - 1]);
            Navigator.pop(rootContext);
          },
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

class _ReorderableDeckListView extends HookConsumerWidget {
  const _ReorderableDeckListView({
    required this.deckList,
    key,
  }) : super(key: key);

  final List<Deck> deckList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final inputViewNotifier = ref.watch(inputViewNotifierProvider.notifier);
    return ReorderableListView.builder(
      shrinkWrap: true,
      buildDefaultDragHandles: false,
      itemBuilder: ((context, index) {
        return ListTile(
          key: Key(deckList[index].deckId.toString()),
          tileColor: Theme.of(context).colorScheme.surface,
          title: Text(
            deckList[index].deck,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: ReorderableDragStartListener(
            index: index,
            child: const Icon(Icons.drag_handle),
          ),
        );
      }),
      onReorder: (oldIndex, newIndex) {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        final deck = deckList.removeAt(oldIndex);
        deckList.insert(newIndex, deck);
        ref.watch(sortedDeckListProvider.notifier).state = deckList;
      },
      itemCount: deckList.length,
    );
  }
}

class ReordableDeckView extends HookConsumerWidget {
  const ReordableDeckView({key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameDeckList = ref.watch(sortedDeckListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('並び替え'),
      ),
      body: _ReorderableDeckListView(deckList: gameDeckList),
    );
  }
}
