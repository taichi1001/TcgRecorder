import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/provider/deck_list_provider.dart';
import 'package:tcg_recorder2/provider/input_view_provider.dart';
import 'package:tcg_recorder2/provider/record_list_provider.dart';
import 'package:tcg_recorder2/provider/select_game_provider.dart';
import 'package:tcg_recorder2/provider/text_editing_controller_provider.dart';
import 'package:tcg_recorder2/selector/game_deck_list_selector.dart';
import 'package:tcg_recorder2/view/component/custom_modal_date_picker.dart';
import 'package:tcg_recorder2/view/component/custom_modal_list_picker.dart';
import 'package:tcg_recorder2/view/component/custom_textfield.dart';

class InputView extends HookConsumerWidget {
  const InputView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectGame = ref.watch(selectGameNotifierProvider);
    final gameDeck = ref.watch(gameDeckListProvider);
    final inputViewNotifier = ref.read(inputViewNotifierProvider.notifier);
    final useDeckTextController = ref.watch(
      textEditingControllerNotifierProvider.select((value) => value.useDeckController),
    );
    final opponentDeckTextController = ref.watch(
      textEditingControllerNotifierProvider.select((value) => value.opponentDeckController),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectGame.selectGame != null ? selectGame.selectGame!.game : '',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_drop_down_outlined),
            color: Colors.black,
            onPressed: () {},
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
                        const Text('2022/01/18'),
                        _DatePickerButton(
                          submited: () {},
                          onDateTimeChanged: (date) {},
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
                          submited: () {},
                          onSelectedItemChanged: (value) {
                            inputViewNotifier.selectUseDeck(value);
                          },
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
                          submited: () {},
                          onSelectedItemChanged: (value) {
                            inputViewNotifier.selectOpponentDeck(value);
                          },
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
                      value: 1,
                      groupValue: 1,
                      onChanged: (value) {},
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      dense: true,
                    ),
                    RadioListTile(
                      title: const Text('後攻'),
                      value: 2,
                      groupValue: 1,
                      onChanged: (value) {},
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      dense: true,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: Text('Win/Loss'),
                    ),
                    RadioListTile(
                      title: const Text('勝ち'),
                      value: 1,
                      groupValue: 1,
                      onChanged: (value) {},
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      dense: true,
                    ),
                    RadioListTile(
                      title: const Text('負け'),
                      value: 2,
                      groupValue: 1,
                      onChanged: (value) {},
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
                submited: submited,
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
              submited: submited,
              onSelectedItemChanged: onSelectedItemChanged,
              children: children,
            );
          },
        );
      },
    );
  }
}
