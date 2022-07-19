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
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/helper/db_helper.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/input_view_provider.dart';
import 'package:tcg_manager/provider/text_editing_controller_provider.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/selector/game_tag_list_selector.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
import 'package:tcg_manager/view/component/custom_modal_date_picker.dart';
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
    final firstSecond = ref.watch(inputViewNotifierProvider.select((value) => value.firstSecond));
    final useDeck = ref.watch(inputViewNotifierProvider.select((value) => value.useDeck));
    final opponentDeck = ref.watch(inputViewNotifierProvider.select((value) => value.opponentDeck));
    final inputViewNotifier = ref.read(inputViewNotifierProvider.notifier);
    final useDeckTextController = ref.watch(textEditingControllerNotifierProvider.select((value) => value.useDeckController));
    final opponentDeckTextController = ref.watch(textEditingControllerNotifierProvider.select((value) => value.opponentDeckController));
    final tagTextController = ref.watch(textEditingControllerNotifierProvider.select((value) => value.tagController));
    final memoTextController = ref.watch(textEditingControllerNotifierProvider.select((value) => value.memoController));
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
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomModalDatePicker(
                                  submited: () {
                                    inputViewNotifier.setDateTime();
                                    Navigator.pop(context);
                                  },
                                  onDateTimeChanged: inputViewNotifier.scrollDateTime,
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
                          children: [
                            SizedBox(
                              width: 205.w,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      RadioListTile(
                                        title: Text(S.of(context).first),
                                        value: FirstSecond.first,
                                        groupValue: firstSecond,
                                        onChanged: (FirstSecond? value) {
                                          inputViewNotifier.selectFirstSecond(value);
                                        },
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                        dense: true,
                                      ),
                                      RadioListTile(
                                        title: Text(S.of(context).second),
                                        value: FirstSecond.second,
                                        groupValue: firstSecond,
                                        onChanged: (FirstSecond? value) {
                                          inputViewNotifier.selectFirstSecond(value);
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
                              width: 205.w,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      RadioListTile(
                                        title: Text(S.of(context).win),
                                        value: WinLoss.win,
                                        groupValue: winLoss,
                                        onChanged: (WinLoss? value) {
                                          inputViewNotifier.selectWinLoss(value);
                                        },
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                        dense: true,
                                      ),
                                      RadioListTile(
                                        title: Text(S.of(context).loss),
                                        value: WinLoss.loss,
                                        groupValue: winLoss,
                                        onChanged: (WinLoss? value) {
                                          inputViewNotifier.selectWinLoss(value);
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
                                  onPressed: useDeck == null || opponentDeck == null
                                      ? null
                                      : () async {
                                          final okCancelResult = await showOkCancelAlertDialog(
                                            context: context,
                                            message: S.of(context).isSave,
                                            isDestructiveAction: true,
                                          );
                                          if (okCancelResult == OkCancelResult.ok) {
                                            final recordCount = await inputViewNotifier.save();
                                            await ref.read(dbHelper).fetchAll();
                                            // if (recordCount % 42 == 0) {
                                            // レビュー催促ダイアログ表示
                                            final inAppReview = InAppReview.instance;
                                            if (await inAppReview.isAvailable()) {
                                              inAppReview.requestReview();
                                            }
                                            // }
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
