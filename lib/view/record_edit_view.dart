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
import 'package:tcg_manager/helper/premium_plan_dialog.dart';
import 'package:tcg_manager/provider/record_detail_provider.dart';
import 'package:tcg_manager/provider/record_edit_view_settings_provider.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';
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
    final isBO3 = ref.watch(recordEditViewSettingsNotifierProvider(margedRecord).select((value) => value.bo3));
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
          title: Text(S.of(context).editButton),
          actions: [
            IconButton(
              icon: const Icon(Icons.tune),
              onPressed: () async {
                showCupertinoModalBottomSheet(
                  expand: false,
                  context: context,
                  builder: (context) => _SettingModalBottomSheet(record: margedRecord),
                );
              },
            ),
            CupertinoButton(
              child: Text(
                S.of(context).save,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              onPressed: () {
                if (isBO3) {
                  recordDetailNotifier.saveEditBO3();
                } else {
                  recordDetailNotifier.saveEdit();
                }
                recordDetailNotifier.changeIsEdit();
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
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
    final recordDetailState = ref.watch(recordDetailNotifierProvider(margedRecord));
    final firstSecond = recordDetailState.editMargedRecord.firstSecond;
    final firstMatchFirstSecond = recordDetailState.editMargedRecord.firstMatchFirstSecond;
    final secondMatchFirstSecond = recordDetailState.editMargedRecord.secondMatchFirstSecond;
    final thirdMatchFirstSecond = recordDetailState.editMargedRecord.thirdMatchFirstSecond;
    final winLoss = recordDetailState.editMargedRecord.winLoss;
    final firstMatchWinLoss = recordDetailState.editMargedRecord.firstMatchWinLoss;
    final secondMatchWinLoss = recordDetailState.editMargedRecord.secondMatchWinLoss;
    final thirdMatchWinLoss = recordDetailState.editMargedRecord.thirdMatchWinLoss;

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

    final isDraw = ref.watch(recordEditViewSettingsNotifierProvider(margedRecord).select((value) => value.draw));
    final isBO3 = ref.watch(recordEditViewSettingsNotifierProvider(margedRecord).select((value) => value.bo3));

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 204.w,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              RadioListTile(
                                title: Text(S.of(context).first),
                                toggleable: true,
                                value: FirstSecond.first,
                                groupValue: isBO3 ? firstMatchFirstSecond : firstSecond,
                                onChanged: (FirstSecond? value) {
                                  if (isBO3) {
                                    recordDetailNotifier.editFirstMatchFirstSecond(value);
                                  } else {
                                    recordDetailNotifier.editFirstSecond(value);
                                  }
                                },
                                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                dense: true,
                              ),
                              RadioListTile(
                                title: Text(S.of(context).second),
                                toggleable: true,
                                value: FirstSecond.second,
                                groupValue: isBO3 ? firstMatchFirstSecond : firstSecond,
                                onChanged: (FirstSecond? value) {
                                  if (isBO3) {
                                    recordDetailNotifier.editFirstMatchFirstSecond(value);
                                  } else {
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
                      width: 204.w,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              RadioListTile(
                                title: Text(S.of(context).win),
                                toggleable: true,
                                value: WinLoss.win,
                                groupValue: isBO3 ? firstMatchWinLoss : winLoss,
                                onChanged: (WinLoss? value) {
                                  if (isBO3) {
                                    recordDetailNotifier.editFirstMatchWinLoss(value);
                                  } else {
                                    recordDetailNotifier.editWinLoss(value);
                                  }
                                },
                                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                dense: true,
                              ),
                              RadioListTile(
                                title: Text(S.of(context).loss),
                                toggleable: true,
                                value: WinLoss.loss,
                                groupValue: isBO3 ? firstMatchWinLoss : winLoss,
                                onChanged: (WinLoss? value) {
                                  if (isBO3) {
                                    recordDetailNotifier.editFirstMatchWinLoss(value);
                                  } else {
                                    recordDetailNotifier.editWinLoss(value);
                                  }
                                },
                                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                dense: true,
                              ),
                              if (isDraw)
                                RadioListTile(
                                  title: Text(S.of(context).draw),
                                  value: WinLoss.draw,
                                  toggleable: true,
                                  groupValue: isBO3 ? firstMatchWinLoss : winLoss,
                                  onChanged: (WinLoss? value) {
                                    if (isBO3) {
                                      recordDetailNotifier.editFirstMatchWinLoss(value);
                                    } else {
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
                if (isBO3)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 204.w,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                RadioListTile(
                                  title: Text(S.of(context).first),
                                  value: FirstSecond.first,
                                  toggleable: true,
                                  groupValue: secondMatchFirstSecond,
                                  onChanged: (FirstSecond? value) {
                                    recordDetailNotifier.editSecondMatchFirstSecond(value);
                                  },
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                  dense: true,
                                ),
                                RadioListTile(
                                  title: Text(S.of(context).second),
                                  value: FirstSecond.second,
                                  toggleable: true,
                                  groupValue: secondMatchFirstSecond,
                                  onChanged: (FirstSecond? value) {
                                    recordDetailNotifier.editSecondMatchFirstSecond(value);
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
                        width: 204.w,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                RadioListTile(
                                  title: Text(S.of(context).win),
                                  value: WinLoss.win,
                                  toggleable: true,
                                  groupValue: secondMatchWinLoss,
                                  onChanged: (WinLoss? value) {
                                    recordDetailNotifier.editSecondMatchWinLoss(value);
                                  },
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                  dense: true,
                                ),
                                RadioListTile(
                                  title: Text(S.of(context).loss),
                                  value: WinLoss.loss,
                                  toggleable: true,
                                  groupValue: secondMatchWinLoss,
                                  onChanged: (WinLoss? value) {
                                    recordDetailNotifier.editSecondMatchWinLoss(value);
                                  },
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                  dense: true,
                                ),
                                if (isDraw)
                                  RadioListTile(
                                    title: Text(S.of(context).draw),
                                    value: WinLoss.draw,
                                    toggleable: true,
                                    groupValue: secondMatchWinLoss,
                                    onChanged: (WinLoss? value) {
                                      recordDetailNotifier.editSecondMatchWinLoss(value);
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
                if (isBO3)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 204.w,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                RadioListTile(
                                  title: Text(S.of(context).first),
                                  toggleable: true,
                                  value: FirstSecond.first,
                                  groupValue: thirdMatchFirstSecond,
                                  onChanged: (FirstSecond? value) {
                                    recordDetailNotifier.editThirdMatchFirstSecond(value);
                                  },
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                  dense: true,
                                ),
                                RadioListTile(
                                  title: Text(S.of(context).second),
                                  value: FirstSecond.second,
                                  toggleable: true,
                                  groupValue: thirdMatchFirstSecond,
                                  onChanged: (FirstSecond? value) {
                                    recordDetailNotifier.editThirdMatchFirstSecond(value);
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
                        width: 204.w,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                RadioListTile(
                                  title: Text(S.of(context).win),
                                  value: WinLoss.win,
                                  toggleable: true,
                                  groupValue: thirdMatchWinLoss,
                                  onChanged: (WinLoss? value) {
                                    recordDetailNotifier.editThirdMatchWinLoss(value);
                                  },
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                  dense: true,
                                ),
                                RadioListTile(
                                  title: Text(S.of(context).loss),
                                  value: WinLoss.loss,
                                  toggleable: true,
                                  groupValue: thirdMatchWinLoss,
                                  onChanged: (WinLoss? value) {
                                    recordDetailNotifier.editThirdMatchWinLoss(value);
                                  },
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                  dense: true,
                                ),
                                if (isDraw)
                                  RadioListTile(
                                    title: Text(S.of(context).draw),
                                    value: WinLoss.draw,
                                    toggleable: true,
                                    groupValue: thirdMatchWinLoss,
                                    onChanged: (WinLoss? value) {
                                      recordDetailNotifier.editThirdMatchWinLoss(value);
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

class _SettingModalBottomSheet extends HookConsumerWidget {
  const _SettingModalBottomSheet({
    required this.record,
    key,
  }) : super(key: key);
  final MargedRecord record;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draw = ref.watch(recordEditViewSettingsNotifierProvider(record).select((value) => value.draw));
    final bo3 = ref.watch(recordEditViewSettingsNotifierProvider(record).select((value) => value.bo3));
    final inputiViewSettingsController = ref.watch(recordEditViewSettingsNotifierProvider(record).notifier);
    final isPremium = ref.watch(revenueCatNotifierProvider.select((value) => value.isPremium));

    return Material(
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                child: Text(
                  '入力項目オプション',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SwitchListTile.adaptive(
                contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                title: Text(
                  '引き分け',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: draw,
                onChanged: (value) async {
                  if (isPremium) {
                    inputiViewSettingsController.changeDraw(value);
                  } else {
                    await premiumPlanDialog(context);
                  }
                },
              ),
              SwitchListTile.adaptive(
                contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                title: Text(
                  'BO3',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: bo3,
                onChanged: (value) async {
                  if (isPremium) {
                    inputiViewSettingsController.changeBO3(value);
                  } else {
                    await premiumPlanDialog(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
