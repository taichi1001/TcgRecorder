import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/record_detail_provider.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/selector/game_tag_list_selector.dart';
import 'package:tcg_manager/view/component/custom_modal_date_picker.dart';
import 'package:tcg_manager/view/component/custom_modal_list_picker.dart';
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
        centerTitle: false,
        elevation: 0.0,
        title: Text(
          isEdit ? S.of(context).editButton : '',
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          CupertinoButton(
            child: Text(
              isEdit ? S.of(context).submit : S.of(context).editButton,
              style: Theme.of(context).primaryTextTheme.bodyText1,
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
            Text(
              outputFormat.format(marged.date),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 140.w,
              child: Center(
                child: Text(
                  S.of(context).useDeck,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    leadingDistribution: TextLeadingDistribution.even,
                    height: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24),
            SizedBox(
              width: 140.w,
              child: Center(
                child: Text(
                  S.of(context).opponentDeck,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    leadingDistribution: TextLeadingDistribution.even,
                    height: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 140.w,
              height: 150.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Opacity(
                        opacity: 0.1,
                        child: Text(
                          margedRecord.winLoss == WinLoss.win ? 'Win' : 'Loss',
                          style: GoogleFonts.bangers(
                            fontSize: 80.sp,
                            color: margedRecord.winLoss == WinLoss.win ? const Color(0xFFA21F16) : const Color(0xFF3547AC),
                          ),
                        ),
                      ),
                      Text(
                        marged.useDeck,
                        maxLines: 4,
                        style: const TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 24.w,
              child: const Text(
                'VS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  leadingDistribution: TextLeadingDistribution.even,
                  height: 1,
                ),
              ),
            ),
            SizedBox(
              width: 140.w,
              height: 150.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Opacity(
                        opacity: 0,
                        child: Text(
                          'Win',
                          style: GoogleFonts.bangers(
                            fontSize: 80.sp,
                            color: const Color(0xFFA21F16),
                          ),
                        ),
                      ),
                      Text(
                        marged.opponentDeck,
                        maxLines: 4,
                        style: const TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.tag),
            const SizedBox(width: 8),
            Text(marged.tag == null ? S.of(context).noTag : marged.tag!),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          S.of(context).tag,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            leadingDistribution: TextLeadingDistribution.even,
            height: 1,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 500.w,
          height: 300.h,
          decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: marged.memo == null ? Text(S.of(context).noMemo) : Text(marged.memo!),
            ),
          ),
        ),
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
    final gameDeck = ref.watch(gameDeckListProvider);
    final gameTag = ref.watch(gameTagListProvider);
    final editMargedRecord = ref.watch(recordDetailNotifierProvider(margedRecord).select((value) => value.editMargedRecord));
    final recordDetailNotifier = ref.watch(recordDetailNotifierProvider(margedRecord).notifier);

    final firstSecond = ref.watch(recordDetailNotifierProvider(margedRecord).select((value) => value.editMargedRecord.firstSecond));
    final winLoss = ref.watch(recordDetailNotifierProvider(margedRecord).select((value) => value.editMargedRecord.winLoss));
    final useDeckTextController = useTextEditingController(text: editMargedRecord.useDeck);
    final opponentDeckTextController = useTextEditingController(text: editMargedRecord.opponentDeck);
    final tagTextController = useTextEditingController(text: editMargedRecord.tag);
    final memoTextController = useTextEditingController(text: editMargedRecord.memo);
    final outputFormat = DateFormat('yyyy年 MM月 dd日');

    useEffect(() {
      useDeckTextController.text = editMargedRecord.useDeck;
      return;
    }, [editMargedRecord.useDeck]);

    useEffect(() {
      opponentDeckTextController.text = editMargedRecord.opponentDeck;
      return;
    }, [editMargedRecord.opponentDeck]);

    useEffect(() {
      if (editMargedRecord.tag != null) {
        tagTextController.text = editMargedRecord.tag!;
      }
      return;
    }, [editMargedRecord.tag]);

    useEffect(() {
      if (editMargedRecord.memo != null) {
        memoTextController.text = editMargedRecord.memo!;
      }
      return;
    }, [editMargedRecord.memo]);

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
                submited: recordDetailNotifier.setDate,
                onDateTimeChanged: recordDetailNotifier.scrollDate,
              ),
            ],
          ),
          Text(
            S.of(context).deck,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              leadingDistribution: TextLeadingDistribution.even,
              height: 1,
            ),
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              CustomTextField(
                labelText: S.of(context).useDeck,
                onChanged: recordDetailNotifier.editUseDeck,
                controller: useDeckTextController,
              ),
              _ListPickerButton(
                submited: recordDetailNotifier.setUseDeck,
                onSelectedItemChanged: recordDetailNotifier.scrollUseDeck,
                children: gameDeck
                    .map((deck) => Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Text(
                            deck.deck,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              CustomTextField(
                labelText: S.of(context).opponentDeck,
                onChanged: recordDetailNotifier.editOpponentDeck,
                controller: opponentDeckTextController,
              ),
              _ListPickerButton(
                submited: recordDetailNotifier.setOpponentDeck,
                onSelectedItemChanged: recordDetailNotifier.scrollOpponentDeck,
                children: gameDeck
                    .map((deck) => Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Text(
                            deck.deck,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            S.of(context).tag,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              leadingDistribution: TextLeadingDistribution.even,
              height: 1,
            ),
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              CustomTextField(
                labelText: S.of(context).tag,
                onChanged: recordDetailNotifier.editTag,
                controller: tagTextController,
              ),
              _ListPickerButton(
                submited: recordDetailNotifier.setTag,
                onSelectedItemChanged: recordDetailNotifier.scrollTag,
                children: gameTag
                    .map((tag) => Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Text(
                            tag.tag,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
              ),
            ],
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
            onChanged: (WinLoss? value) {
              if (value != null) {
                recordDetailNotifier.editWinLoss(value);
              }
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
            dense: true,
          ),
          Text(
            S.of(context).memo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              leadingDistribution: TextLeadingDistribution.even,
              height: 1,
            ),
          ),
          CustomTextField(
            controller: memoTextController,
            onChanged: recordDetailNotifier.editMemo,
            labelText: S.of(context).memoTag,
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

class _ListPickerButton extends StatelessWidget {
  const _ListPickerButton({
    required this.submited,
    required this.onSelectedItemChanged,
    required this.children,
    key,
  }) : super(key: key);
  final void Function() submited;
  final Function(int) onSelectedItemChanged;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_drop_down),
      onPressed: children.isEmpty
          ? null
          : () {
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return CustomModalListPicker(
                    submited: () {
                      submited();
                      Navigator.pop(context);
                      FocusScope.of(context).unfocus();
                    },
                    onSelectedItemChanged: onSelectedItemChanged,
                    children: children,
                  );
                },
              );
            },
    );
  }
}
