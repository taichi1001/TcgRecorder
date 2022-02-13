import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/record_detail_provider.dart';
import 'package:tcg_manager/view/component/custom_textfield.dart';

class RecordDetailView extends HookConsumerWidget {
  const RecordDetailView({
    Key? key,
    required this.margedRecord,
  }) : super(key: key);

  final MargedRecord margedRecord;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final record = ref.watch(recordDetailNotifierProvider(margedRecord).select((value) => value.record));
    final marged = ref.watch(recordDetailNotifierProvider(margedRecord).select((value) => value.margedRecord));
    final isEdit = ref.watch(recordDetailNotifierProvider(margedRecord).select((value) => value.isEdit));
    final recordDetailNotifier = ref.watch(recordDetailNotifierProvider(margedRecord).notifier);

    final useDeckTextController = useTextEditingController(text: marged.useDeck);
    final opponentDeckTextController = useTextEditingController(text: marged.opponentDeck);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0.0,
        title: Text(
          marged.useDeck,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          CupertinoButton(
            child: Text(
              isEdit ? '完了' : '編集',
              style: const TextStyle(color: Colors.black),
            ),
            onPressed: isEdit
                ? () {
                    recordDetailNotifier.saveEdit();
                    recordDetailNotifier.changeIsEdit();
                  }
                : () {
                    recordDetailNotifier.changeIsEdit();
                  },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: isEdit
          ? Column(
              children: [
                CustomTextField(
                  labelText: S.of(context).useDeck,
                  onChanged: recordDetailNotifier.editUseDeck,
                  controller: useDeckTextController,
                ),
                CustomTextField(
                  labelText: S.of(context).opponentDeck,
                  onChanged: recordDetailNotifier.editOpponentDeck,
                  controller: opponentDeckTextController,
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(record.recordId.toString()),
                Text(marged.useDeck),
                Text(record.useDeckId.toString()),
                Text(marged.opponentDeck),
                Text(record.opponentDeckId.toString()),
              ],
            ),
    );
  }
}
