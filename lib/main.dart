import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/firebase_options.dart';
import 'package:tcg_manager/helper/att.dart';
import 'package:tcg_manager/helper/theme_data.dart';
import 'package:tcg_manager/provider/adaptive_banner_ad_provider.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/provider/firestor_config_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';
import 'package:tcg_manager/repository/dynamic_links_repository.dart';
import 'package:tcg_manager/state/revenue_cat_state.dart';
import 'package:tcg_manager/view/bottom_navigation_view.dart';
import 'package:tcg_manager/view/initial_game_registration_view.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tcg_manager/view/login_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version/version.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const String iosAPIKey = 'appl_qGfPwLpLoCrmULsxbiCIsWgWDpx';
  const String androidAPIKey = '';

  final revenueCatAPIKey = Platform.isIOS ? iosAPIKey : androidAPIKey;

  late final RevenueCatState revenueCat;
  late final SharedPreferences prefs;
  late final String imagePath;

  await Future.wait([
    // Firebase初期化
    Future(
      () async {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      },
    ),
    // 課金関連初期化
    Future(() async {
      try {
        await Purchases.setDebugLogsEnabled(kDebugMode);
        await Purchases.configure(PurchasesConfiguration(revenueCatAPIKey));
        final info = await Purchases.getCustomerInfo();
        final offerings = await Purchases.getOfferings();
        revenueCat = RevenueCatState(
          customerInfo: info,
          offerings: offerings,
          isPremium: info.entitlements.all['premium']?.isActive ?? false,
        );
      } catch (e) {
        revenueCat = RevenueCatState(
          isPremium: false,
          exception: e as Exception,
        );
      }
    }),
    // SharedPreferences初期化
    Future(() async {
      prefs = await SharedPreferences.getInstance();
    }),
    Future(() async {
      final saveDir = await getApplicationDocumentsDirectory();
      imagePath = saveDir.path;
    }),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
    ATT.instance.requestPermission().then((result) {
      MobileAds.instance.initialize();
    }),
    MobileAds.instance.initialize(),
  ]);
  await generateNoticeSetting();

  runApp(
    ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) => ProviderScope(
        overrides: [
          revenueCatProvider.overrideWithValue(revenueCat),
          sharedPreferencesProvider.overrideWithValue(prefs),
          imagePathProvider.overrideWithValue(imagePath),
          // dynamicLinkProvider.overrideWithValue(initialLink?.link),
        ],
        child: const MainApp(),
      ),
    ),
  );
}

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) => throw UnimplementedError);
final imagePathProvider = Provider<String>((ref) => throw UnimplementedError);
final dynamicLinkProvider = Provider<Uri?>((ref) => throw UnimplementedError);

class MainInfo {
  const MainInfo({
    required this.allGameList,
    required this.requiredVersion,
    required this.packageInfo,
  });
  final List<Game> allGameList;
  final String requiredVersion;
  final PackageInfo packageInfo;
}

final mainInfoProvider = FutureProvider.autoDispose<MainInfo>((ref) async {
  final allGameList = await ref.watch(allGameListProvider.future);
  final version = await ref.watch(requiredVersionProvider.future);
  final packgaeInfo = await PackageInfo.fromPlatform();
  ref.read(firebaseAuthNotifierProvider.notifier).login();

  return MainInfo(
    allGameList: allGameList,
    requiredVersion: version,
    packageInfo: packgaeInfo,
  );
});

class MainApp extends HookConsumerWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future.microtask(() {
        ref.read(adaptiveBannerAdNotifierProvider.notifier).getAd(context);
      });
      return;
    }, const []);
    final mainInfo = ref.watch(mainInfoProvider);
    final lightThemeData = ref.watch(lightThemeDataProvider(context));
    final darkThemeData = ref.watch(darkThemeDataProvider(context));
    final isLogin = ref.watch(firebaseAuthNotifierProvider.select((value) => value.user)) != null;

    return mainInfo.when(
      data: (mainInfo) {
        final versionIsOk = Version.parse(mainInfo.requiredVersion) < Version.parse(mainInfo.packageInfo.version);
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
          home: versionIsOk
              ? isLogin
                  ? mainInfo.allGameList.isEmpty
                      ? const InitialGameRegistrationView()
                      : const BottomNavigationView()
                  : const LoginView()
              : const UpdaterView(),
          navigatorObservers: [FlutterSmartDialog.observer],
          builder: FlutterSmartDialog.init(),
        );
      },
      error: (error, stack) => Text('$error'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

Future generateNoticeSetting() async {
  final messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('⭐ User granted permission: ${settings.authorizationStatus}');

  final token = await messaging.getToken();
  print('🔥 FCM TOKEN: $token');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message in the foreground!');

    if (message.notification != null) {
      print('ForegroundMessage Title: ${message.notification?.title}');
      print('ForegroundMessage Body: ${message.notification?.body}');
    }
  });
}

class UpdaterView extends HookConsumerWidget {
  const UpdaterView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await showOkAlertDialog(
          context: context,
          title: 'バージョン更新のお知らせ',
          message: '新しいバージョンのアプリが利用可能です。ストアより更新版を入手して、ご利用下さい。',
          okLabel: '今すぐ更新',
        );
        await launchUrl(
          Uri.parse(
            Platform.isIOS
                ? 'https://apps.apple.com/jp/app/トレカ戦績管理アプリ-トレマネ/id1609073371'
                : 'https://applion.jp/android/app/com.taichi1001.tcg_manager/',
          ),
        );
      },
    );
    return Container();
  }
}
