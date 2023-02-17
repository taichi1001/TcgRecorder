import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/helper/authentication_erro_to_ja.dart';
import 'package:tcg_manager/provider/google_auth_model.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final googleAuthNotifier = ref.watch(googleAuthNotifierProvider.notifier);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ログイン方法選択',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SignInButton(
              Buttons.email,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const _MailLoginView(),
                  ),
                );
              },
            ),
            SignInButton(
              Buttons.google,
              onPressed: () async {
                await googleAuthNotifier.loginWithGoogle();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MailLoginView extends HookConsumerWidget {
  const _MailLoginView({key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final googleAuthNotifier = ref.watch(googleAuthNotifierProvider.notifier);
    final errorText = useState('');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ログイン',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Card(
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: idController,
                      decoration: const InputDecoration(
                        labelText: 'メールアドレス',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'パスワード',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            minimumSize: MaterialStateProperty.all(Size.zero),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PasswordResetView(),
                              ),
                            );
                          },
                          child: const Text('パスワードを忘れましたか？'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      errorText.value,
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          final isVerified = await googleAuthNotifier.loginWithEmail(idController.text, passwordController.text);
                          if (context.mounted) {
                            if (isVerified) {
                              Navigator.popUntil(context, (route) => route.isFirst);
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MailCheckView(
                                    email: idController.text,
                                    password: passwordController.text,
                                  ),
                                ),
                              );
                            }
                          }
                        } catch (e) {
                          errorText.value = AuthenticationErrorToJa.loginErrorMsg(e.hashCode, e.toString());
                        }
                      },
                      child: const Text('ログイン'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MailRegistrationView(),
                          ),
                        );
                      },
                      child: const Text('登録していない場合はこちら'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordResetView extends HookConsumerWidget {
  const PasswordResetView({key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final googleAuthNotifier = ref.watch(googleAuthNotifierProvider.notifier);
    final idController = useTextEditingController(text: '');
    final errorText = useState('');

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'パスワードをリセット',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Card(
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: idController,
                    decoration: const InputDecoration(
                      labelText: 'メールアドレス',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    errorText.value,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await googleAuthNotifier.sendPasswordResetEmail(idController.text);
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        errorText.value = AuthenticationErrorToJa.passwordResetErrorMsg(e.hashCode, e.toString());
                      }
                    },
                    child: const Text('メールを送信'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MailRegistrationView extends HookConsumerWidget {
  const MailRegistrationView({key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final googleAuthNotifier = ref.watch(googleAuthNotifierProvider.notifier);

    final errorText = useState('');

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'アカウントを登録',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Card(
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: idController,
                      decoration: const InputDecoration(
                        labelText: 'メールアドレス',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'パスワード',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      errorText.value,
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await googleAuthNotifier.signUpWithEmail(idController.text, passwordController.text);
                          if (context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => MailCheckView(
                                      email: idController.text,
                                      password: passwordController.text,
                                    )),
                              ),
                            );
                          }
                        } catch (e) {
                          errorText.value = AuthenticationErrorToJa.registerErrorMsg(e.hashCode, e.toString());
                        }
                      },
                      child: const Text('登録'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MailCheckView extends HookConsumerWidget {
  const MailCheckView({
    required this.email,
    required this.password,
    key,
  }) : super(key: key);

  final String email;
  final String password;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sentMailText = useState('$email\nに確認メールを送信しました');
    final googleAuthNotifier = ref.watch(googleAuthNotifierProvider.notifier);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: double.infinity),
                  Text(sentMailText.value),
                  TextButton(
                    onPressed: () async {
                      await googleAuthNotifier.reSendEmailVerification(email, password);
                      sentMailText.value = '$email\nに確認メールを送信しました。';
                    },
                    child: const Text('確認メール再送信'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final emailVerified = await googleAuthNotifier.loginWithEmail(email, password);
                      if (emailVerified && context.mounted) {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      } else {
                        sentMailText.value = "まだメール確認が完了していません。\n確認メール内のリンクをクリックしてください。";
                      }
                    },
                    child: const Text('メール確認完了'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
