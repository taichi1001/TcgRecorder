import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/helper/db_helper.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/input_view_provider.dart';
import 'package:tcg_manager/provider/input_view_settings_provider.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';
import 'package:tcg_manager/provider/text_editing_controller_provider.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/selector/game_tag_list_selector.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
import 'package:tcg_manager/view/component/custom_modal_picker.dart';
import 'package:tcg_manager/view/component/custom_scaffold.dart';
import 'package:tcg_manager/view/component/custom_textfield.dart';
import 'package:tcg_manager/view/select_deck_view.dart';
import 'package:tcg_manager/view/select_tag_view.dart';

class InputViewInfo {
  const InputViewInfo({
    required this.gameDeckList,
    required this.gameTagList,
  });

  final List<Deck> gameDeckList;
  final List<Tag> gameTagList;
}

final inputViewInfoProvider = FutureProvider.autoDispose<InputViewInfo>((ref) async {
  final gameDeckList = await ref.watch(gameDeckListProvider.future);
  final gameTagList = await ref.watch(gameTagListProvider.future);
  ref.keepAlive();
  return InputViewInfo(
    gameDeckList: gameDeckList,
    gameTagList: gameTagList,
  );
});

class InputView extends HookConsumerWidget {
  const InputView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(inputViewNotifierProvider.select((value) => value.date));
    final winLoss = ref.watch(inputViewNotifierProvider.select((value) => value.winLoss));
    final firstMatchWinLoss = ref.watch(inputViewNotifierProvider.select((value) => value.firstMatchWinLoss));
    final secondMatchWinLoss = ref.watch(inputViewNotifierProvider.select((value) => value.secondMatchWinLoss));
    final thirdMatchWinLoss = ref.watch(inputViewNotifierProvider.select((value) => value.thirdMatchWinLoss));
    final firstSecond = ref.watch(inputViewNotifierProvider.select((value) => value.firstSecond));
    final firstMatchFirstSecond = ref.watch(inputViewNotifierProvider.select((value) => value.firstMatchFirstSecond));
    final secondMatchFirstSecond = ref.watch(inputViewNotifierProvider.select((value) => value.secondMatchFirstSecond));
    final thirdMatchFirstSecond = ref.watch(inputViewNotifierProvider.select((value) => value.thirdMatchFirstSecond));
    final useDeck = ref.watch(inputViewNotifierProvider.select((value) => value.useDeck));
    final opponentDeck = ref.watch(inputViewNotifierProvider.select((value) => value.opponentDeck));
    final inputViewNotifier = ref.read(inputViewNotifierProvider.notifier);
    final useDeckTextController = ref.watch(textEditingControllerNotifierProvider.select((value) => value.useDeckController));
    final opponentDeckTextController = ref.watch(textEditingControllerNotifierProvider.select((value) => value.opponentDeckController));
    final tagTextController = ref.watch(textEditingControllerNotifierProvider.select((value) => value.tagController));
    final memoTextController = ref.watch(textEditingControllerNotifierProvider.select((value) => value.memoController));
    final isDraw = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.draw));
    final isBO3 = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.bo3));
    final outputFormat = DateFormat(S.of(context).dateFormat);

    final inputViewInfo = ref.watch(inputViewInfoProvider);

    final useDeckFocusnode = useFocusNode();
    final opponentDeckFocusnode = useFocusNode();
    final tagFocusnode = useFocusNode();
    final memoFocusnode = useFocusNode();

    return inputViewInfo.when(
      data: (inputViewInfo) {
        return Column(
          children: [
            Expanded(
              child: CustomScaffold(
                padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                leading: IconButton(
                  icon: const Icon(Icons.tune),
                  onPressed: () async {
                    showCupertinoModalBottomSheet(
                      expand: false,
                      context: context,
                      builder: (context) => const _SettingModalBottomSheet(),
                    );
                  },
                ),
                body: KeyboardActions(
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
                          onTap: () async {
                            try {
                              await ref.read(revenueCatNotifierProvider.notifier).purchasePremiumMonthly();
                            } catch (e) {
                              print(e);
                            }
                            showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 350,
                                  child: CustomModalPicker(
                                    shoModalButton: false,
                                    child: SfDateRangePicker(
                                      selectionMode: DateRangePickerSelectionMode.single,
                                      view: DateRangePickerView.month,
                                      showActionButtons: true,
                                      showNavigationArrow: true,
                                      minDate: DateTime(2000, 01, 01),
                                      maxDate: DateTime.now(),
                                      initialSelectedDate: date,
                                      toggleDaySelection: true,
                                      onSubmit: (value) {
                                        if (value is DateTime) {
                                          inputViewNotifier.selectDateTime(value);
                                          Navigator.pop(context);
                                        }
                                      },
                                      onCancel: () => Navigator.pop(context),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    outputFormat.format(date),
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
                                            inputViewNotifier.selectFirstMatchFirstSecond(value);
                                          } else {
                                            inputViewNotifier.selectFirstSecond(value);
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
                                            inputViewNotifier.selectFirstMatchFirstSecond(value);
                                          } else {
                                            inputViewNotifier.selectFirstSecond(value);
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
                                            inputViewNotifier.selectFirstMatchWinLoss(value);
                                          } else {
                                            inputViewNotifier.selectWinLoss(value);
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
                                            inputViewNotifier.selectFirstMatchWinLoss(value);
                                          } else {
                                            inputViewNotifier.selectWinLoss(value);
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
                                              inputViewNotifier.selectFirstMatchWinLoss(value);
                                            } else {
                                              inputViewNotifier.selectWinLoss(value);
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
                                            inputViewNotifier.selectSecondMatchFirstSecond(value);
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
                                            inputViewNotifier.selectSecondMatchFirstSecond(value);
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
                                            inputViewNotifier.selectSecondMatchWinLoss(value);
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
                                            inputViewNotifier.selectSecondMatchWinLoss(value);
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
                                              inputViewNotifier.selectSecondMatchWinLoss(value);
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
                                            inputViewNotifier.selectThirdMatchFirstSecond(value);
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
                                            inputViewNotifier.selectThirdMatchFirstSecond(value);
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
                                            inputViewNotifier.selectThirdMatchWinLoss(value);
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
                                            inputViewNotifier.selectThirdMatchWinLoss(value);
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
                                              inputViewNotifier.selectThirdMatchWinLoss(value);
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
                                      onChanged: inputViewNotifier.inputUseDeck,
                                      controller: useDeckTextController,
                                      focusNode: useDeckFocusnode,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.arrow_drop_down),
                                      onPressed: inputViewInfo.gameDeckList.isEmpty
                                          ? null
                                          : () {
                                              showCupertinoModalBottomSheet(
                                                expand: true,
                                                context: context,
                                                backgroundColor: Colors.transparent,
                                                builder: (BuildContext context) => SelectDeckView(
                                                  selectDeckFunc: inputViewNotifier.selectUseDeck,
                                                  afterFunc: FocusScope.of(context).unfocus,
                                                  enableVisiblity: true,
                                                ),
                                              );
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
                                      onChanged: inputViewNotifier.inputOpponentDeck,
                                      controller: opponentDeckTextController,
                                      focusNode: opponentDeckFocusnode,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.arrow_drop_down),
                                      onPressed: inputViewInfo.gameDeckList.isEmpty
                                          ? null
                                          : () {
                                              showCupertinoModalBottomSheet(
                                                expand: true,
                                                context: context,
                                                backgroundColor: Colors.transparent,
                                                builder: (BuildContext context) => SelectDeckView(
                                                  selectDeckFunc: inputViewNotifier.selectOpponentDeck,
                                                  afterFunc: FocusScope.of(context).unfocus,
                                                  enableVisiblity: true,
                                                ),
                                              );
                                            },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    CustomTextField(
                                      labelText: S.of(context).tag,
                                      onChanged: inputViewNotifier.inputTag,
                                      controller: tagTextController,
                                      focusNode: tagFocusnode,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.arrow_drop_down),
                                      onPressed: inputViewInfo.gameDeckList.isEmpty
                                          ? null
                                          : () {
                                              showCupertinoModalBottomSheet(
                                                expand: true,
                                                context: context,
                                                backgroundColor: Colors.transparent,
                                                builder: (BuildContext context) => SelectTagView(
                                                  selectTagFunc: inputViewNotifier.selectTag,
                                                  afterFunc: FocusScope.of(context).unfocus,
                                                  enableVisiblity: true,
                                                ),
                                              );
                                            },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                CustomTextField(
                                  controller: memoTextController,
                                  focusNode: memoFocusnode,
                                  onChanged: inputViewNotifier.inputMemo,
                                  labelText: S.of(context).memoTag,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 300,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: useDeck == null ||
                                          opponentDeck == null ||
                                          (isBO3 && (firstMatchFirstSecond == null || firstMatchWinLoss == null)) ||
                                          (isBO3 && secondMatchFirstSecond != null && secondMatchWinLoss == null) ||
                                          (isBO3 && secondMatchFirstSecond == null && secondMatchWinLoss != null) ||
                                          (isBO3 && thirdMatchFirstSecond != null && thirdMatchWinLoss == null) ||
                                          (isBO3 && thirdMatchFirstSecond == null && thirdMatchWinLoss != null)
                                      ? null
                                      : () async {
                                          final okCancelResult = await showOkCancelAlertDialog(
                                            context: context,
                                            message: S.of(context).isSave,
                                            isDestructiveAction: true,
                                          );
                                          if (okCancelResult == OkCancelResult.ok) {
                                            int recordCount;
                                            if (isBO3) {
                                              recordCount = await inputViewNotifier.saveBO3();
                                            } else {
                                              recordCount = await inputViewNotifier.saveBO1();
                                            }
                                            await ref.read(dbHelper).fetchAll();
                                            if (recordCount % 200 == 0) {
                                              final inAppReview = InAppReview.instance;
                                              if (await inAppReview.isAvailable()) {
                                                inAppReview.requestReview();
                                              }
                                            }
                                            ref.refresh(allDeckListProvider);
                                            inputViewNotifier.resetView();
                                          }
                                          // ignore: use_build_context_synchronously
                                          FocusScope.of(context).unfocus();
                                        },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(S.of(context).save),
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const AdaptiveBannerAd(),
          ],
        );
      },
      error: (error, stack) => Text('$error'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _SettingModalBottomSheet extends HookConsumerWidget {
  const _SettingModalBottomSheet({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fixUseDeck = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.fixUseDeck));
    final fixOpponentDeck = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.fixOpponentDeck));
    final fixTag = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.fixTag));
    final draw = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.draw));
    final bo3 = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.bo3));
    final inputiViewSettingsController = ref.watch(inputViewSettingsNotifierProvider.notifier);
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
                  '入力固定オプション',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SwitchListTile.adaptive(
                contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                title: Text(
                  '使用デッキ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: fixUseDeck,
                onChanged: inputiViewSettingsController.changeFixUseDeck,
              ),
              SwitchListTile.adaptive(
                contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                title: Text(
                  '対戦相手デッキ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: fixOpponentDeck,
                onChanged: inputiViewSettingsController.changeFixOpponentDeck,
              ),
              SwitchListTile.adaptive(
                contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                title: Text(
                  'タグ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: fixTag,
                onChanged: inputiViewSettingsController.changeFixTag,
              ),
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
                onChanged: inputiViewSettingsController.changeDraw,
              ),
              SwitchListTile.adaptive(
                contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                title: Text(
                  'BO3',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: bo3,
                onChanged: inputiViewSettingsController.changeBO3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
