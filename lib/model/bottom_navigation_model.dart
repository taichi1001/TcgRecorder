import 'package:flutter/material.dart';
import 'package:tcg_recorder/ui/record_screen.dart';
import 'package:tcg_recorder/ui/manage_db_screen.dart';
import 'package:tcg_recorder/ui/select_graph_screen.dart';

class BottomNavigationModel with ChangeNotifier {
  final List<Widget> options = [
    const RecordScreen(),
    const SelectChartScreen(),
    const ManageDBScreen(),
  ];

  int selectedIndex = 0;

  void change(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Widget getSelectedScreen() {
    return options[selectedIndex];
  }
}
