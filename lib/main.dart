import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/helper/att.dart';
import 'package:tcg_manager/helper/db_helper.dart';
import 'package:tcg_manager/helper/theme_data.dart';
import 'package:tcg_manager/provider/adaptive_banner_ad_provider.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/provider/theme_provider.dart';
import 'package:tcg_manager/view/bottom_navigation_view.dart';
import 'package:tcg_manager/view/initial_game_registration_view.dart';

import 'generated/l10n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ATT.instance.requestPermission().then((result) {
    MobileAds.instance.initialize();
  });

  MobileAds.instance.initialize();
  runApp(
    ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: () => const ProviderScope(
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
      Future.microtask(() {
        ref.read(adaptiveBannerAdNotifierProvider.notifier).getAd(context);
        ref.read(dbHelper).fetchAll();
        ref.read(themeNotifierProvider.notifier).themeInitialize();
      });
      return;
    }, const []);

    final allGameList = ref.watch(allGameListNotifierProvider).allGameList;
    final allDeckList = ref.watch(allDeckListNotifierProvider).allDeckList;
    final allRecordList = ref.watch(allRecordListNotifierProvider).allRecordList;
    final allTagList = ref.watch(allTagListNotifierProvider).allTagList;
    final lightThemeData = ref.watch(lightThemeDataProvider);
    final darkThemeData = ref.watch(darkThemeDataProvider);

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
      home: allGameList == null && allDeckList == null && allRecordList == null && allTagList == null
          ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : allGameList!.isEmpty
              ? const InitialGameRegistrationView()
              : const BottomNavigationView(),
    );
  }
}
