import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/entity/marged_record.dart';
import 'package:tcg_recorder2/selector/marged_record_list_selector.dart';
import 'package:tcg_recorder2/view/component/custom_scaffold.dart';

class RecordListView extends HookConsumerWidget {
  const RecordListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordList = ref.watch(margedRecordListProvider);

    return CustomScaffold(
      rightButton: IconButton(
        icon: const Icon(Icons.filter_list),
        color: Colors.black,
        onPressed: () {},
      ),
      body: ListView.builder(
        itemCount: recordList.length,
        itemBuilder: (context, index) => ProviderScope(
          overrides: [currentRecord.overrideWithValue(recordList[index])],
          child: const _BrandListTile(),
        ),
      ),
    );
  }
}

final currentRecord = Provider<MargedRecord>((ref) => MargedRecord(
      recordId: 0,
      game: '',
      useDeck: '',
      opponentDeck: '',
      tag: '',
      firstSecond: true,
      winLoss: true,
      date: DateTime.now(),
    ));

class _BrandListTile extends HookConsumerWidget {
  const _BrandListTile({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final record = ref.watch(currentRecord);

    return ListTile(
      title: Text(record.game.toString()),
      subtitle: Text(record.useDeck.toString()),
    );
  }
}
