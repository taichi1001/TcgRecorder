import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/provider/deck_list_provider.dart';
import 'package:tcg_recorder2/provider/input_view_provider.dart';
import 'package:tcg_recorder2/provider/record_list_provider.dart';
import 'package:tcg_recorder2/provider/select_game_provider.dart';
import 'package:tcg_recorder2/provider/text_editing_controller_provider.dart';
import 'package:tcg_recorder2/selector/game_deck_list_selector.dart';
import 'package:tcg_recorder2/view/component/custom_textfield.dart';
import 'package:tcg_recorder2/view/component/show_cupertino_picker_button.dart';

class InputView extends HookConsumerWidget {
  const InputView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      ref.read(selectGameNotifierProvider.notifier).startupGame();
      return;
    }, const []);

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
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('2022/01/18'),
                        IconButton(
                          icon: const Icon(
                            Icons.calendar_today_rounded,
                            color: Colors.black,
                            size: 16,
                          ),
                          onPressed: () {},
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
                        ShowCupertinoPickerButton(
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
                        ShowCupertinoPickerButton(
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
