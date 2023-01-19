import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/record_detail_provider.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/selector/game_tag_list_selector.dart';
import 'package:tcg_manager/view/component/custom_textfield.dart';
import 'package:tcg_manager/view/component/cutom_date_time_picker.dart';
import 'package:tcg_manager/view/input_view.dart';
import 'package:tcg_manager/view/select_deck_view.dart';

class RecordEditViewInfo {
  const RecordEditViewInfo({
    required this.gameTagList,
    required this.gameDeckList,
  });

  final List<Deck> gameDeckList;
  final List<Tag> gameTagList;
}

final recordEditViewInfoProvider = FutureProvider.autoDispose<RecordEditViewInfo>((ref) async {
  final gameDeckList = await ref.watch(gameDeckListProvider.future);
  final gameTagList = await ref.watch(gameTagListProvider.future);
  return RecordEditViewInfo(
    gameDeckList: gameDeckList,
    gameTagList: gameTagList,
  );
});

final _tagFocusNodesProvider = Provider.family.autoDispose<List<FocusNode>, MargedRecord>((ref, margedRecord) {
  final tagTextController = ref.watch(_tagTextController(margedRecord));
  final List<FocusNode> tagFocusNodes = [];
  for (var i = 0; i < tagTextController.length; i++) {
    tagFocusNodes.add(FocusNode());
  }
  return tagFocusNodes;
});

final _tagTextController = StateProvider.family.autoDispose<List<TextEditingController>, MargedRecord>((ref, margedRecord) {
  final List<TextEditingController> tagTextControllers = [];
  if (margedRecord.tag.isEmpty) {
    tagTextControllers.add(TextEditingController());
  } else {
    for (final tag in margedRecord.tag) {
      tagTextControllers.add(TextEditingController(text: tag));
    }
  }
  return tagTextControllers;
});

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
    final recordEditViewInfo = ref.watch(recordEditViewInfoProvider);

    final editMargedRecord = ref.watch(recordDetailNotifierProvider(margedRecord).select((value) => value.editMargedRecord));
    final recordDetailNotifier = ref.watch(recordDetailNotifierProvider(margedRecord).notifier);

    final firstSecond = ref.watch(recordDetailNotifierProvider(margedRecord).select((value) => value.editMargedRecord.firstSecond));
    final winLoss = ref.watch(recordDetailNotifierProvider(margedRecord).select((value) => value.editMargedRecord.winLoss));
    final useDeckTextController = useTextEditingController(text: editMargedRecord.useDeck);
    final opponentDeckTextController = useTextEditingController(text: editMargedRecord.opponentDeck);

    final tagTextControllers = ref.watch(_tagTextController(editMargedRecord));
    final tagFocusNodes = ref.watch(_tagFocusNodesProvider(editMargedRecord));

    final memoTextController = useTextEditingController(text: editMargedRecord.memo);
    final dateTimeController = useState(CustomModalDateTimePickerController(initialDateTime: DateTime.now()));

    final isSelectPicker = useState(false);

    final useDeckFocusnode = useFocusNode();
    final opponentDeckFocusnode = useFocusNode();
    final memoFocusnode = useFocusNode();

    if (isSelectPicker.value) {
      useDeckTextController.text = editMargedRecord.useDeck;
      opponentDeckTextController.text = editMargedRecord.opponentDeck;
      editMargedRecord.tag.asMap().forEach((index, value) {
        tagTextControllers[index].text = value;
      });
      memoTextController.text = editMargedRecord.memo ?? '';
      isSelectPicker.value = false;
    }

    return recordEditViewInfo.when(
      data: (recordEditViewInfo) {
        return KeyboardActions(
          config: KeyboardActionsConfig(
            keyboardBarColor: Theme.of(context).canvasColor,
            keyboardSeparatorColor: Theme.of(context).dividerColor,
            keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
            nextFocus: true,
            actions: [
              KeyboardActionsItem(focusNode: useDeckFocusnode),
              KeyboardActionsItem(focusNode: opponentDeckFocusnode),
              for (final tagFocusNode in tagFocusNodes) KeyboardActionsItem(focusNode: tagFocusNode),
              KeyboardActionsItem(focusNode: memoFocusnode),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                SelectableDateTime(
                  controller: dateTimeController.value,
                  submiteAction: () {
                    recordDetailNotifier.selectDateTime(dateTimeController.value.selectedDateTime);
                  },
                  nowAction: () async {
                    dateTimeController.value.setDateTimeNow();
                    recordDetailNotifier.selectDateTime(dateTimeController.value.selectedDateTime);
                  },
                  datetime: editMargedRecord.date,
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
                            IconButton(
                              icon: const Icon(Icons.arrow_drop_down),
                              onPressed: () async {
                                await showCupertinoModalBottomSheet(
                                  expand: true,
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (BuildContext context) {
                                    return SelectDeckView(
                                      selectDeckFunc: recordDetailNotifier.selectUseDeck,
                                    );
                                  },
                                );
                                isSelectPicker.value = true;
                              },
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
                            IconButton(
                              icon: const Icon(Icons.arrow_drop_down),
                              onPressed: () async {
                                await showCupertinoModalBottomSheet(
                                  expand: true,
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (BuildContext context) {
                                    return SelectDeckView(
                                      selectDeckFunc: recordDetailNotifier.selectOpponentDeck,
                                    );
                                  },
                                );
                                isSelectPicker.value = true;
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        InputTagList(
                          controllers: tagTextControllers,
                          focusNodes: tagFocusNodes,
                          inputTag: recordDetailNotifier.editTag,
                          isDropDown: false,
                          selectTagFunc: recordDetailNotifier.selectTag,
                          addFunc: () {
                            ref.read(_tagTextController(editMargedRecord).notifier).state = [
                              ...tagTextControllers,
                              TextEditingController()
                            ];
                          },
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
      },
      error: (error, stack) => Text('$error'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
