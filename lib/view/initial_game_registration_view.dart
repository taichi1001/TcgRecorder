import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/initital_game_registration_provider.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
import 'package:tcg_manager/view/component/custom_textfield.dart';

class InitialGameRegistrationView extends HookConsumerWidget {
  const InitialGameRegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameTextEditingController = useTextEditingController();
    final initialGameRegistrationNotifier = ref.read(initialGameRegistrationNotifierProvider.notifier);
    final initialGameState = ref.watch(initialGameRegistrationNotifierProvider);

    return SafeArea(
      top: false,
      child: Column(
        children: [
          Expanded(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(S.of(context).initializeGame),
                    const SizedBox(height: 16),
                    CustomTextField(
                      labelText: S.of(context).isSave,
                      controller: gameTextEditingController,
                      onChanged: initialGameRegistrationNotifier.changeGameForString,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (initialGameState.initialGame == null) {
                            null;
                          } else {
                            initialGameRegistrationNotifier.save();
                            await ref.read(allGameListNotifierProvider.notifier).fetch();
                            ref.read(selectGameNotifierProvider.notifier).startupGame();
                          }
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
                  ],
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
