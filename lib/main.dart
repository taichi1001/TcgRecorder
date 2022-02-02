import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/provider/adaptive_banner_ad_provider.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/view/bottom_navigation_view.dart';
import 'package:tcg_manager/view/initial_game_registration_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(
    DevicePreview(
      // enabled: !kReleaseMode,
      enabled: false,
      builder: (context) => ProviderScope(
        child: MaterialApp(
            useInheritedMediaQuery: true,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            localizationsDelegates: const [
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ja', 'JP'),
            ],
            home: MainApp()),
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
        ref.read(allGameListNotifierProvider.notifier).fetch();
        ref.read(allDeckListNotifierProvider.notifier).fetch();
        ref.read(allRecordListNotifierProvider.notifier).fetch();
        ref.read(allTagListNotifierProvider.notifier).fetch();
      });
      return;
    }, const []);

    final allGameList = ref.watch(allGameListNotifierProvider).allGameList;
    final allDeckList = ref.watch(allDeckListNotifierProvider).allDeckList;
    final allRecordList = ref.watch(allRecordListNotifierProvider).allRecordList;
    final allTagList = ref.watch(allTagListNotifierProvider).allTagList;

    return allGameList == null && allDeckList == null && allRecordList == null && allTagList == null
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Color(0xFF18204E),
              ),
            ),
          )
        : allGameList!.isEmpty
            ? const InitialGameRegistrationView()
            : const BottomNavigationView();
  }
}
