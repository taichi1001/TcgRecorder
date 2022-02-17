import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/selector/sorted_record_list_selector.dart';
import 'package:tcg_manager/state/game_record_list_state.dart';
import 'package:tcg_manager/state/input_view_state.dart';

class GameRecordListNotifier extends StateNotifier<GameRecordListState> {
  GameRecordListNotifier(this.read) : super(GameRecordListState());
  final Reader read;

  void setGameRecordList(List<Record> list) {
    state = state.copyWith(gameRecordList: list);
  }

  int countGameMatches() {
    return state.gameRecordList!.length;
  }

  int countGameFirstMatches() {
    return state.gameRecordList!.where((record) => record.firstSecond == FirstSecond.first).length;
  }

  int countGameSecondMatches() {
    return state.gameRecordList!.where((record) => record.firstSecond == FirstSecond.second).length;
  }

  int countGameWins() {
    return state.gameRecordList!.where((record) => record.winLoss == WinLoss.win).length;
  }

  int countGameLoss() {
    return state.gameRecordList!.where((record) => record.winLoss == WinLoss.loss).length;
  }

  double calcGameWinRate() {
    final win = countGameWins();
    final matches = countGameMatches();
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  double calcGameWinRateOfFirst() {
    final firstRecord = state.gameRecordList!.where((record) => record.firstSecond == FirstSecond.first).toList();
    final win = firstRecord.where((record) => record.winLoss == WinLoss.win).length;
    final matches = countGameFirstMatches();
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  double calcGameWinRateOfSecond() {
    final firstRecord = state.gameRecordList!.where((record) => record.firstSecond == FirstSecond.second).toList();
    final win = firstRecord.where((record) => record.winLoss == WinLoss.win).length;
    final matches = countGameSecondMatches();
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }
}

final gameRecordListNotifierProvider = StateNotifierProvider<GameRecordListNotifier, GameRecordListState>((ref) {
  final selectGame = ref.watch(selectGameNotifierProvider).selectGame;
  final sortedRecordList = ref.watch(sortedRecordListProvider);
  final gameRecordList = sortedRecordList.where((record) => record.gameId! == selectGame!.gameId).toList();
  final notifier = GameRecordListNotifier(ref.read);
  notifier.setGameRecordList(gameRecordList);
  return notifier;
});
