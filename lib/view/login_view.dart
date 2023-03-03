import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/provider/firestore_controller.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/record_detail_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/view/phone_number_auth_view.dart';

final fromPhoneAuthProvider = StateProvider((ref) => false);

class LoginView extends HookConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 140, bottom: 140, left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'トレマネへようこそ',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '記録・分析して勝利への近道を探しましょう。',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              SvgPicture.asset(
                'assets/images/login_view_image.svg',
                height: 200.w,
              ),
              Column(
                children: [
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
                          await ref.read(firestoreController).restoreAll();
                        }
                      },
                      child: Text(
                        '電話番号でログイン',
                        style: Theme.of(context).primaryTextTheme.bodyMedium,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await ref.read(firebaseAuthNotifierProvider.notifier).signInAnonymously();
                    },
                    child: const Text('ログインせずに始める'),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
