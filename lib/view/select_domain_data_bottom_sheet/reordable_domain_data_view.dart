import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/domain_data.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/select_domain_data_view_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/repository/deck_repository.dart';
import 'package:tcg_manager/repository/game_repository.dart';
import 'package:tcg_manager/repository/tag_repository.dart';
import 'package:tcg_manager/selector/sorted_domain_data_list_selector.dart';

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
            ref.invalidate(allGameListProvider);
          } else if (dataType == DomainDataType.deck) {
            await ref.read(deckRepository).updateDeckList(newDomainDataList.map((e) => e as Deck).toList());
            ref.invalidate(allDeckListProvider);
          } else if (dataType == DomainDataType.tag) {
            await ref.read(tagRepository).updateTagList(newDomainDataList.map((e) => e as Tag).toList());
            ref.invalidate(allTagListProvider);
          }
        },
        itemCount: domainDataList.length,
      ),
    );
  }
}
