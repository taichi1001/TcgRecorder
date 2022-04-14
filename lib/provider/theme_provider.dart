import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcg_manager/state/theme_state.dart';

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier(this.read) : super(ThemeState());

  final Reader read;
  static const themePrefsKey = 'selectedTheme';

  Future themeInitialize() async {
    final themeName = await _getTheme();
    if (themeName == null) return;
    state = state.copyWith(
      scheme: FlexScheme.values.byName(themeName),
      previewScheme: FlexScheme.values.byName(themeName),
    );
  }

  void changePreview(FlexScheme scheme) {
    state = state.copyWith(previewScheme: scheme);
  }

  Future changeTheme() async {
    await _save(state.previewScheme);
    state = state.copyWith(scheme: state.previewScheme);
  }

  Future<String?> _getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(themePrefsKey);
  }

  Future _save(FlexScheme scheme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(themePrefsKey, scheme.name);
  }
}

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, ThemeState>(
  (ref) => ThemeNotifier(ref.read),
);
