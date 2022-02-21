import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
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
import 'package:tcg_manager/view/component/custom_modal_list_picker.dart';
import 'package:tcg_manager/view/component/custom_scaffold.dart';
import 'package:tcg_manager/view/component/custom_textfield.dart';

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
    final outputFormat = DateFormat('yyyy年 MM月 dd日');

    return SafeArea(
      top: false,
      child: Column(
        children: [
          Expanded(
            child: CustomScaffold(
              body: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
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
                                outputFormat.format(date),
                              ),
                              _DatePickerButton(
                                submited: inputViewNotifier.setDateTime,
                                onDateTimeChanged: inputViewNotifier.scrollDateTime,
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
                                onChanged: inputViewNotifier.inputUseDeck,
                                controller: useDeckTextController,
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
                                onChanged: inputViewNotifier.inputOpponentDeck,
                                controller: opponentDeckTextController,
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
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ],
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
                          Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              CustomTextField(
                                labelText: 'タグ',
                                onChanged: inputViewNotifier.inputTag,
                                controller: tagTextController,
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
                            activeColor: const Color(0xFF18204E),
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
                            activeColor: const Color(0xFF18204E),
                            onChanged: (FirstSecond? value) {
                              inputViewNotifier.selectFirstSecond(value);
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
                              inputViewNotifier.selectWinLoss(value);
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
                              inputViewNotifier.selectWinLoss(value);
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
                            onChanged: inputViewNotifier.inputMemo,
                            labelText: '改行もできます',
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                          ),
                          const SizedBox(height: 8),
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
                                            }
                                            ref.read(textEditingControllerNotifierProvider.notifier).resetInputViewController();
                                            FocusScope.of(context).unfocus();
                                          },
                                    child: Text(S.of(context).save),
                                    style: ElevatedButton.styleFrom(
                                      primary: const Color(0xFF18204E),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const AdaptiveBannerAd(),
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
