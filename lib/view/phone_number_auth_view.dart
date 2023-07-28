import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';

class PhoneNumberAuthView extends HookConsumerWidget {
  const PhoneNumberAuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final countryDialCode = useState('81');
    final errorText = useState('');
    final hiddenErrorText = useState('開発用隠しエラーコード'); // ストア公開後でもエラーが見えるようにするため暫定的に追加
    final hiddenCount = useState(0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('電話番号認証'),
      ),
      body: GestureDetector(
        onTap: () => hiddenCount.value = hiddenCount.value + 1,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text('認証を行うと、アプリを誤って削除した場合や機種変更時などに、データを復旧できます。'),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
                child: IntlPhoneField(
                  initialCountryCode: 'JP',
                  disableLengthCheck: true,
                  controller: textController,
                  onCountryChanged: (country) {
                    countryDialCode.value = country.dialCode;
                  },
                ),
              ),
              if (errorText.value != '') const SizedBox(height: 16),
              if (errorText.value != '')
                Text(
                  errorText.value,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              if (hiddenErrorText.value != '' && hiddenCount.value > 10)
                Text(
                  hiddenErrorText.value,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              const SizedBox(height: 32),
              SizedBox(
                width: 300.w,
                child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '+${countryDialCode.value}${textController.text}',
                      verificationCompleted: (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {
                        hiddenErrorText.value = e.toString();
                        switch (e.code) {
                          case 'invalid-phone-number':
                            errorText.value = '電話番号が正しくありません。';
                            break;
                          case 'too-many-requests':
                            errorText.value = 'リクエストの上限に達しました。時間を開けて再度お試しください。';
                            break;
                          default:
                            errorText.value = '予期せぬエラーが発生しました。';
                            break;
                        }
                      },
                      codeSent: (String verificationId, int? resendToken) async {
                        errorText.value = '';
                        await showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => AuthAlertDialog(verificationId: verificationId),
                        );
                      },
                      // タイムアウト時の挙動を指定しない場合は空欄でも問題なし
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  },
                  child: Text(
                    '送信',
                    style: Theme.of(context).primaryTextTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthAlertDialog extends HookConsumerWidget {
  const AuthAlertDialog({
    required this.verificationId,
    super.key,
  });
  final String verificationId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final smsCode = useState('');
    final errorCode = useState('');
    final isLogin = ref.watch(firebaseAuthNotifierProvider.select((value) => value.user)) != null;
    return AlertDialog(
      title: const Text("認証コード"),
      content: const Text("SMS宛に届いた認証コードを入力してください。\n届くまでに30秒程度かかる場合があります。"),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        TextFormField(
          onChanged: (value) {
            smsCode.value = value;
          },
        ),
        if (errorCode.value != '') const SizedBox(height: 8),
        if (errorCode.value != '')
          Text(
            errorCode.value,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              child: const Text("キャンセル"),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              child: const Text("認証"),
              onPressed: () async {
                try {
                  errorCode.value = '';
                  if (isLogin) {
                    await ref.read(firebaseAuthNotifierProvider.notifier).linkPhoneNumber(verificationId, smsCode.value);
                  } else {
                    await ref.read(firebaseAuthNotifierProvider.notifier).signInPhoneNumber(verificationId, smsCode.value);
                  }
                  if (context.mounted) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                } on FirebaseException catch (e) {
                  switch (e.code) {
                    case 'invalid-verification-code':
                      errorCode.value = '認証コードが正しくありません。正しいコードを入力してください。';
                      break;
                    case 'credential-already-in-use':
                      errorCode.value = 'すでに利用中のアカウントが存在します。ログアウトして、そのアカウントでログインしてください。(現在登録されている情報は全て削除されます。)';
                      break;
                    case 'provider-already-linked':
                      errorCode.value = 'すでに他の電話番号で認証されています。認証した電話番号をお試しください。';
                      break;
                    default:
                      errorCode.value = '予期せぬエラーが発生しました。';
                      break;
                  }
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
