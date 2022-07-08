import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/enum/sort.dart';
import 'package:tcg_manager/helper/convert_sort_string.dart';
import 'package:tcg_manager/provider/select_tag_view_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/repository/tag_repository.dart';
import 'package:tcg_manager/selector/recently_use_tag_selector.dart';
import 'package:tcg_manager/selector/search_tag_list_selector.dart';
import 'package:tcg_manager/selector/sorted_tag_list_selector.dart';

class SelectTagViewInfo {
  const SelectTagViewInfo({
    required this.gameTagList,
    required this.searchTagList,
    required this.recentlyUseTagList,
  });

  final List<Tag> gameTagList;
  final List<Tag> searchTagList;
  final List<Tag> recentlyUseTagList;
}

final selectTagViewInfoProvider = FutureProvider.autoDispose<SelectTagViewInfo>((ref) async {
  final gameTagList = await ref.watch(sortedTagListProvider.future);
  final searchTagList = await ref.watch(searchTagListProvider.future);
  final recentlyUseTagList = await ref.watch(recentlyUseTagProvider.future);
  return SelectTagViewInfo(
    gameTagList: gameTagList,
    searchTagList: searchTagList,
    recentlyUseTagList: recentlyUseTagList,
  );
});

class SelectTagView extends HookConsumerWidget {
  const SelectTagView({
    required this.selectTagFunc,
    key,
  }) : super(key: key);

  final Function(Tag) selectTagFunc;

  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(BuildContext rootContext, WidgetRef ref) {
    final selectTagViewNotifier = ref.watch(selectTagViewNotifierProvider.notifier);
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
      selectTagViewNotifier.setSearchText(searchTextController.text);
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
                final selectTagViewInfo = ref.watch(selectTagViewInfoProvider);
                final searchText = ref.watch(selectTagViewNotifierProvider.select((value) => value.searchText));
                return selectTagViewInfo.when(
                  data: (selectTagViewInfo) {
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
                            child: (() {
                              // 検索結果がなかったときの表示
                              if (isSearch.value && selectTagViewInfo.searchTagList.isEmpty && searchText != '') {
                                return GestureDetector(
                                  onTap: () {
                                    selectTagViewNotifier.saveTag(searchText);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    color: Theme.of(context).colorScheme.surface,
                                    child: Text(
                                      '「$searchText」を登録する',
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ),
                                );
                                // 検索結果があった場合の表示
                              } else if (isSearch.value) {
                                return _TagListView(
                                  tagList: selectTagViewInfo.searchTagList,
                                  rootContext: rootContext,
                                  selectTagFunc: selectTagFunc,
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
                                    _TagListView(
                                      tagList: selectTagViewInfo.recentlyUseTagList,
                                      rootContext: rootContext,
                                      selectTagFunc: selectTagFunc,
                                    ),
                                    const _AllListViewTitle(),
                                    _TagListView(
                                      tagList: selectTagViewInfo.gameTagList,
                                      rootContext: rootContext,
                                      selectTagFunc: selectTagFunc,
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
  const _AllListViewTitle({key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(selectTagViewNotifierProvider.select((value) => value.sortType));
    final selectTagViewNotifier = ref.watch(selectTagViewNotifierProvider.notifier);
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
                        builder: (context) => const ReordableTagView(),
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
                onPressed: () => selectTagViewNotifier.changeSort(),
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

class _TagListView extends StatelessWidget {
  const _TagListView({
    required this.tagList,
    required this.rootContext,
    required this.selectTagFunc,
    key,
  }) : super(key: key);

  final List<Tag> tagList;
  final BuildContext rootContext;
  final Function(Tag) selectTagFunc;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemBuilder: ((context, index) {
        if (index == 0 || index == tagList.length + 1) {
          return Container();
        }
        return GestureDetector(
          onTap: () {
            selectTagFunc(tagList[index - 1]);
            Navigator.pop(rootContext);
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surface,
            child: Text(
              tagList[index - 1].tag,
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
      itemCount: tagList.length + 1,
    );
  }
}

class _ReorderableTagListView extends HookConsumerWidget {
  const _ReorderableTagListView({
    required this.tagList,
    key,
  }) : super(key: key);

  final List<Tag> tagList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: ReorderableListView.builder(
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          return ListTile(
            key: Key(tagList[index].tagId.toString()),
            tileColor: Theme.of(context).colorScheme.surface,
            title: Text(
              tagList[index].tag,
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
          final moveTag = tagList.removeAt(oldIndex);
          tagList.insert(newIndex, moveTag);
          final List<Tag> newTagList = [];
          tagList.asMap().forEach((index, tag) {
            tag = tag.copyWith(sortIndex: index);
            newTagList.add(tag);
          });
          await ref.read(tagRepository).updateSortIndex(newTagList);
          ref.refresh(allTagListProvider);
        },
        itemCount: tagList.length,
      ),
    );
  }
}

class ReordableTagView extends HookConsumerWidget {
  const ReordableTagView({key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameTagList = ref.watch(sortedTagListProvider);

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
      body: gameTagList.when(
        data: (gameTagList) {
          return _ReorderableTagListView(tagList: gameTagList);
        },
        error: (error, stack) => Text('$error'),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
