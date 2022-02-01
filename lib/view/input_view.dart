import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/input_view_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/text_editing_controller_provider.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/state/input_view_state.dart';
import 'package:tcg_manager/view/component/custom_modal_date_picker.dart';
import 'package:tcg_manager/view/component/custom_modal_list_picker.dart';
import 'package:tcg_manager/view/component/custom_scaffold.dart';
import 'package:tcg_manager/view/component/custom_textfield.dart';

class InputView extends HookConsumerWidget {
  const InputView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameDeck = ref.watch(gameDeckListProvider);
    final date = ref.watch(inputViewNotifierProvider.select((value) => value.date));
    final winLoss = ref.watch(inputViewNotifierProvider.select((value) => value.winLoss));
    final firstSecond = ref.watch(inputViewNotifierProvider.select((value) => value.firstSecond));
    final useDeck = ref.watch(inputViewNotifierProvider.select((value) => value.useDeck));
    final opponentDeck = ref.watch(inputViewNotifierProvider.select((value) => value.opponentDeck));
    final inputViewNotifier = ref.read(inputViewNotifierProvider.notifier);
    final useDeckTextController = ref.watch(
      textEditingControllerNotifierProvider.select((value) => value.useDeckController),
    );
    final opponentDeckTextController = ref.watch(
      textEditingControllerNotifierProvider.select((value) => value.opponentDeckController),
    );
    final outputFormat = DateFormat('yyyy年 MM月 dd日');

    return SafeArea(
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
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: Text('Day'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(outputFormat.format(date)),
                              _DatePickerButton(
                                submited: inputViewNotifier.setDateTime,
                                onDateTimeChanged: inputViewNotifier.scrollDateTime,
                              ),
                            ],
                          ),
                          const Text('Deck'),
                          Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              CustomTextField(
                                labelText: '使用デッキ',
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
                                labelText: '対戦デッキ',
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
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                            child: Text('First or Second'),
                          ),
                          RadioListTile(
                            title: const Text('先攻'),
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
                            title: const Text('後攻'),
                            value: FirstSecond.second,
                            groupValue: firstSecond,
                            activeColor: const Color(0xFF18204E),
                            onChanged: (FirstSecond? value) {
                              inputViewNotifier.selectFirstSecond(value);
                            },
                            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                            dense: true,
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                            child: Text('Win/Loss'),
                          ),
                          RadioListTile(
                            title: const Text('勝ち'),
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
                            title: const Text('負け'),
                            value: WinLoss.loss,
                            groupValue: winLoss,
                            activeColor: const Color(0xFF18204E),
                            onChanged: (WinLoss? value) {
                              inputViewNotifier.selectWinLoss(value);
                            },
                            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                            dense: true,
                          ),
                        ],
                      ),
                      Center(
                        child: SizedBox(
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: useDeck == null || opponentDeck == null
                                ? null
                                : () async {
                                    final okCancelResult = await showOkCancelAlertDialog(
                                      context: context,
                                      message: '保存してもいいですか？',
                                      isDestructiveAction: true,
                                    );
                                    if (okCancelResult == OkCancelResult.ok) {
                                      await inputViewNotifier.save();
                                      await ref.read(allDeckListNotifierProvider.notifier).fetch();
                                      await ref.read(allRecordListNotifierProvider.notifier).fetch();
                                    }
                                  },
                            child: const Text('SAVE'),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF18204E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // const AdaptiveBannerAd(), //一意のAdWidgetオブジェクトを使用するように修正必要
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
