import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/provider/game_list_provider.dart';
import 'package:tcg_recorder2/provider/initital_game_registration_provider.dart';
import 'package:tcg_recorder2/view/component/custom_textfield.dart';

class InitialGameRegistrationView extends HookConsumerWidget {
  const InitialGameRegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameTextEditingController = useTextEditingController();
    final initialGameRegistrationNotifier = ref.read(initialGameRegistrationNotifierProvider.notifier);
    final initialGameState = ref.watch(initialGameRegistrationNotifierProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('記録したいゲーム名を入力してください'),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'ゲーム名',
              controller: gameTextEditingController,
              onChanged: initialGameRegistrationNotifier.changeGameForString,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (initialGameState.initialGame == null) {
                    null;
                  } else {
                    initialGameRegistrationNotifier.save();
                    ref.read(allGameListNotifierProvider.notifier).fetch();
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
          ],
        ),
      ),
    );
  }
}
