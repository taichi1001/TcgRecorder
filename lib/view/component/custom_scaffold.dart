import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/provider/game_list_provider.dart';
import 'package:tcg_recorder2/provider/input_view_provider.dart';
import 'package:tcg_recorder2/provider/select_game_provider.dart';
import 'package:tcg_recorder2/view/component/custom_modal_list_picker.dart';

class CustomScaffold extends HookConsumerWidget {
  const CustomScaffold({
    required this.body,
    this.rightButton,
    key,
  }) : super(key: key);
  final Widget body;
  final Widget? rightButton;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectGame = ref.watch(selectGameNotifierProvider);
    final decks = ref.watch(allGameListNotifierProvider);
    final selectGameNotifier = ref.read(selectGameNotifierProvider.notifier);
    final inputViewNotifier = ref.read(inputViewNotifierProvider.notifier);

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
          if (rightButton != null) rightButton!,
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
        child: body,
      ),
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
