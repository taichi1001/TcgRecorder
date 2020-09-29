import 'package:flutter/material.dart';
import 'package:tcg_recorder/ui/data_list_screen.dart';
import 'package:tcg_recorder/ui/input_screen.dart';
// import 'package:tcg_recorder/ui/setting_screen.dart';

class BottomNavigationModel with ChangeNotifier {
  final List<Widget> options = [
    const InputScreen(),
    const DataListScreen(),
    // const SettingScreen(),
  ];

  int selectedIndex = 0;

  void change(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Widget getSelectedScreen() => options[selectedIndex];
}
