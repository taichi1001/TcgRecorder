import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';

class PhoneNumberDeactivationView extends HookConsumerWidget {
  const PhoneNumberDeactivationView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('電話番号認証の解除'),
      ),
      body: Column(
        children: [
          const Text('電話番号認証をやり直したい場合や、他のアカウントで認証したい場合に解除してください'),
          ElevatedButton(
            onPressed: () async {
              await ref.read(firebaseAuthNotifierProvider.notifier).unlinkPhoneNumber();
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('認証を解除'),
          ),
        ],
      ),
    );
  }
}
