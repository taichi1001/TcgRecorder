import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/main.dart';
import 'package:tcg_manager/state/graph_view_settings_state.dart';

class GraphViewSettingsNotifier extends StateNotifier<GraphViewSettingsState> {
  GraphViewSettingsNotifier(this.ref) : super(GraphViewSettingsState()) {
    _init();
  }

  final Ref ref;
  static const matchesKey = 'matches';
  static const firstMatchesKey = 'firstMatches';
  static const secondMatchesKey = 'secondMatches';
  static const winKey = 'win';
  static const firstMatchesWinKey = 'firstMatchesWin';
  static const secondMatchesWinKey = 'secondMatchesWin';
  static const lossKey = 'loss';
  static const firstMatchesLossKey = 'firstMatchesLoss';
  static const secondMatchesLossKey = 'secondMatchesLoss';
  static const drawKey = 'draw';
  static const firstMatchesDrawKey = 'firstMatchesDraw';
  static const secondMatchesDrawKey = 'secondMatchesDraw';
  static const winRateKey = 'winRate';
  static const firstWinRateKey = 'firstWinRate';
  static const secondWinRateKey = 'secondWinRate';

  late final prefs = ref.read(sharedPreferencesProvider);

  void _init() {
    state = state.copyWith(
      matches: _getMatches() ?? true,
      firstMatches: _getFirstMatches() ?? true,
      secondMatches: _getSecondMatches() ?? true,
      win: _getWin() ?? true,
      firstMatchesWin: _getFirstMatchesWin() ?? true,
      secondMatchesWin: _getSecondMatchesWin() ?? true,
      loss: _getLoss() ?? true,
      firstMatchesLoss: _getFirstMatchesLoss() ?? true,
      secondMatchesLoss: _getSecondMatchesLoss() ?? true,
      draw: _getDraw() ?? true,
      firstMatchesDraw: _getFirstMatchesDraw() ?? true,
      secondMatchesDraw: _getSecondMatchesDraw() ?? true,
      winRate: _getWinRate() ?? true,
      firstWinRate: _getFirstWinRate() ?? true,
      secondWinRate: _getSecondWinRate() ?? true,
    );
  }

  bool? _getMatches() => prefs.getBool(matchesKey);
  bool? _getFirstMatches() => prefs.getBool(firstMatchesKey);
  bool? _getSecondMatches() => prefs.getBool(secondMatchesKey);
  bool? _getWin() => prefs.getBool(winKey);
  bool? _getFirstMatchesWin() => prefs.getBool(firstMatchesWinKey);
  bool? _getSecondMatchesWin() => prefs.getBool(secondMatchesWinKey);
  bool? _getLoss() => prefs.getBool(lossKey);
  bool? _getFirstMatchesLoss() => prefs.getBool(firstMatchesLossKey);
  bool? _getSecondMatchesLoss() => prefs.getBool(secondMatchesLossKey);
  bool? _getDraw() => prefs.getBool(drawKey);
  bool? _getFirstMatchesDraw() => prefs.getBool(firstMatchesDrawKey);
  bool? _getSecondMatchesDraw() => prefs.getBool(secondMatchesDrawKey);
  bool? _getWinRate() => prefs.getBool(winRateKey);
  bool? _getFirstWinRate() => prefs.getBool(firstWinRateKey);
  bool? _getSecondWinRate() => prefs.getBool(secondWinRateKey);

  void _saveMatches(bool settings) => prefs.setBool(matchesKey, settings);
  void _saveFirstMatches(bool settings) => prefs.setBool(firstMatchesKey, settings);
  void _saveSecondMatches(bool settings) => prefs.setBool(secondMatchesKey, settings);
  void _saveWin(bool settings) => prefs.setBool(winKey, settings);
  void _saveFirstMatchesWin(bool settings) => prefs.setBool(firstMatchesWinKey, settings);
  void _saveSecondMatchesWin(bool settings) => prefs.setBool(secondMatchesWinKey, settings);
  void _saveLoss(bool settings) => prefs.setBool(lossKey, settings);
  void _saveFirstMatchesLoss(bool settings) => prefs.setBool(firstMatchesLossKey, settings);
  void _saveSecondMatchesLoss(bool settings) => prefs.setBool(secondMatchesLossKey, settings);
  void _saveDraw(bool settings) => prefs.setBool(drawKey, settings);
  void _saveFirstMatchesDraw(bool settings) => prefs.setBool(firstMatchesDrawKey, settings);
  void _saveSecondMatchesDraw(bool settings) => prefs.setBool(secondMatchesDrawKey, settings);
  void _saveWinRate(bool settings) => prefs.setBool(winRateKey, settings);
  void _saveFirstWinRate(bool settings) => prefs.setBool(firstWinRateKey, settings);
  void _saveSecondWinRate(bool settings) => prefs.setBool(secondWinRateKey, settings);

  void changeMatches(bool settings) {
    state = state.copyWith(matches: settings);
    _saveMatches(state.matches);
  }

  void changeFirstMatches(bool settings) {
    state = state.copyWith(firstMatches: settings);
    _saveFirstMatches(state.firstMatches);
  }

  void changeSecondMatches(bool settings) {
    state = state.copyWith(secondMatches: settings);
    _saveSecondMatches(state.secondMatches);
  }

  void changeWin(bool settings) {
    state = state.copyWith(win: settings);
    _saveWin(state.win);
  }

  void changeFirstMatchesWin(bool settings) {
    state = state.copyWith(firstMatchesWin: settings);
    _saveFirstMatchesWin(state.firstMatchesWin);
  }

  void changeSecondMatchesWin(bool settings) {
    state = state.copyWith(secondMatchesWin: settings);
    _saveSecondMatchesWin(state.secondMatchesWin);
  }

  void changeLoss(bool settings) {
    state = state.copyWith(loss: settings);
    _saveLoss(state.loss);
  }

  void changeFirstMatchesLoss(bool settings) {
    state = state.copyWith(firstMatchesLoss: settings);
    _saveFirstMatchesLoss(state.firstMatchesLoss);
  }

  void changeSecondMatchesLoss(bool settings) {
    state = state.copyWith(secondMatchesLoss: settings);
    _saveSecondMatchesLoss(state.secondMatchesLoss);
  }

  void changeDraw(bool settings) {
    state = state.copyWith(draw: settings);
    _saveDraw(state.draw);
  }

  void changeFirstMatchesDraw(bool settings) {
    state = state.copyWith(firstMatchesDraw: settings);
    _saveFirstMatchesDraw(state.firstMatchesDraw);
  }

  void changeSecondMatchesDraw(bool settings) {
    state = state.copyWith(secondMatchesDraw: settings);
    _saveSecondMatchesDraw(state.secondMatchesDraw);
  }

  void changeWinRate(bool settings) {
    state = state.copyWith(winRate: settings);
    _saveWinRate(state.winRate);
  }

  void changeFirstWinRate(bool settings) {
    state = state.copyWith(firstWinRate: settings);
    _saveFirstWinRate(state.firstWinRate);
  }

  void changeSecondWinRate(bool settings) {
    state = state.copyWith(secondWinRate: settings);
    _saveSecondWinRate(state.secondWinRate);
  }
}

final graphViewSettingsNotifierProvider = StateNotifierProvider<GraphViewSettingsNotifier, GraphViewSettingsState>(
  (ref) => GraphViewSettingsNotifier(ref),
);
