import 'package:freezed_annotation/freezed_annotation.dart';

part 'bottom_navigation_bar_state.freezed.dart';

enum BottomTabItem { inputScreen, graphScreen, recordScreen }

@freezed
abstract class BottomNavigationBarState with _$BottomNavigationBarState {
  factory BottomNavigationBarState({
    @Default(BottomTabItem.inputScreen) final BottomTabItem viewItem,
  }) = _BottomNavigationBarState;
}
