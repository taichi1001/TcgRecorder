import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/enum/bottom_tab_item.dart';
import 'package:tcg_manager/state/bottom_navigation_bar_state.dart';

class BottomNavigationBarNotifier extends StateNotifier<BottomNavigationBarState> {
  BottomNavigationBarNotifier() : super(BottomNavigationBarState());

  void select(int newIndex) {
    state = state.copyWith(viewItem: BottomTabItem.values[newIndex]);
  }
}

final bottomNavigationBarNotifierProvider = StateNotifierProvider<BottomNavigationBarNotifier, BottomNavigationBarState>(
  (ref) => BottomNavigationBarNotifier(),
);
