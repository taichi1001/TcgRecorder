import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/provider/deck_list_provider.dart';
import 'package:tcg_recorder2/provider/game_list_provider.dart';
import 'package:tcg_recorder2/provider/input_view_provider.dart';
import 'package:tcg_recorder2/provider/record_list_provider.dart';
import 'package:tcg_recorder2/provider/select_game_provider.dart';
import 'package:tcg_recorder2/provider/text_editing_controller_provider.dart';
import 'package:tcg_recorder2/selector/game_deck_list_selector.dart';
import 'package:tcg_recorder2/state/input_view_state.dart';
import 'package:tcg_recorder2/view/component/custom_modal_date_picker.dart';
import 'package:tcg_recorder2/view/component/custom_modal_list_picker.dart';
import 'package:tcg_recorder2/view/component/custom_textfield.dart';

class InputView extends HookConsumerWidget {
  const InputView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectGame = ref.watch(selectGameNotifierProvider);
    final decks = ref.watch(allGameListNotifierProvider);
    final gameDeck = ref.watch(gameDeckListProvider);
    final date = ref.watch(inputViewNotifierProvider.select((value) => value.date));
    final winLoss = ref.watch(inputViewNotifierProvider.select((value) => value.winLoss));
    final firstSecond = ref.watch(inputViewNotifierProvider.select((value) => value.firstSecond));
    final inputViewNotifier = ref.read(inputViewNotifierProvider.notifier);
    final selectGameNotifier = ref.read(selectGameNotifierProvider.notifier);
    final useDeckTextController = ref.watch(
      textEditingControllerNotifierProvider.select((value) => value.useDeckController),
    );
    final opponentDeckTextController = ref.watch(
      textEditingControllerNotifierProvider.select((value) => value.opponentDeckController),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          selectGame.selectGame != null ? selectGame.selectGame!.game : '',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        actions: [
          _GameListPickerButton(
            submited: () {
              selectGameNotifier.setSelectGame();
              inputViewNotifier.resetView();
            },
            onSelectedItemChanged: selectGameNotifier.scrollSelectGame,
            children: decks.allGameList!.map((game) => Text(game.game)).toList(),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
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
                        Text(date.toIso8601String()),
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
                          children: gameDeck.map((deck) => Text(deck.deck)).toList(),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        CustomTextField(
                          labelText: '対戦相手デッキ',
                          onChanged: inputViewNotifier.inputOpponentDeck,
                          controller: opponentDeckTextController,
                        ),
                        _ListPickerButton(
                          submited: inputViewNotifier.setOpponentDeck,
                          onSelectedItemChanged: inputViewNotifier.scrollOpponentDeck,
                          children: gameDeck.map((deck) => Text(deck.deck)).toList(),
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
            Center(
              child: SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    await inputViewNotifier.save();
                    await ref.read(allDeckListNotifierProvider.notifier).fetch();
                    await ref.read(allRecordListNotifierProvider.notifier).fetch();
                  },
                  child: const Text('SAVE'),
                  style: ElevatedButton.styleFrom(
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
        color: Colors.black,
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
      onPressed: () {
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

class _GameListPickerButton extends HookConsumerWidget {
  const _GameListPickerButton({
    required this.submited,
    required this.onSelectedItemChanged,
    required this.children,
    key,
  }) : super(key: key);
  final void Function() submited;
  final Function(int) onSelectedItemChanged;
  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectGameNotifier = ref.read(selectGameNotifierProvider.notifier);
    final inputViewNotifier = ref.read(inputViewNotifierProvider.notifier);
    return IconButton(
      icon: const Icon(Icons.arrow_drop_down),
      color: Colors.black,
      onPressed: () {
        showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) {
            return CustomModalListPicker(
              actionButton: CupertinoButton(
                onPressed: () async {
                  final games = await showTextInputDialog(
                    context: context,
                    title: '新規ゲーム追加',
                    textFields: [const DialogTextField()],
                  );
                  if (games != null && games.first != '') {
                    await selectGameNotifier.saveGame(games.first);
                    inputViewNotifier.resetView();
                    Navigator.pop(context);
                  }
                },
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 5,
                ),
                child: const Text('新規追加'),
              ),
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
