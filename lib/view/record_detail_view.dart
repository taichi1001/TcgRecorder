import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/record_detail_provider.dart';
import 'package:tcg_manager/view/component/custom_modal_date_picker.dart';
import 'package:tcg_manager/view/component/custom_textfield.dart';

class RecordDetailView extends HookConsumerWidget {
  const RecordDetailView({
    Key? key,
    required this.margedRecord,
  }) : super(key: key);

  final MargedRecord margedRecord;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEdit = ref.watch(recordDetailNotifierProvider(margedRecord).select((value) => value.isEdit));
    final recordDetailNotifier = ref.watch(recordDetailNotifierProvider(margedRecord).notifier);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0.0,
        title: Text(
          isEdit ? '編集' : '詳細',
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
      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
        child: isEdit ? _EditView(margedRecord: margedRecord) : _DetailView(margedRecord: margedRecord),
      ),
    );
  }
}

class _DetailView extends HookConsumerWidget {
  const _DetailView({
    Key? key,
    required this.margedRecord,
  }) : super(key: key);

  final MargedRecord margedRecord;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marged = ref.watch(recordDetailNotifierProvider(margedRecord).select((value) => value.margedRecord));
    final outputFormat = DateFormat('yyyy年 MM月 dd日');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.watch_later_outlined),
            const SizedBox(width: 8),
            Hero(
              tag: 'date' + marged.recordId.toString(),
              child: Material(
                color: Colors.transparent,
                child: Text(
                  outputFormat.format(marged.date),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              color: Colors.black12,
              child: Column(
                children: [
                  Text(
                    S.of(context).useDeck,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      leadingDistribution: TextLeadingDistribution.even,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Opacity(
                        opacity: 0.1,
                        child: Text(
                          'Win',
                          style: GoogleFonts.bangers(
                            fontSize: 100,
                            color: const Color(0xFFA21F16),
                          ),
                        ),
                      ),
                      Hero(
                        tag: 'useDeck' + marged.recordId.toString(),
                        child: Material(
                          color: Colors.transparent,
                          child: Text(marged.useDeck),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black12,
              child: Column(
                children: [
                  Text(
                    S.of(context).opponentDeck,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      leadingDistribution: TextLeadingDistribution.even,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Opacity(
                        opacity: 0,
                        child: Text(
                          'Win',
                          style: GoogleFonts.bangers(
                            fontSize: 100,
                            color: const Color(0xFFA21F16),
                          ),
                        ),
                      ),
                      Hero(
                        tag: 'opponentDeck' + marged.recordId.toString(),
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            marged.opponentDeck,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        // marged.memo == null ? const Text('メモ無し') : Text(marged.memo!),
      ],
    );
  }
}

class _EditView extends HookConsumerWidget {
  const _EditView({
    Key? key,
    required this.margedRecord,
  }) : super(key: key);

  final MargedRecord margedRecord;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editMargedRecord =
        ref.watch(recordDetailNotifierProvider(margedRecord).select((value) => value.editMargedRecord));
    final recordDetailNotifier = ref.watch(recordDetailNotifierProvider(margedRecord).notifier);

    final firstSecond =
        ref.watch(recordDetailNotifierProvider(margedRecord).select((value) => value.editMargedRecord.firstSecond));
    final winLoss =
        ref.watch(recordDetailNotifierProvider(margedRecord).select((value) => value.editMargedRecord.winLoss));

    final useDeckTextController = useTextEditingController(text: editMargedRecord.useDeck);
    final opponentDeckTextController = useTextEditingController(text: editMargedRecord.opponentDeck);
    final tagTextController = useTextEditingController(text: editMargedRecord.tag);
    final memoTextController = useTextEditingController(text: editMargedRecord.memo);
    final outputFormat = DateFormat('yyyy年 MM月 dd日');

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
            child: Text(
              S.of(context).date,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                leadingDistribution: TextLeadingDistribution.even,
                height: 1,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                outputFormat.format(editMargedRecord.date),
              ),
              _DatePickerButton(
                submited: recordDetailNotifier.editDate,
                onDateTimeChanged: recordDetailNotifier.scrollDate,
              ),
            ],
          ),
          const Text(
            'デッキ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              leadingDistribution: TextLeadingDistribution.even,
              height: 1,
            ),
          ),
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
          const SizedBox(height: 16),
          const Text(
            'タグ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              leadingDistribution: TextLeadingDistribution.even,
              height: 1,
            ),
          ),
          CustomTextField(
            labelText: 'タグ',
            onChanged: recordDetailNotifier.editTag,
            controller: tagTextController,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: Text(
              S.of(context).order,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                leadingDistribution: TextLeadingDistribution.even,
                height: 1,
              ),
            ),
          ),
          RadioListTile(
            title: Text(S.of(context).first),
            value: FirstSecond.first,
            groupValue: firstSecond,
            activeColor: const Color(0xFF18204E),
            onChanged: (FirstSecond? value) {
              if (value != null) {
                recordDetailNotifier.editFirstSecond(value);
              }
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
            dense: true,
          ),
          RadioListTile(
            title: Text(S.of(context).second),
            value: FirstSecond.second,
            groupValue: firstSecond,
            activeColor: const Color(0xFF18204E),
            onChanged: (FirstSecond? value) {
              if (value != null) {
                recordDetailNotifier.editFirstSecond(value);
              }
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
            dense: true,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: Text(
              S.of(context).winOrLoss,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                leadingDistribution: TextLeadingDistribution.even,
                height: 1,
              ),
            ),
          ),
          RadioListTile(
            title: Text(S.of(context).win),
            value: WinLoss.win,
            groupValue: winLoss,
            activeColor: const Color(0xFF18204E),
            onChanged: (WinLoss? value) {
              if (value != null) {
                recordDetailNotifier.editWinLoss(value);
              }
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
            dense: true,
          ),
          RadioListTile(
            title: Text(S.of(context).loss),
            value: WinLoss.loss,
            groupValue: winLoss,
            activeColor: const Color(0xFF18204E),
            onChanged: (WinLoss? value) {
              if (value != null) {
                recordDetailNotifier.editWinLoss(value);
              }
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
            dense: true,
          ),
          const Text(
            'メモ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              leadingDistribution: TextLeadingDistribution.even,
              height: 1,
            ),
          ),
          CustomTextField(
            controller: memoTextController,
            onChanged: recordDetailNotifier.editMemo,
            labelText: '改行もできます',
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

class _DatePickerButton extends HookConsumerWidget {
  const _DatePickerButton({
    required this.submited,
    required this.onDateTimeChanged,
    Key? key,
  }) : super(key: key);
  final void Function() submited;
  final Function(DateTime) onDateTimeChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(
        Icons.calendar_today_rounded,
        color: Color(0xFF18204E),
        size: 16,
      ),
      onPressed: () {
        showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) {
              return CustomModalDatePicker(
                submited: () {
                  submited();
                  Navigator.pop(context);
                },
                onDateTimeChanged: onDateTimeChanged,
              );
            });
      },
    );
  }
}
