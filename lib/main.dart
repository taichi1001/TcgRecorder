import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/view/bottom_navigation_view.dart';

void main() {
  runApp(
    const ProviderScope(
      child: BottomNavigationView(),
    ),
  );
}
