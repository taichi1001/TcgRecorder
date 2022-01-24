import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/provider/game_list_provider.dart';
import 'package:tcg_recorder2/provider/select_game_provider.dart';
import 'package:tcg_recorder2/repository/game_repository.dart';
import 'package:tcg_recorder2/view/component/custom_textfield.dart';

class InitialGameRegistrationView extends HookConsumerWidget {
  const InitialGameRegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameTextEditingController = useTextEditingController();
    final selectGameNotifier = ref.read(selectGameNotifierProvider.notifier);
    final selectGameState = ref.watch(selectGameNotifierProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('記録したいゲーム名を入力してください'),
            CustomTextField(
              labelText: 'ゲーム名',
              controller: gameTextEditingController,
              onChanged: selectGameNotifier.changeGameForString,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (selectGameState.selectGame == null) {
                    null;
                  } else {
                    ref.read(gameRepository).insert(selectGameState.selectGame!);
                    ref.read(allGameListNotifierProvider.notifier).fetch();
                  }
                },
                child: const Text('SAVE'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
