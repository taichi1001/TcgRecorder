import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/enum/bottom_tab_item.dart';

part 'bottom_navigation_bar_state.freezed.dart';

@freezed
abstract class BottomNavigationBarState with _$BottomNavigationBarState {
  factory BottomNavigationBarState({
    @Default(BottomTabItem.inputScreen) final BottomTabItem viewItem,
  }) = _BottomNavigationBarState;
}
