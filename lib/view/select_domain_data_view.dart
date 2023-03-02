// ignore_for_file: unused_result

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/domain_data.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/enum/sort.dart';
import 'package:tcg_manager/helper/convert_sort_string.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/record_list_view_provider.dart';
import 'package:tcg_manager/provider/select_domain_data_view_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/repository/deck_repository.dart';
import 'package:tcg_manager/repository/game_repository.dart';
import 'package:tcg_manager/repository/tag_repository.dart';
import 'package:tcg_manager/selector/search_exact_match_domain_data_selector.dart';
import 'package:tcg_manager/selector/select_domain_view_info_selector.dart';
import 'package:tcg_manager/selector/sorted_domain_data_list_selector.dart';

class SelectDomainDataView extends HookConsumerWidget {
  const SelectDomainDataView({
    required this.selectDomainDataFunc,
    required this.tagCount,
    required this.dataType,
    this.deselectionFunc,
    this.afterFunc,
    this.enableVisiblity = false,
    this.returnSelecting = true,
    key,
  }) : super(key: key);

  final Function(DomainData, int) selectDomainDataFunc;
  final Function(DomainData)? deselectionFunc;
  final DomainDataType dataType;
  final Function? afterFunc;
  final bool enableVisiblity;
  final int tagCount;
  final bool returnSelecting;

  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(BuildContext rootContext, WidgetRef ref) {
    final selectDomainDataViewNotifier = ref.watch(selectDomainDataViewNotifierProvider(dataType).notifier);
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
      selectDomainDataViewNotifier.setSearchText(searchTextController.text);
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
                final selectDomainViewInfo = ref.watch(selectDomainViewInfoProvider(dataType));
                final searchText = ref.watch(selectDomainDataViewNotifierProvider(dataType).select((value) => value.searchText));
                final searchExactMatchDomainData = ref.watch(searchExactMatchDomainDataProvider(dataType));
                final selectetDomainDataList = ref.watch(recordListViewNotifierProvider.select((value) => value.tagList));

                return selectDomainViewInfo.when(
                  data: (selectDomainViewInfo) {
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
                                  ? Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)
                                  : Theme.of(context).textTheme.bodySmall,
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
                              // 検索結果がなかった場合
                              if (isSearch.value && selectDomainViewInfo.searchDomainDataList.isEmpty && searchText != '') {
                                return GestureDetector(
                                  onTap: () {
                                    selectDomainDataViewNotifier.saveDomainData(searchText);
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
                                  selectDomainViewInfo.searchDomainDataList.isNotEmpty &&
                                  searchExactMatchDomainData.asData?.value != null &&
                                  searchText != '') {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Text(
                                        '検索結果',
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                    ),
                                    _DomainDataListView(
                                      domainDataList: selectDomainViewInfo.searchDomainDataList,
                                      selectedDomainDataList: selectetDomainDataList,
                                      rootContext: rootContext,
                                      selectDomainDataFunc: selectDomainDataFunc,
                                      enableVisibility: false,
                                      afterFunc: afterFunc,
                                      deselectionFunc: deselectionFunc,
                                      tagCount: tagCount,
                                      returnSelecting: returnSelecting,
                                    ),
                                  ],
                                );
                                // 完全一致はないが検索結果がある場合
                              } else if (isSearch.value &&
                                  selectDomainViewInfo.searchDomainDataList.isNotEmpty &&
                                  searchExactMatchDomainData.asData?.value == null &&
                                  searchText != '') {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        selectDomainDataViewNotifier.saveDomainData(searchText);
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
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                    ),
                                    _DomainDataListView(
                                      domainDataList: selectDomainViewInfo.searchDomainDataList,
                                      selectedDomainDataList: selectetDomainDataList,
                                      rootContext: rootContext,
                                      selectDomainDataFunc: selectDomainDataFunc,
                                      deselectionFunc: deselectionFunc,
                                      enableVisibility: false,
                                      afterFunc: afterFunc,
                                      tagCount: tagCount,
                                      returnSelecting: returnSelecting,
                                    ),
                                  ],
                                );
                                // 検索していない場合の表示
                              } else {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    if (dataType != DomainDataType.game)
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Text(
                                          '最近記録した${dataType.displayName}',
                                          style: Theme.of(context).textTheme.bodySmall,
                                        ),
                                      ),
                                    if (dataType != DomainDataType.game)
                                      _DomainDataListView(
                                        domainDataList: selectDomainViewInfo.recentlyUseDomainDataList,
                                        selectedDomainDataList: selectetDomainDataList,
                                        rootContext: rootContext,
                                        selectDomainDataFunc: selectDomainDataFunc,
                                        deselectionFunc: deselectionFunc,
                                        enableVisibility: false,
                                        afterFunc: afterFunc,
                                        tagCount: tagCount,
                                        returnSelecting: returnSelecting,
                                      ),
                                    _AllListViewTitle(
                                      enableVisiblity: enableVisiblity,
                                      dataType: dataType,
                                    ),
                                    _DomainDataListView(
                                      domainDataList: selectDomainViewInfo.gameDomainDataList,
                                      selectedDomainDataList: selectetDomainDataList,
                                      rootContext: rootContext,
                                      selectDomainDataFunc: selectDomainDataFunc,
                                      deselectionFunc: deselectionFunc,
                                      enableVisibility: enableVisiblity,
                                      afterFunc: afterFunc,
                                      tagCount: tagCount,
                                      returnSelecting: returnSelecting,
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
    required this.dataType,
    key,
  }) : super(key: key);

  final bool enableVisiblity;
  final DomainDataType dataType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(selectDomainDataViewNotifierProvider(dataType).select((value) => value.sortType));
    final selectDomainDataViewNotifier = ref.watch(selectDomainDataViewNotifierProvider(dataType).notifier);
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '一覧',
            style: Theme.of(context).textTheme.bodySmall,
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
                        builder: (context) => ReordableDomainDataView(
                          datatype: dataType,
                          enableVisiblity: enableVisiblity,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    '設定',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              CupertinoButton(
                onPressed: () => selectDomainDataViewNotifier.changeSort(),
                child: Text(
                  ConvertSortString.convert(context, sort),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DomainDataListView extends StatelessWidget {
  const _DomainDataListView({
    required this.domainDataList,
    required this.selectedDomainDataList,
    required this.rootContext,
    required this.selectDomainDataFunc,
    required this.enableVisibility,
    required this.tagCount,
    required this.returnSelecting,
    this.deselectionFunc,
    this.afterFunc,
    key,
  }) : super(key: key);

  final List<DomainData> domainDataList;
  final List<DomainData> selectedDomainDataList;
  final BuildContext rootContext;
  final Function(DomainData, int) selectDomainDataFunc;
  final Function(DomainData)? deselectionFunc;
  final Function? afterFunc;
  final int tagCount;

  final bool enableVisibility;
  final bool returnSelecting;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemBuilder: ((context, index) {
        if (enableVisibility && !domainDataList[index].isVisibleToPicker) return Container();
        final isSelected = selectedDomainDataList.contains(domainDataList[index]);
        return GestureDetector(
          onTap: () {
            if (isSelected) {
              if (deselectionFunc != null) deselectionFunc!(domainDataList[index]);
            } else {
              selectDomainDataFunc(domainDataList[index], tagCount);
              if (returnSelecting) Navigator.pop(rootContext);
              if (afterFunc != null) afterFunc!();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            color: isSelected ? Theme.of(context).hoverColor : Theme.of(context).colorScheme.surface,
            child: Text(
              domainDataList[index].name,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        );
      }),
      separatorBuilder: ((context, index) {
        if (enableVisibility && !domainDataList[index].isVisibleToPicker) return Container();
        return const Divider(
          indent: 16,
          thickness: 1,
          height: 0,
        );
      }),
      itemCount: domainDataList.length,
    );
  }
}

class _ReorderableDomainDataListView extends HookConsumerWidget {
  const _ReorderableDomainDataListView({
    required this.domainDataList,
    required this.enableVisibility,
    required this.dataType,
    key,
  }) : super(key: key);

  final List<DomainData> domainDataList;
  final bool enableVisibility;
  final DomainDataType dataType;

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
            key: Key(domainDataList[index].id.toString()),
            tileColor: Theme.of(context).colorScheme.surface,
            title: Text(
              domainDataList[index].name,
              style: domainDataList[index].isVisibleToPicker
                  ? Theme.of(context).textTheme.bodyMedium
                  : Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).disabledColor,
                      ),
            ),
            trailing: ReorderableDragStartListener(
              index: index,
              child: const Icon(Icons.drag_handle),
            ),
            onTap: () async {
              await ref.read(selectDomainDataViewNotifierProvider(dataType).notifier).toggleIsVisibleToPicker(domainDataList[index]);
            },
          );
        }),
        onReorder: (oldIndex, newIndex) async {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final moveDomainData = domainDataList.removeAt(oldIndex);
          domainDataList.insert(newIndex, moveDomainData);
          List<DomainData> newDomainDataList = [];
          domainDataList.asMap().forEach((index, domainData) {
            if (dataType == DomainDataType.game) {
              domainData as Game;
              domainData = domainData.copyWith(sortIndex: index);
              newDomainDataList.add(domainData);
            } else if (dataType == DomainDataType.deck) {
              domainData as Deck;
              domainData = domainData.copyWith(sortIndex: index);
              newDomainDataList.add(domainData);
            } else if (dataType == DomainDataType.tag) {
              domainData as Tag;
              domainData = domainData.copyWith(sortIndex: index);
              newDomainDataList.add(domainData);
            }
          });
          if (dataType == DomainDataType.game) {
            await ref.read(gameRepository).updateGameList(newDomainDataList.map((e) => e as Game).toList());
            ref.refresh(allGameListProvider);
          } else if (dataType == DomainDataType.deck) {
            await ref.read(deckRepository).updateDeckList(newDomainDataList.map((e) => e as Deck).toList());
            ref.refresh(allDeckListProvider);
          } else if (dataType == DomainDataType.tag) {
            await ref.read(tagRepository).updateTagList(newDomainDataList.map((e) => e as Tag).toList());
            ref.refresh(allTagListProvider);
          }
        },
        itemCount: domainDataList.length,
      ),
    );
  }
}

class ReordableDomainDataView extends HookConsumerWidget {
  const ReordableDomainDataView({
    required this.enableVisiblity,
    required this.datatype,
    key,
  }) : super(key: key);
  final bool enableVisiblity;
  final DomainDataType datatype;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final domainDataList = ref.watch(sortedDomainDataListProvider(datatype));

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
      body: domainDataList.when(
        data: (domainDataList) {
          return Column(
            children: [
              Expanded(
                child: _ReorderableDomainDataListView(
                  domainDataList: domainDataList,
                  enableVisibility: enableVisiblity,
                  dataType: datatype,
                ),
              ),
              Container(
                color: Theme.of(context).canvasColor,
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Text(
                  '項目をタップで表示/非表示を切り替えられます',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
        error: (error, stack) => Text('$error'),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
