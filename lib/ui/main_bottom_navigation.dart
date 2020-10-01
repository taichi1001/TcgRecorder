import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/model/bottom_navigation_model.dart';
import 'package:tcg_recorder/localization/l10n.dart';

class MainBottomNavigation extends StatelessWidget {
  const MainBottomNavigation({key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bottomNavigationModel = Provider.of<BottomNavigationModel>(context, listen: true);
    return Scaffold(
      body: Center(
        child: bottomNavigationModel.getSelectedScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.input),
            title: Text(L10n.of(context).input),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.pie_chart),
            title: Text(L10n.of(context).data),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomNavigationModel.selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          bottomNavigationModel.change(index);
        },
      ),
    );
  }
}
