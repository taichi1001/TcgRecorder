import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcg_manager/state/input_view_settings_state.dart';

class InputViewSettingsNotifier extends StateNotifier<InputViewSettingsState> {
  InputViewSettingsNotifier(this.read) : super(InputViewSettingsState());

  final Reader read;
  static const fixUseDeckKey = 'fixUseDeck';
  static const fixOpponentDeckKey = 'fixOpponentDeck';
  static const fixTagKey = 'fixTag';

  Future settingsInitialize() async {
    final fixUseDeck = await _getFixUseDeck();
    final fixOpponentDeck = await _getFixOpponentDeck();
    final fixTag = await _getFixTag();
    state = state.copyWith(
      fixUseDeck: fixUseDeck ?? false,
      fixOpponentDeck: fixOpponentDeck ?? false,
      fixTag: fixTag ?? false,
    );
  }

  Future changeFixUseDeck(bool settings) async {
    state = state.copyWith(fixUseDeck: settings);
    await _saveFixUseDeck(state.fixUseDeck);
  }

  Future changeFixOpponentDeck(bool settings) async {
    state = state.copyWith(fixOpponentDeck: settings);
    await _saveFixOpponentDeck(state.fixOpponentDeck);
  }

  Future changeFixTag(bool settings) async {
    state = state.copyWith(fixTag: settings);
    await _saveFixTag(state.fixTag);
  }

  Future<bool?> _getFixUseDeck() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(fixUseDeckKey);
  }

  Future<bool?> _getFixOpponentDeck() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(fixOpponentDeckKey);
  }

  Future<bool?> _getFixTag() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(fixTagKey);
  }

  Future _saveFixUseDeck(bool settings) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(fixUseDeckKey, settings);
  }

  Future _saveFixOpponentDeck(bool settings) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(fixOpponentDeckKey, settings);
  }

  Future _saveFixTag(bool settings) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(fixTagKey, settings);
  }
}

final inputViewSettingsNotifierProvider = StateNotifierProvider<InputViewSettingsNotifier, InputViewSettingsState>(
  (ref) => InputViewSettingsNotifier(ref.read),
);
