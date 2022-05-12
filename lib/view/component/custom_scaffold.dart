import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/input_view_provider.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/view/component/custom_modal_list_picker.dart';

class CustomScaffold extends HookConsumerWidget {
  const CustomScaffold({
    required this.body,
    this.rightButton,
    this.appBarBottom,
    this.padding,
    key,
  }) : super(key: key);
  final Widget body;
  final Widget? rightButton;
  final PreferredSizeWidget? appBarBottom;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectGame = ref.watch(selectGameNotifierProvider);
    final decks = ref.watch(allGameListNotifierProvider);
    final selectGameNotifier = ref.read(selectGameNotifierProvider.notifier);
    final inputViewNotifier = ref.read(inputViewNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          selectGame.selectGame != null ? selectGame.selectGame!.game : '',
          style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          _GameListPickerButton(
            submited: () {
              selectGameNotifier.setSelectGame();
              inputViewNotifier.resetView();
            },
            onSelectedItemChanged: selectGameNotifier.scrollSelectGame,
            children: decks.allGameList!
                .map((game) => Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text(
                        game.game,
                        // softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline6?.copyWith(height: 1),
                      ),
                    ))
                .toList(),
          ),
          if (rightButton != null) rightButton!,
        ],
        bottom: appBarBottom != null ? appBarBottom! : null,
      ),
      body: Padding(
        padding: padding != null ? padding! : const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
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
      onPressed: () {
        showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) {
            return CustomModalListPicker(
              actionButton: CupertinoButton(
                onPressed: () async {
                  final games = await showTextInputDialog(
                    context: context,
                    title: S.of(context).newGameDialog,
                    textFields: [const DialogTextField()],
                  );
                  if (games != null && games.first != '') {
                    await selectGameNotifier.saveGame(games.first);
                    inputViewNotifier.resetView();
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                },
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 5,
                ),
                child: Text(S.of(context).newGame),
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
