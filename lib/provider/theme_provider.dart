import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/main.dart';
import 'package:tcg_manager/state/theme_state.dart';

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier(this.read) : super(ThemeState()) {
    _init();
  }

  final Reader read;
  static const themePrefsKey = 'selectedTheme';

  late final prefs = read(sharedPreferencesProvider);

  void _init() {
    final themeName = _getTheme();
    if (themeName == null) return;
    state = state.copyWith(
      scheme: FlexScheme.values.byName(themeName),
      previewScheme: FlexScheme.values.byName(themeName),
    );
  }

  void changePreview(FlexScheme scheme) {
    state = state.copyWith(previewScheme: scheme);
  }

  void changeTheme() {
    _save(state.previewScheme);
    state = state.copyWith(scheme: state.previewScheme);
  }

  String? _getTheme() => prefs.getString(themePrefsKey);

  void _save(FlexScheme scheme) => prefs.setString(themePrefsKey, scheme.name);
}

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, ThemeState>(
  (ref) => ThemeNotifier(ref.read),
);
