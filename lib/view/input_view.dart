import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/helper/db_helper.dart';
import 'package:tcg_manager/provider/input_view_provider.dart';
import 'package:tcg_manager/provider/text_editing_controller_provider.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/selector/game_tag_list_selector.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
import 'package:tcg_manager/view/component/custom_modal_date_picker.dart';
import 'package:tcg_manager/view/component/custom_scaffold.dart';
import 'package:tcg_manager/view/component/custom_textfield.dart';
import 'package:tcg_manager/view/select_deck_view.dart';

class InputView extends HookConsumerWidget {
  const InputView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameDeck = ref.watch(gameDeckListProvider);
    final gameTag = ref.watch(gameTagListProvider);
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

    final useDeckFocusnode = useFocusNode();
    final opponentDeckFocusnode = useFocusNode();
    final tagFocusnode = useFocusNode();
    final memoFocusnode = useFocusNode();

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
                                _ListPickerButton(
                                  submited: inputViewNotifier.setUseDeck,
                                  onSelectedItemChanged: inputViewNotifier.scrollUseDeck,
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
                                  onChanged: inputViewNotifier.inputOpponentDeck,
                                  controller: opponentDeckTextController,
                                  focusNode: opponentDeckFocusnode,
                                ),
                                _ListPickerButton(
                                  submited: inputViewNotifier.setOpponentDeck,
                                  onSelectedItemChanged: inputViewNotifier.scrollOpponentDeck,
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
                                  onChanged: inputViewNotifier.inputTag,
                                  controller: tagTextController,
                                  focusNode: tagFocusnode,
                                ),
                                _ListPickerButton(
                                  submited: inputViewNotifier.setTag,
                                  onSelectedItemChanged: inputViewNotifier.scrollTag,
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
                                        await inputViewNotifier.save();
                                        await ref.read(dbHelper).fetchAll();
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
              showCupertinoModalBottomSheet(
                expand: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  // return CustomModalListPicker(
                  //   submited: () {
                  //     submited();
                  //     Navigator.pop(context);
                  //     FocusScope.of(context).unfocus();
                  //   },
                  //   onSelectedItemChanged: onSelectedItemChanged,
                  //   children: children,
                  // );
                  return const SelectDeckView();
                },
              );
            },
    );
  }
}
