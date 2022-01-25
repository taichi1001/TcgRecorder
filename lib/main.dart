import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/provider/game_list_provider.dart';
import 'package:tcg_recorder2/provider/select_game_provider.dart';
import 'package:tcg_recorder2/view/bottom_navigation_view.dart';
import 'package:tcg_recorder2/view/initial_game_registration_view.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends HookConsumerWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future.microtask(() => ref.read(allGameListNotifierProvider.notifier).fetch());
      ref.read(selectGameNotifierProvider.notifier).startupGame();
      return;
    }, const []);
    final gameListState = ref.watch(allGameListNotifierProvider);

    if (gameListState.allGameList == null) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    return MaterialApp(
      home: Scaffold(
        body: gameListState.allGameList!.isEmpty
            ? const InitialGameRegistrationView()
            : const BottomNavigationView(),
      ),
    );
  }
}
