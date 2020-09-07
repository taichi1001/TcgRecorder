import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:tcg_recorder/model/bottom_navigation_model.dart';
import 'package:tcg_recorder/model/deck_model.dart';
import 'package:tcg_recorder/model/game_model.dart';
import 'package:tcg_recorder/model/tag_model.dart';
import 'package:tcg_recorder/model/record_model.dart';
import 'package:tcg_recorder/model/text_editing_controller_model.dart';
import 'package:tcg_recorder/ui/main_bottom_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  SyncfusionLicense.registerLicense(
      'NT8mJyc2IWhia31hfWN9ZmZoYmF8YGJ8ampqanNiYmlmamlmanMDHmgnfSAyIDI4OmJkaxM0PjI6P30wPD4=');
  return runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<BottomNavigationModel>(
            create: (context) => BottomNavigationModel(),
          ),
          ChangeNotifierProvider<GameModel>(
            create: (context) => GameModel(),
          ),
          ChangeNotifierProvider<TagModel>(
            create: (context) => TagModel(),
          ),
          ChangeNotifierProvider<DeckModel>(
            create: (context) => DeckModel(),
          ),
          ChangeNotifierProvider<RecordModel>(
            create: (context) => RecordModel(),
          ),
          ChangeNotifierProvider<TextEditingControllerModel>(
            create: (context) => TextEditingControllerModel(),
          ),
        ],
        child: MaterialApp(
          title: 'Todo App Sample',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MainBottomNavigation(),
        ),
      );
}
