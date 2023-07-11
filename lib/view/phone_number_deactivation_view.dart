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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('電話番号の認証を再度行いたい場合、または現在認証中の電話番号を別のアカウントで認証したい場合は、一度解除してください。'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await ref.read(firebaseAuthNotifierProvider.notifier).unlinkPhoneNumber();
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('認証を解除'),
            ),
          ],
        ),
      ),
    );
  }
}
