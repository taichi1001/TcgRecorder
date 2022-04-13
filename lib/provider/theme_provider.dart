import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/state/theme_state.dart';

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier(this.read) : super(ThemeState());

  final Reader read;

  void changeTheme(FlexScheme scheme) {
    state = state.copyWith(scheme: scheme);
  }
}

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, ThemeState>(
  (ref) => ThemeNotifier(ref.read),
);
