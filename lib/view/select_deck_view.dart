import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/enum/sort.dart';
import 'package:tcg_manager/helper/convert_sort_string.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/select_deck_view_provider.dart';
import 'package:tcg_manager/repository/deck_repository.dart';
import 'package:tcg_manager/selector/recently_use_deck_selector.dart';
import 'package:tcg_manager/selector/search_deck_list_selector.dart';
import 'package:tcg_manager/selector/search_exact_match_deck_selector.dart';
import 'package:tcg_manager/selector/sorted_deck_list_selector.dart';

class SelectDeckViewInfo {
  const SelectDeckViewInfo({
    required this.gameDeckList,
    required this.searchDeckList,
    required this.recentlyUseDeckList,
  });

  final List<Deck> gameDeckList;
  final List<Deck> searchDeckList;
  final List<Deck> recentlyUseDeckList;
}

final selectDeckViewInfoProvider = FutureProvider.autoDispose<SelectDeckViewInfo>((ref) async {
  final gameDeckList = await ref.watch(sortedDeckListProvider.future);
  final searchDeckList = await ref.watch(searchDeckListProvider.future);
  final recentlyUseDeckList = await ref.watch(recentlyUseDeckProvider.future);
  return SelectDeckViewInfo(
    gameDeckList: gameDeckList,
    searchDeckList: searchDeckList,
    recentlyUseDeckList: recentlyUseDeckList,
  );
});

class SelectDeckView extends HookConsumerWidget {
  const SelectDeckView({
    required this.selectDeckFunc,
    this.enableVisiblity = false,
    key,
  }) : super(key: key);

  final Function(Deck) selectDeckFunc;
  final bool enableVisiblity;

  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(BuildContext rootContext, WidgetRef ref) {
    final selectDeckViewNotifier = ref.watch(selectDeckViewNotifierProvider.notifier);
    final searchTextController = useTextEditingController(text: '');
    final searchFocusNode = useFocusNode();
    final isSearchFocus = useState(false);
    final isSearchText = useState(false);
    final isSearch = useState(false);

    searchFocusNode.addListener(() {
      isSearchFocus.value = searchFocusNode.hasFocus;
      isSearch.value = isSearchFocus.value || isSearchText.value;
    });

    searchTextController.addListener(() {
      selectDeckViewNotifier.setSearchText(searchTextController.text);
      if (searchTextController.text == '') {
        isSearchText.value = false;
      } else {
        isSearchText.value = true;
      }
      isSearch.value = isSearchFocus.value || isSearchText.value;
    });
    return Material(
      child: SafeArea(
        child: Navigator(
          onGenerateRoute: (_) => MaterialPageRoute(
            builder: (context2) => Builder(
              builder: (context) {
                // こいつだけここに置かないと更新されなかった。理由は不明。
                final searchText = ref.watch(selectDeckViewNotifierProvider.select((value) => value.searchText));
                final selectDeckViewInfo = ref.watch(selectDeckViewInfoProvider);
                final searchExactMatchTag = ref.watch(searchExactMatchDeckProvider);
                return selectDeckViewInfo.when(
                  data: (selectDeckViewInfo) {
                    return Scaffold(
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
                            // 即時関数で作ってる
                            child: (() {
                              // 検索結果がなかったときの表示
                              if (isSearch.value && selectDeckViewInfo.searchDeckList.isEmpty && searchText != '') {
                                return GestureDetector(
                                  onTap: () {
                                    selectDeckViewNotifier.saveDeck(searchText);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    width: double.infinity,
                                    color: Theme.of(context).colorScheme.surface,
                                    child: Text(
                                      '「$searchText」を登録する',
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ),
                                );
                                // 完全一致の検索結果があった場合
                              } else if (isSearch.value &&
                                  selectDeckViewInfo.searchDeckList.isNotEmpty &&
                                  searchExactMatchTag.asData?.value != null &&
                                  searchText != '') {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Text(
                                        '検索結果',
                                        style: Theme.of(context).textTheme.caption,
                                      ),
                                    ),
                                    _DeckListView(
                                      deckList: selectDeckViewInfo.searchDeckList,
                                      rootContext: rootContext,
                                      selectDeckFunc: selectDeckFunc,
                                      enableVisibility: enableVisiblity,
                                    ),
                                  ],
                                );
                                // 検索結果はあるが完全一致はない場合の表示
                              } else if (isSearch.value &&
                                  selectDeckViewInfo.searchDeckList.isNotEmpty &&
                                  searchExactMatchTag.asData?.value == null &&
                                  searchText != '') {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        selectDeckViewNotifier.saveDeck(searchText);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        width: double.infinity,
                                        color: Theme.of(context).colorScheme.surface,
                                        child: Text(
                                          '「$searchText」を登録する',
                                          style: Theme.of(context).textTheme.bodyMedium,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Text(
                                        '検索結果',
                                        style: Theme.of(context).textTheme.caption,
                                      ),
                                    ),
                                    _DeckListView(
                                      deckList: selectDeckViewInfo.searchDeckList,
                                      rootContext: rootContext,
                                      selectDeckFunc: selectDeckFunc,
                                      enableVisibility: enableVisiblity,
                                    ),
                                  ],
                                );
                                // 検索していない場合の表示
                              } else {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Text(
                                        '最近使用したデッキ',
                                        style: Theme.of(context).textTheme.caption,
                                      ),
                                    ),
                                    _DeckListView(
                                      deckList: selectDeckViewInfo.recentlyUseDeckList,
                                      rootContext: rootContext,
                                      selectDeckFunc: selectDeckFunc,
                                      enableVisibility: enableVisiblity,
                                    ),
                                    _AllListViewTitle(
                                      enableVisiblity: enableVisiblity,
                                    ),
                                    _DeckListView(
                                      deckList: selectDeckViewInfo.gameDeckList,
                                      rootContext: rootContext,
                                      selectDeckFunc: selectDeckFunc,
                                      enableVisibility: enableVisiblity,
                                    ),
                                  ],
                                );
                              }
                            })(),
                          ),
                        ),
                      ),
                    );
                  },
                  error: (error, stack) => Text('$error'),
                  loading: () => const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _AllListViewTitle extends HookConsumerWidget {
  const _AllListViewTitle({
    required this.enableVisiblity,
    key,
  }) : super(key: key);

  final bool enableVisiblity;

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
              Visibility(
                visible: sort == Sort.custom,
                child: CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReordableDeckView(
                          enableVisiblity: enableVisiblity,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    '並び替え',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
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

class _DeckListView extends StatelessWidget {
  const _DeckListView({
    required this.deckList,
    required this.rootContext,
    required this.selectDeckFunc,
    required this.enableVisibility,
    key,
  }) : super(key: key);

  final List<Deck> deckList;
  final BuildContext rootContext;
  final Function(Deck) selectDeckFunc;
  final bool enableVisibility;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemBuilder: ((context, index) {
        if (index == 0 || index == deckList.length + 1) return Container();
        if (enableVisibility && !deckList[index - 1].isVisibleToPicker) return Container();
        return GestureDetector(
          onTap: () {
            selectDeckFunc(deckList[index - 1]);
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
    required this.enableVisibility,
    key,
  }) : super(key: key);

  final List<Deck> deckList;
  final bool enableVisibility;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: ReorderableListView.builder(
        shrinkWrap: true,
        buildDefaultDragHandles: false,
        itemBuilder: ((context, index) {
          if (enableVisibility && !deckList[index].isVisibleToPicker) return Container(key: Key(deckList[index].deckId.toString()));
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
        onReorder: (oldIndex, newIndex) async {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final moveDeck = deckList.removeAt(oldIndex);
          deckList.insert(newIndex, moveDeck);
          final List<Deck> newDeckList = [];
          deckList.asMap().forEach((index, deck) {
            deck = deck.copyWith(sortIndex: index);
            newDeckList.add(deck);
          });
          await ref.read(deckRepository).updateSortIndex(newDeckList);
          ref.refresh(allDeckListProvider);
        },
        itemCount: deckList.length,
      ),
    );
  }
}

class ReordableDeckView extends HookConsumerWidget {
  const ReordableDeckView({
    required this.enableVisiblity,
    key,
  }) : super(key: key);
  final bool enableVisiblity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameDeckList = ref.watch(sortedDeckListProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          '並び替え',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: gameDeckList.when(
        data: (gameDeckList) {
          return _ReorderableDeckListView(
            deckList: gameDeckList,
            enableVisibility: enableVisiblity,
          );
        },
        error: (error, stack) => Text('$error'),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
