import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/provider/deck_list_provider.dart';
import 'package:tcg_recorder2/provider/game_list_provider.dart';
import 'package:tcg_recorder2/provider/record_list_provider.dart';
import 'package:tcg_recorder2/provider/tag_list_provider.dart';
import 'package:tcg_recorder2/view/bottom_navigation_view.dart';
import 'package:tcg_recorder2/view/initial_game_registration_view.dart';

void main() {
  runApp(
    DevicePreview(
      // enabled: !kReleaseMode,
      enabled: false,
      builder: (context) => const ProviderScope(
        child: MainApp(),
      ),
    ),
  );
}

class MainApp extends HookConsumerWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future.microtask(() => ref.read(allGameListNotifierProvider.notifier).fetch());
      Future.microtask(() => ref.read(allDeckListNotifierProvider.notifier).fetch());
      Future.microtask(() => ref.read(allRecordListNotifierProvider.notifier).fetch());
      Future.microtask(() => ref.read(allTagListNotifierProvider.notifier).fetch());
      return;
    }, const []);
    final gameListState = ref.watch(allGameListNotifierProvider);
    final deckListState = ref.watch(allDeckListNotifierProvider);
    final recordListState = ref.watch(allRecordListNotifierProvider);
    final tagListState = ref.watch(allTagListNotifierProvider);

    if (gameListState.allGameList == null &&
        deckListState.allDeckList == null &&
        recordListState.allRecordList == null &&
        tagListState.allTagList == null) {
      return MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        home: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: Scaffold(
        body: gameListState.allGameList!.isEmpty ? const InitialGameRegistrationView() : const BottomNavigationView(),
      ),
    );
  }
}
