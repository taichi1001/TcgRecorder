import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/helper/att.dart';
import 'package:tcg_manager/helper/theme_data.dart';
import 'package:tcg_manager/provider/adaptive_banner_ad_provider.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/input_view_settings_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/provider/theme_provider.dart';
import 'package:tcg_manager/view/bottom_navigation_view.dart';
import 'package:tcg_manager/view/initial_game_registration_view.dart';

import 'generated/l10n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  ATT.instance.requestPermission().then((result) {
    MobileAds.instance.initialize();
  });

  MobileAds.instance.initialize();
  runApp(
    ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) => const ProviderScope(
        child: MainApp(),
      ),
    ),
  );
}

class MainInfo {
  const MainInfo({
    required this.allGameList,
    required this.allDeckList,
    required this.allTagList,
    required this.allRecordList,
    // required this.selectGame,
  });
  final List<Game> allGameList;
  final List<Deck> allDeckList;
  final List<Tag> allTagList;
  final List<Record> allRecordList;
  // final Game? selectGame;
}

final mainInfoProvider = FutureProvider.autoDispose<MainInfo>((ref) async {
  final allGameList = await ref.watch(allGameListProvider.future);
  final allDeckList = await ref.watch(allDeckListProvider.future);
  final allTagList = await ref.watch(allTagListProvider.future);
  final allRecordList = await ref.watch(allRecordListProvider.future);
  // final selectGame = ref.watch(selectGameNotifierProvider).selectGame;
  ref.keepAlive();
  return MainInfo(
    allGameList: allGameList,
    allDeckList: allDeckList,
    allTagList: allTagList,
    allRecordList: allRecordList,
    // selectGame: selectGame,
  );
});

class MainApp extends HookConsumerWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future.microtask(() {
        ref.read(adaptiveBannerAdNotifierProvider.notifier).getAd(context);
        ref.read(themeNotifierProvider.notifier).themeInitialize();
        ref.read(inputViewSettingsNotifierProvider.notifier).settingsInitialize();
      });
      return;
    }, const []);
    final mainInfo = ref.watch(mainInfoProvider);
    final lightThemeData = ref.watch(lightThemeDataProvider);
    final darkThemeData = ref.watch(darkThemeDataProvider);

    return mainInfo.when(
      data: (mainInfo) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            S.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          theme: lightThemeData,
          darkTheme: darkThemeData,
          themeMode: ThemeMode.system,
          home: mainInfo.allGameList.isEmpty ? const InitialGameRegistrationView() : const BottomNavigationView(),
        );
      },
      error: (error, stack) => Text('$error'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
