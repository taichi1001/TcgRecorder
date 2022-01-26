import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/entity/record.dart';
import 'package:tcg_recorder2/provider/select_game_provider.dart';
import 'package:tcg_recorder2/selector/game_record_list_selector.dart';

class RecordListView extends HookConsumerWidget {
  const RecordListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectGame = ref.watch(selectGameNotifierProvider);
    final recordList = ref.watch(gameRecordListProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          selectGame.selectGame != null ? selectGame.selectGame!.game : '',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_drop_down_outlined),
            color: Colors.black,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
        child: ListView.builder(
          itemCount: recordList.length,
          itemBuilder: (context, index) => ProviderScope(
            overrides: [currentRecord.overrideWithValue(recordList[index])],
            child: const _BrandListTile(),
          ),
        ),
      ),
    );
  }
}

final currentRecord = Provider<Record>((ref) => Record());

class _BrandListTile extends HookConsumerWidget {
  const _BrandListTile({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final record = ref.watch(currentRecord);

    return ListTile(
      title: Text(record.recordId.toString()),
      subtitle: Text(record.gameId.toString()),
    );
  }
}
