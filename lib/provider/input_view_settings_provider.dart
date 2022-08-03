import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/main.dart';
import 'package:tcg_manager/state/input_view_settings_state.dart';

class InputViewSettingsNotifier extends StateNotifier<InputViewSettingsState> {
  InputViewSettingsNotifier(this.read) : super(InputViewSettingsState()) {
    _init();
  }

  final Reader read;
  static const fixUseDeckKey = 'fixUseDeck';
  static const fixOpponentDeckKey = 'fixOpponentDeck';
  static const fixTagKey = 'fixTag';

  late final prefs = read(sharedPreferencesProvider);

  void _init() {
    final fixUseDeck = _getFixUseDeck();
    final fixOpponentDeck = _getFixOpponentDeck();
    final fixTag = _getFixTag();
    state = state.copyWith(
      fixUseDeck: fixUseDeck ?? false,
      fixOpponentDeck: fixOpponentDeck ?? false,
      fixTag: fixTag ?? false,
    );
  }

  void changeFixUseDeck(bool settings) {
    state = state.copyWith(fixUseDeck: settings);
    _saveFixUseDeck(state.fixUseDeck);
  }

  void changeFixOpponentDeck(bool settings) {
    state = state.copyWith(fixOpponentDeck: settings);
    _saveFixOpponentDeck(state.fixOpponentDeck);
  }

  void changeFixTag(bool settings) {
    state = state.copyWith(fixTag: settings);
    _saveFixTag(state.fixTag);
  }

  bool? _getFixUseDeck() => prefs.getBool(fixUseDeckKey);
  bool? _getFixOpponentDeck() => prefs.getBool(fixOpponentDeckKey);
  bool? _getFixTag() => prefs.getBool(fixTagKey);

  void _saveFixUseDeck(bool settings) => prefs.setBool(fixUseDeckKey, settings);
  void _saveFixOpponentDeck(bool settings) => prefs.setBool(fixOpponentDeckKey, settings);
  void _saveFixTag(bool settings) => prefs.setBool(fixTagKey, settings);
}

final inputViewSettingsNotifierProvider = StateNotifierProvider<InputViewSettingsNotifier, InputViewSettingsState>(
  (ref) => InputViewSettingsNotifier(ref.read),
);
