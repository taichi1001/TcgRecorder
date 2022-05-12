import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

class RecordEditView extends HookConsumerWidget {
  const RecordEditView({
    Key? key,
    required this.margedRecord,
  }) : super(key: key);

  final MargedRecord margedRecord;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordDetailNotifier = ref.watch(recordDetailNotifierProvider(margedRecord).notifier);
    return WillPopScope(
      onWillPop: (() async {
        final okCancelResult = await showOkCancelAlertDialog(
          context: context,
          message: S.of(context).recordEditDialogMessage,
          isDestructiveAction: true,
        );
        if (okCancelResult == OkCancelResult.ok) return true;
        return false;
      }),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            S.of(context).editButton,
            style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          actions: [
            CupertinoButton(
              child: Text(
                S.of(context).save,
                style: Theme.of(context).primaryTextTheme.bodyText1,
              ),
              onPressed: () {
                recordDetailNotifier.saveEdit();
                recordDetailNotifier.changeIsEdit();
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
          child: _EditView(margedRecord: margedRecord),
        ),
      ),
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
    final outputFormat = DateFormat(S.of(context).dateFormat);
    final isSelectPicker = useState(false);

    final useDeckFocusnode = useFocusNode();
    final opponentDeckFocusnode = useFocusNode();
    final tagFocusnode = useFocusNode();
    final memoFocusnode = useFocusNode();

    if (isSelectPicker.value) {
      useDeckTextController.text = editMargedRecord.useDeck;
      opponentDeckTextController.text = editMargedRecord.opponentDeck;
      tagTextController.text = editMargedRecord.tag ?? '';
      memoTextController.text = editMargedRecord.memo ?? '';
      isSelectPicker.value = false;
    }

    return KeyboardActions(
      config: KeyboardActionsConfig(
        keyboardBarColor: Theme.of(context).canvasColor,
        keyboardSeparatorColor: Theme.of(context).dividerColor,
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        nextFocus: true,
        actions: [
          KeyboardActionsItem(focusNode: useDeckFocusnode),
          KeyboardActionsItem(focusNode: opponentDeckFocusnode),
          KeyboardActionsItem(focusNode: tagFocusnode),
          KeyboardActionsItem(focusNode: memoFocusnode),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomModalDatePicker(
                      submited: () {
                        recordDetailNotifier.setDate();
                        Navigator.pop(context);
                      },
                      onDateTimeChanged: recordDetailNotifier.scrollDate,
                    );
                  },
                );
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        outputFormat.format(editMargedRecord.date),
                      ),
                      const Icon(
                        Icons.calendar_today_rounded,
                        size: 16,
                      ),
                    ],
                  ),
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
                          focusNode: useDeckFocusnode,
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
                          focusNode: opponentDeckFocusnode,
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
                          focusNode: tagFocusnode,
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
                      focusNode: memoFocusnode,
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
