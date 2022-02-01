import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tcg_recorder2/entity/marged_record.dart';
import 'package:tcg_recorder2/provider/record_list_provider.dart';
import 'package:tcg_recorder2/selector/marged_record_list_selector.dart';
import 'package:tcg_recorder2/view/component/custom_scaffold.dart';

class RecordListView extends HookConsumerWidget {
  const RecordListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordList = ref.watch(margedRecordListProvider).margedRecordList;
    // レコードが古い順に表示されるため、リストを逆にして新しい順にしている
    final reverseRecordList = List.from(recordList!.reversed);
    final recordListNotifier = ref.read(allRecordListNotifierProvider.notifier);

    return CustomScaffold(
      // rightButton: IconButton(
      //   icon: const Icon(Icons.filter_list),
      //   color: Colors.black,
      //   onPressed: () {},
      // ),
      body: recordList.isEmpty
          ? const Center(child: Text('このゲームの記録はありません'))
          : ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 8, child: Divider(height: 1)),
              itemCount: reverseRecordList.length,
              itemBuilder: (context, index) {
                return ProviderScope(
                  overrides: [currentRecord.overrideWithValue(reverseRecordList[index])],
                  child: Dismissible(
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      final okCancelResult = await showOkCancelAlertDialog(
                        context: context,
                        message: '削除してもいいですか？',
                        isDestructiveAction: true,
                      );
                      if (okCancelResult == OkCancelResult.ok) {
                        return true;
                      }
                    },
                    onDismissed: (direction) async {
                      await recordListNotifier.delete(reverseRecordList[index].recordId);
                    },
                    key: UniqueKey(),
                    child: const _BrandListTile(),
                  ),
                );
              }),
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
    final outputFormat = DateFormat('yyyy年 MM月 dd日');

    return ListTile(
      trailing: Text(
        record.winLoss ? 'Win' : 'Loss',
        style: GoogleFonts.bangers(
          fontSize: 34,
          color: record.winLoss ? const Color(0xFFA21F16) : const Color(0xFF3547AC),
        ),
      ),
      subtitle: Text(
        outputFormat.format(record.date),
        style: const TextStyle(fontSize: 14, color: Colors.black54),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '使用デッキ: ',
                style: TextStyle(fontSize: 12, color: Colors.black45),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  record.useDeck,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Text(
                '対戦デッキ: ',
                style: TextStyle(fontSize: 12, color: Colors.black45),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  record.opponentDeck,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
