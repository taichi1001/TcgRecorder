import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/entity/record.dart';
import 'package:tcg_recorder2/provider/record_list_provider.dart';
import 'package:tcg_recorder2/provider/select_game_provider.dart';
import 'package:tcg_recorder2/state/game_record_list_state.dart';

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
    return state.gameRecordList!.where((record) => record.firstSecond == true).length;
  }

  int countGameSecondMatches() {
    return state.gameRecordList!.where((record) => record.firstSecond == false).length;
  }

  int countGameWins() {
    return state.gameRecordList!.where((record) => record.winLoss == true).length;
  }

  int countGameLoss() {
    return state.gameRecordList!.where((record) => record.winLoss == false).length;
  }

  double calcGameWinRate() {
    final win = countGameWins();
    final matches = countGameMatches();
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  double calcGameWinRateOfFirst() {
    final firstRecord = state.gameRecordList!.where((record) => record.firstSecond == true).toList();
    final win = firstRecord.where((record) => record.winLoss == true).length;
    final matches = countGameFirstMatches();
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  double calcGameWinRateOfSecond() {
    final firstRecord = state.gameRecordList!.where((record) => record.firstSecond == false).toList();
    final win = firstRecord.where((record) => record.winLoss == true).length;
    final matches = countGameSecondMatches();
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }
}

final gameRecordListNotifierProvider = StateNotifierProvider<GameRecordListNotifier, GameRecordListState>((ref) {
  final selectGame = ref.watch(selectGameNotifierProvider).selectGame;
  final allRecordList = ref.watch(allRecordListNotifierProvider).allRecordList;
  final gameRecordList = allRecordList!.where((record) => record.gameId! == selectGame!.gameId).toList();
  final notifier = GameRecordListNotifier(ref.read);
  notifier.setGameRecordList(gameRecordList);
  return notifier;
});
