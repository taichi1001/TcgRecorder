import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/localization/localizations_delegate.dart';
import 'package:tcg_recorder/model/bottom_navigation_model.dart';
import 'package:tcg_recorder/model/deck_model.dart';
import 'package:tcg_recorder/model/game_model.dart';
import 'package:tcg_recorder/model/tag_model.dart';
import 'package:tcg_recorder/model/record_model.dart';
import 'package:tcg_recorder/model/text_editing_controller_model.dart';
import 'package:tcg_recorder/repository/deck_repository.dart';
import 'package:tcg_recorder/repository/game_repository.dart';
import 'package:tcg_recorder/repository/mock/deck_repository_mock.dart';
import 'package:tcg_recorder/repository/record_repository.dart';
import 'package:tcg_recorder/repository/tag_repository.dart';
import 'package:tcg_recorder/ui/main_bottom_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  return runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(1125, 2001),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavigationModel>(
          create: (context) => BottomNavigationModel(),
        ),
        ChangeNotifierProvider<GameModel>(
          create: (context) => GameModel(kIsWeb ? GameRepo() : GameRepo()),
        ),
        ChangeNotifierProvider<TagModel>(
          create: (context) => TagModel(kIsWeb ? TagRepo() : TagRepo()),
        ),
        ChangeNotifierProvider<DeckModel>(
          create: (context) => DeckModel(kIsWeb ? DeckRepoMock() : DeckRepo()),
        ),
        ChangeNotifierProvider<RecordModel>(
          create: (context) => RecordModel(kIsWeb ? RecordRepo() : RecordRepo()),
        ),
        ChangeNotifierProvider<TextEditingControllerModel>(
          create: (context) => TextEditingControllerModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Todo App Sample',
        theme: ThemeData(
          // primarySwatch: Colors.indigo,
          primaryColor: const Color(0xFF5660BB),
          accentColor: Colors.amber,
          canvasColor: const Color(0xFFF0F1FA),
        ),
        localizationsDelegates: const [
          SampleLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('ja', ''),
        ],
        home: const MainBottomNavigation(),
      ),
    );
  }
}
