import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/model/bottom_navigation_model.dart';
import 'package:tcg_recorder/model/record_model.dart';
import 'package:tcg_recorder/model/manage_db_model.dart';
import 'package:tcg_recorder/model/tag_model.dart';
import 'package:tcg_recorder/ui/main_bottom_navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavigationModel>(
          create: (context) => BottomNavigationModel(),
        ),
        ChangeNotifierProvider<RecordModel>(
          create: (context) => RecordModel(),
        ),
        ChangeNotifierProvider<ManageDBModel>(
          create: (context) => ManageDBModel(),
        ),
        ChangeNotifierProvider<TagModel>(
          create: (context) => TagModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Todo App Sample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainBottomNavigation(),
      ),
    );
  }
}
