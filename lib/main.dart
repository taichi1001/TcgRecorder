import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/firebase_options.dart';
import 'package:tcg_manager/helper/att.dart';
import 'package:tcg_manager/helper/theme_data.dart';
import 'package:tcg_manager/helper/tmp_cache_directory.dart';
import 'package:tcg_manager/provider/database_version_provider.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/provider/firestor_config_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';
import 'package:tcg_manager/provider/reward_ad_state_provider.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/provider/user_activity_provider.dart';
import 'package:tcg_manager/provider/user_info_settings_provider.dart';
import 'package:tcg_manager/repository/firestore_public_user_data_repository.dart';
import 'package:tcg_manager/repository/firestore_share_repository.dart';
import 'package:tcg_manager/view/bottom_navigation_view.dart';
import 'package:tcg_manager/view/game_linking_view.dart';
import 'package:tcg_manager/view/initial_game_registration_view.dart';
import 'package:tcg_manager/view/login_view.dart';
import 'package:tcg_manager/view/shared_game_limit_adjustment_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version/version.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  late final SharedPreferences prefs;
  late final String imagePath;

  // Firebase初期化
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // SharedPreferences初期化
  prefs = await SharedPreferences.getInstance();

  await TmpCacheDirectory.configure();
  await TmpCacheDirectory.deleteFiles();

  final saveDir = await getApplicationDocumentsDirectory();
  imagePath = saveDir.path;
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await ATT.instance.requestPermission().then((result) {
    MobileAds.instance.initialize();
  });
  await generateNoticeSetting();

  runApp(
    ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) => ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          imagePathProvider.overrideWithValue(imagePath),
        ],
        child: const MainApp(),
      ),
    ),
  );
}

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) => throw UnimplementedError);
final imagePathProvider = Provider<String>((ref) => throw UnimplementedError);

class MainInfo {
  const MainInfo({
    required this.requiredVersion,
    required this.packageInfo,
    this.gameList = const [],
    this.lastGame,
  });
  final String requiredVersion;
  final PackageInfo packageInfo;
  final Game? lastGame;
  final List<Game> gameList;
}

final mainInfoProvider = FutureProvider.autoDispose.family<MainInfo, BuildContext>((ref, context) async {
  final version = await ref.watch(requiredVersionProvider.future);
  final packgaeInfo = await PackageInfo.fromPlatform();
  final allGameList = await ref.watch(allGameListProvider.future);
  final allRecordList = await ref.read(allRecordListProvider.future);
  // データベースバージョンの更新。
  // ref.read(databaseVersionNotifierProvider.notifier).updateDatabaseVersion(2);

  Game? lastGame;
  for (final record in allRecordList) {
    for (final game in allGameList) {
      if (record.gameId == game.id) {
        lastGame = game;
      }
    }
  }
  ref.read(firebaseAuthNotifierProvider.notifier).login();
  await ref.read(initialSelectGameAsyncNotifierProvider.future);
  return MainInfo(
    requiredVersion: version,
    packageInfo: packgaeInfo,
    lastGame: lastGame,
    gameList: allGameList,
  );
});

class MainApp extends HookConsumerWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainInfo = ref.watch(mainInfoProvider(context));
    final lightThemeData = ref.watch(lightThemeDataProvider(context));
    final darkThemeData = ref.watch(darkThemeDataProvider(context));

    useEffect(() {
      ref.read(databaseVersionNotifierProvider.notifier).updateDatabaseVersion(2);
      ref.read(userActivityLogNotifierProvider.notifier).login();
      return null;
    }, const []);

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
      home: mainInfo.when(
        data: (mainInfo) => MainAppHome(mainInfo: mainInfo),
        error: (error, stack) => Text('$error'),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

final combinedShareCountFutureProvider = FutureProvider.autoDispose<List<int>>((ref) async {
  ref.keepAlive();
  final hostCount = await ref.watch(hostShareCountProvider.future);
  final guestCount = await ref.watch(guestShareCountProvider.future);
  ref.read(combinedShareCountProvider.notifier).state = [hostCount, guestCount];
  ref.read(revenueCatNotifierProvider);
  return [hostCount, guestCount];
});

final combinedShareCountProvider = StateProvider<List<int>>((ref) => [0, 0]);

class MainAppHome extends HookConsumerWidget {
  const MainAppHome({
    required this.mainInfo,
    super.key,
  });

  final MainInfo mainInfo;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(firebaseAuthNotifierProvider.select((value) => value.user));
    if (user != null) ref.read(userInfoSettingsProvider);

    final versionIsOk = Version.parse(mainInfo.requiredVersion) <= Version.parse(mainInfo.packageInfo.version);
    if (!versionIsOk) return const UpdaterView();

    if (user == null) return const LoginView();

    final isInitialGame = ref.watch(selectGameNotifierProvider.select((value) => value.selectGame != null));
    if (!isInitialGame) {
      if (mainInfo.lastGame != null) {
        // ビルドメソッド終了後に呼ばれる
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(selectGameNotifierProvider.notifier).setSelectGame(mainInfo.lastGame!);
        });
      } else {
        return const InitialGameRegistrationView();
      }
    }

    useEffect(() {
      ref.read(rewardAdStateNotifierProvider.notifier).loadRewardedAd();
      return null;
    }, const []);

    final revenueCatProvider = ref.watch(revenueCatNotifierProvider);
    final shareCount = ref.watch(combinedShareCountFutureProvider);
    return revenueCatProvider.maybeWhen(
      data: (revenuecat) {
        final hasUnlinkedGame = mainInfo.gameList.any((game) => game.publicGameId == null);
        if (hasUnlinkedGame) return const GameLinkingView();
        if (!ref.read(userActivityLogNotifierProvider).isPublicDataUploaded) {
          _publicDataUpload(ref);
        }
        if (!revenuecat.isPremium) {
          return shareCount.maybeWhen(
            data: (data) {
              final hostCount = data[0];
              final guestCount = data[1];
              if (hostCount > 1) return SelectSharedHostGameScreen(mainInfo: mainInfo);
              if (guestCount > 2) return SelectSharedGuestGameScreen(mainInfo: mainInfo);
              return const BottomNavigationView();
            },
            orElse: () => const Center(child: CircularProgressIndicator()),
          );
        }
        return const BottomNavigationView();
      },
      orElse: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Future _publicDataUpload(WidgetRef ref) async {
    final gameList = await ref.read(allGameListProvider.future);
    final deckList = await ref.read(allDeckListProvider.future);
    final tagList = await ref.read(allTagListProvider.future);
    final recordList = await ref.read(allRecordListProvider.future);
    await ref.read(firestorePublicUserDataRepository).addGameList(gameList, ref.read(firebaseAuthNotifierProvider).user!.uid);
    await ref.read(firestorePublicUserDataRepository).addDeckList(deckList, ref.read(firebaseAuthNotifierProvider).user!.uid);
    await ref.read(firestorePublicUserDataRepository).addTagList(tagList, ref.read(firebaseAuthNotifierProvider).user!.uid);
    await ref.read(firestorePublicUserDataRepository).addRecordList(recordList, ref.read(firebaseAuthNotifierProvider).user!.uid);
    ref.read(userActivityLogNotifierProvider.notifier).publicDataUploaded();
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
