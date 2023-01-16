import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/main.dart';
import 'package:tcg_manager/state/input_view_settings_state.dart';

class InputViewSettingsNotifier extends StateNotifier<InputViewSettingsState> {
  InputViewSettingsNotifier(this.ref) : super(InputViewSettingsState()) {
    _init();
  }

  final Ref ref;
  static const fixUseDeckKey = 'fixUseDeck';
  static const fixOpponentDeckKey = 'fixOpponentDeck';
  static const fixTagKey = 'fixTag';
  static const drawKey = 'draw';
  static const bo3Key = 'bo3';

  late final prefs = ref.read(sharedPreferencesProvider);

  void _init() {
    state = state.copyWith(
      fixUseDeck: _getFixUseDeck() ?? false,
      fixOpponentDeck: _getFixOpponentDeck() ?? false,
      fixTag: _getFixTag() ?? false,
      draw: _getDraw() ?? false,
      bo3: _getBO3() ?? false,
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

  void changeDraw(bool settings) {
    state = state.copyWith(draw: settings);
    _saveDraw(state.draw);
  }

  void changeBO3(bool settings) {
    state = state.copyWith(bo3: settings);
    _saveBO3(state.bo3);
  }

  bool? _getFixUseDeck() => prefs.getBool(fixUseDeckKey);
  bool? _getFixOpponentDeck() => prefs.getBool(fixOpponentDeckKey);
  bool? _getFixTag() => prefs.getBool(fixTagKey);
  bool? _getDraw() => prefs.getBool(drawKey);
  bool? _getBO3() => prefs.getBool(bo3Key);

  void _saveFixUseDeck(bool settings) => prefs.setBool(fixUseDeckKey, settings);
  void _saveFixOpponentDeck(bool settings) => prefs.setBool(fixOpponentDeckKey, settings);
  void _saveFixTag(bool settings) => prefs.setBool(fixTagKey, settings);
  void _saveDraw(bool settings) => prefs.setBool(drawKey, settings);
  void _saveBO3(bool settings) => prefs.setBool(bo3Key, settings);
}

final inputViewSettingsNotifierProvider = StateNotifierProvider<InputViewSettingsNotifier, InputViewSettingsState>(
  (ref) => InputViewSettingsNotifier(ref),
);
