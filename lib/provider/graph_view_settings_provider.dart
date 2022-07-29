import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcg_manager/state/graph_view_settings_state.dart';

class GraphViewSettingsNotifier extends StateNotifier<GraphViewSettingsState> {
  GraphViewSettingsNotifier(this.read) : super(GraphViewSettingsState());

  final Reader read;
  static const matchesKey = 'matches';
  static const firstMatchesKey = 'firstMatches';
  static const secondMatchesKey = 'secondMatches';
  static const winKey = 'win';
  static const lossKey = 'loss';
  static const winRateKey = 'winRate';
  static const firstWinRateKey = 'firstWinRate';
  static const secondWinRateKey = 'secondWinRate';

  Future settingsInitialize() async {
    final matches = await _getMatches();
    final firstMatches = await _getFirstMatches();
    final secondMatches = await _getSecondMatches();
    final win = await _getWin();
    final loss = await _getLoss();
    final winRate = await _getWinRate();
    final firstWinRate = await _getFirstWinRate();
    final secondWinRate = await _getSecondWinRate();
    if (matches == null ||
        firstMatches == null ||
        secondMatches == null ||
        win == null ||
        loss == null ||
        winRate == null ||
        firstWinRate == null ||
        secondWinRate == null) return;
    state = state.copyWith(
      matches: matches,
      firstMatches: firstMatches,
      secondMatches: secondMatches,
      win: win,
      loss: loss,
      winRate: winRate,
      firstWinRate: firstWinRate,
      secondWinRate: secondWinRate,
    );
  }

  Future changeMatches(bool settings) async {
    state = state.copyWith(matches: settings);
    await _saveMatches(state.matches);
  }

  Future<bool?> _getMatches() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(matchesKey);
  }

  Future _saveMatches(bool settings) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(matchesKey, settings);
  }

  Future changeFirstMatches(bool settings) async {
    state = state.copyWith(firstMatches: settings);
    await _saveFirstMatches(state.firstMatches);
  }

  Future<bool?> _getFirstMatches() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(firstMatchesKey);
  }

  Future _saveFirstMatches(bool settings) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(firstMatchesKey, settings);
  }

  Future changeSecondMatches(bool settings) async {
    state = state.copyWith(secondMatches: settings);
    await _saveSecondMatches(state.secondMatches);
  }

  Future<bool?> _getSecondMatches() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(secondMatchesKey);
  }

  Future _saveSecondMatches(bool settings) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(secondMatchesKey, settings);
  }

  Future changeWin(bool settings) async {
    state = state.copyWith(win: settings);
    await _saveWin(state.win);
  }

  Future<bool?> _getWin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(winKey);
  }

  Future _saveWin(bool settings) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(winKey, settings);
  }

  Future changeLoss(bool settings) async {
    state = state.copyWith(loss: settings);
    await _saveLoss(state.loss);
  }

  Future<bool?> _getLoss() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(lossKey);
  }

  Future _saveLoss(bool settings) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(lossKey, settings);
  }

  Future changeWinRate(bool settings) async {
    state = state.copyWith(winRate: settings);
    await _saveWinRate(state.winRate);
  }

  Future<bool?> _getWinRate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(winRateKey);
  }

  Future _saveWinRate(bool settings) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(winRateKey, settings);
  }

  Future changeFirstWinRate(bool settings) async {
    state = state.copyWith(firstWinRate: settings);
    await _saveFirstWinRate(state.firstWinRate);
  }

  Future<bool?> _getFirstWinRate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(firstWinRateKey);
  }

  Future _saveFirstWinRate(bool settings) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(firstWinRateKey, settings);
  }

  Future changeSecondWinRate(bool settings) async {
    state = state.copyWith(secondWinRate: settings);
    await _saveSecondWinRate(state.secondWinRate);
  }

  Future<bool?> _getSecondWinRate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(secondWinRateKey);
  }

  Future _saveSecondWinRate(bool settings) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(secondWinRateKey, settings);
  }
}

final graphViewSettingsNotifierProvider = StateNotifierProvider<GraphViewSettingsNotifier, GraphViewSettingsState>(
  (ref) => GraphViewSettingsNotifier(ref.read),
);
