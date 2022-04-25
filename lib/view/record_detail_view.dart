import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
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
    return WillPopScope(
      onWillPop: (() async {
        if (isEdit) {
          final okCancelResult = await showOkCancelAlertDialog(
            context: context,
            message: '編集中の内容が保存されませんが戻ってもよろしいですか？',
            isDestructiveAction: true,
          );
          if (okCancelResult == OkCancelResult.ok) return true;
          return false;
        } else {
          return true;
        }
      }),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            isEdit ? S.of(context).editButton : '',
            style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
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
        Card(
          child: SizedBox(
            width: 500.w,
            height: 300.h,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: marged.memo == '' || marged.memo == null ? Text(S.of(context).noMemo) : Text(marged.memo!),
              ),
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
    final isSelectPicker = useState(false);

    final _useDeckFocusnode = useFocusNode();
    final _opponentDeckFocusnode = useFocusNode();
    final _tagFocusnode = useFocusNode();
    final _memoFocusnode = useFocusNode();

    if (isSelectPicker.value) {
      useDeckTextController.text = editMargedRecord.useDeck;
      opponentDeckTextController.text = editMargedRecord.opponentDeck;
      tagTextController.text = editMargedRecord.tag ?? '';
      memoTextController.text = editMargedRecord.memo ?? '';
      isSelectPicker.value = false;
    }

    return KeyboardActions(
      tapOutsideBehavior: TapOutsideBehavior.opaqueDismiss,
      config: KeyboardActionsConfig(
        keyboardBarColor: Theme.of(context).canvasColor,
        keyboardSeparatorColor: Theme.of(context).dividerColor,
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        nextFocus: true,
        actions: [
          KeyboardActionsItem(focusNode: _useDeckFocusnode),
          KeyboardActionsItem(focusNode: _opponentDeckFocusnode),
          KeyboardActionsItem(focusNode: _tagFocusnode),
          KeyboardActionsItem(focusNode: _memoFocusnode),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
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
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 195.w,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
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
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 195.w,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        CustomTextField(
                          labelText: S.of(context).useDeck,
                          onChanged: recordDetailNotifier.editUseDeck,
                          controller: useDeckTextController,
                          focusNode: _useDeckFocusnode,
                        ),
                        _ListPickerButton(
                          submited: () {
                            recordDetailNotifier.setUseDeck();
                            isSelectPicker.value = true;
                          },
                          onSelectedItemChanged: recordDetailNotifier.scrollUseDeck,
                          children: gameDeck
                              .map((deck) => Padding(
                                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                    child: Text(
                                      deck.deck,
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.headline6?.copyWith(height: 1),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        CustomTextField(
                          labelText: S.of(context).opponentDeck,
                          onChanged: recordDetailNotifier.editOpponentDeck,
                          controller: opponentDeckTextController,
                          focusNode: _opponentDeckFocusnode,
                        ),
                        _ListPickerButton(
                          submited: () {
                            recordDetailNotifier.setOpponentDeck();
                            isSelectPicker.value = true;
                          },
                          onSelectedItemChanged: recordDetailNotifier.scrollOpponentDeck,
                          children: gameDeck
                              .map((deck) => Padding(
                                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                    child: Text(
                                      deck.deck,
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.headline6?.copyWith(height: 1),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        CustomTextField(
                          labelText: S.of(context).tag,
                          onChanged: recordDetailNotifier.editTag,
                          controller: tagTextController,
                          focusNode: _tagFocusnode,
                        ),
                        _ListPickerButton(
                          submited: () {
                            recordDetailNotifier.setTag();
                            isSelectPicker.value = true;
                          },
                          onSelectedItemChanged: recordDetailNotifier.scrollTag,
                          children: gameTag
                              .map((tag) => Padding(
                                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                    child: Text(
                                      tag.tag,
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.headline6?.copyWith(height: 1),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: memoTextController,
                      onChanged: recordDetailNotifier.editMemo,
                      labelText: S.of(context).memoTag,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      focusNode: _memoFocusnode,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
      padding: const EdgeInsets.all(0),
      constraints: const BoxConstraints(),
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
