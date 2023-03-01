import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/provider/firestore_controller.dart';
import 'package:tcg_manager/view/phone_number_auth_view.dart';

final fromPhoneAuthProvider = StateProvider((ref) => false);

class LoginView extends HookConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'トレマネへようこそ',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await ref.read(firebaseAuthNotifierProvider.notifier).signInAnonymously();
              },
              child: const Text('はじめてみる'),
            ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PhoneNumberAuthView(),
                  ),
                );
                if (context.mounted && ref.read(firebaseAuthNotifierProvider).user != null) {
                  await ref.read(firestoreController).restoreAll();
                }
              },
              child: const Text('以前に電話番号認証していた方はこちら'),
            ),
          ],
        ),
      ),
    );
  }
}
