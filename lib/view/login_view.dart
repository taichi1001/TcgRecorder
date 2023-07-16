import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/provider/firestore_backup_controller_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
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
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 16),
            Text(
              '記録・分析して勝利への近道を探しましょう',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 32),
            SvgPicture.asset(
              'assets/images/login_view_image.svg',
              height: 200.w,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 300.w,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PhoneNumberAuthView(),
                    ),
                  );
                  final gameList = await ref.read(allGameListProvider.future);
                  if (context.mounted && ref.read(firebaseAuthNotifierProvider).user != null && gameList.isEmpty) {
                    await ref.read(firestoreBackupControllerProvider).restoreAll();
                  }
                },
                child: Text(
                  '電話番号でログイン',
                  style: Theme.of(context).primaryTextTheme.titleMedium,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                await ref.read(firebaseAuthNotifierProvider.notifier).signInAnonymously();
              },
              child: const Text('ログインせずに始める'),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '新たにVer2.0.0でログイン機能を追加いたしました。\n既にアプリをご利用中の皆様も、電話番号でログインするか、ログインせずに始めるか選択いただけます。\nどちらの方法を選択されても、これまでご利用いただいたデータはß保持されておりますのでご安心ください。',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
