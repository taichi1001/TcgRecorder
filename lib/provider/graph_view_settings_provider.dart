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
  static const firstMatchesWinKey = 'firstMatchesWin';
  static const secondMatchesWinKey = 'secondMatchesWin';
  static const lossKey = 'loss';
  static const firstMatchesLossKey = 'firstMatchesLoss';
  static const secondMatchesLossKey = 'secondMatchesLoss';
  static const winRateKey = 'winRate';
  static const firstWinRateKey = 'firstWinRate';
  static const secondWinRateKey = 'secondWinRate';

  Future settingsInitialize() async {
    final matches = await _getMatches();
    final firstMatches = await _getFirstMatches();
    final secondMatches = await _getSecondMatches();
    final win = await _getWin();
    final firstMatchesWin = await _getFirstMatchesWin();
    final secondMatchesWin = await _getSecondMatchesWin();
    final loss = await _getLoss();
    final firstMatchesLoss = await _getFirstMatchesLoss();
    final secondMatchesLoss = await _getSecondMatchesLoss();
    final winRate = await _getWinRate();
    final firstWinRate = await _getFirstWinRate();
    final secondWinRate = await _getSecondWinRate();
    state = state.copyWith(
      matches: matches ?? true,
      firstMatches: firstMatches ?? true,
      secondMatches: secondMatches ?? true,
      win: win ?? true,
      firstMatchesWin: firstMatchesWin ?? true,
      secondMatchesWin: secondMatchesWin ?? true,
      loss: loss ?? true,
      firstMatchesLoss: firstMatchesLoss ?? true,
      secondMatchesLoss: secondMatchesLoss ?? true,
      winRate: winRate ?? true,
      firstWinRate: firstWinRate ?? true,
      secondWinRate: secondWinRate ?? true,
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

  Future changeFirstMatchesWin(bool settings) async {
    state = state.copyWith(firstMatchesWin: settings);
    await _saveFirstMatchesWin(state.firstMatchesWin);
  }

  Future<bool?> _getFirstMatchesWin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(firstMatchesWinKey);
  }

  Future _saveFirstMatchesWin(bool settings) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(firstMatchesWinKey, settings);
  }

  Future changeSecondMatchesWin(bool settings) async {
    state = state.copyWith(secondMatchesWin: settings);
    await _saveSecondMatchesWin(state.secondMatchesWin);
  }

  Future<bool?> _getSecondMatchesWin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(secondMatchesWinKey);
  }

  Future _saveSecondMatchesWin(bool settings) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(secondMatchesWinKey, settings);
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

  Future changeFirstMatchesLoss(bool settings) async {
    state = state.copyWith(firstMatchesLoss: settings);
    await _saveFirstMatchesLoss(state.firstMatchesLoss);
  }

  Future<bool?> _getFirstMatchesLoss() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(firstMatchesLossKey);
  }

  Future _saveFirstMatchesLoss(bool settings) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(firstMatchesLossKey, settings);
  }

  Future changeSecondMatchesLoss(bool settings) async {
    state = state.copyWith(secondMatchesLoss: settings);
    await _saveSecondMatchesLoss(state.secondMatchesLoss);
  }

  Future<bool?> _getSecondMatchesLoss() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(secondMatchesLossKey);
  }

  Future _saveSecondMatchesLoss(bool settings) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(secondMatchesLossKey, settings);
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
