import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/entity/deck.dart';
import 'package:tcg_recorder2/provider/select_game_provider.dart';
import 'package:tcg_recorder2/repository/record_repository.dart';
import 'package:tcg_recorder2/selector/game_record_list_selector.dart';
import 'package:tcg_recorder2/state/record_list_state.dart';

class RecordListNotifier extends StateNotifier<RecordListState> {
  RecordListNotifier(this.read) : super(RecordListState());

  final Reader read;

  Future fetch() async {
    final recordList = await read(recordRepository).getAll();
    state = state.copyWith(allRecordList: recordList);
  }

  int countGameMatches() {
    final allRecordList = state.allRecordList;
    final selectedGame = read(selectGameNotifierProvider).selectGame;
    return allRecordList!.where((record) => record.gameId == selectedGame!.gameId).length;
  }

  int countDeckMatches(Deck deck) {
    if (state.allRecordList != null) {
      return state.allRecordList!.where((record) => record.useDeckId == deck.deckId).length;
    }
    return 0;
  }

  int countGameFirstMatches() {
    final allRecordList = state.allRecordList;
    final selectedGame = read(selectGameNotifierProvider).selectGame;
    final gameRecordList = allRecordList!.where((record) => record.gameId == selectedGame!.gameId).toList();
    return gameRecordList.where((record) => record.firstSecond == true).length;
  }

  int countDeckFirstMatches(Deck deck) {
    if (state.allRecordList != null) {
      final recordList = state.allRecordList!.where((record) => record.useDeckId == deck.deckId).toList();
      final firstRecords = recordList.where((record) => record.firstSecond == true).toList();
      return firstRecords.where((record) => record.useDeckId == deck.deckId).length;
    }
    return 0;
  }

  int countGameSecondMatches() {
    final allRecordList = state.allRecordList;
    final selectedGame = read(selectGameNotifierProvider).selectGame;
    final gameRecordList = allRecordList!.where((record) => record.gameId == selectedGame!.gameId).toList();
    return gameRecordList.where((record) => record.firstSecond == false).length;
  }

  int countDeckSecondMatches(Deck deck) {
    if (state.allRecordList != null) {
      final recordList = state.allRecordList!.where((record) => record.useDeckId == deck.deckId).toList();
      final secondRecords = recordList.where((record) => record.firstSecond == false).toList();
      return secondRecords.where((record) => record.useDeckId == deck.deckId).length;
    }
    return 0;
  }

  int countGameWins() {
    final allRecordList = state.allRecordList;
    final selectedGame = read(selectGameNotifierProvider).selectGame;
    final selectedGameRecord = allRecordList!.where((record) => record.gameId == selectedGame!.gameId);
    return selectedGameRecord.where((record) => record.winLoss == true).length;
    // return read(gameRecordListProvider).where((record) => record.winLoss == true).length;
  }

  int countDeckWins(Deck deck) {
    if (state.allRecordList != null) {
      final recordList = state.allRecordList!.where((record) => record.useDeckId == deck.deckId).toList();
      return recordList.where((record) => record.winLoss == true).length;
    }
    return 0;
  }

  int countGameLoss() {
    final allRecordList = state.allRecordList;
    final selectedGame = read(selectGameNotifierProvider).selectGame;
    final selectedGameRecord = allRecordList!.where((record) => record.gameId == selectedGame!.gameId);
    return selectedGameRecord.where((record) => record.winLoss == false).length;
    // return read(gameRecordListProvider).where((record) => record.winLoss == false).length;
  }

  int countDeckLoss(Deck deck) {
    if (state.allRecordList != null) {
      final recordList = state.allRecordList!.where((record) => record.useDeckId == deck.deckId).toList();
      return recordList.where((record) => record.winLoss == false).length;
    }
    return 0;
  }

  double calcGameWinRate() {
    final win = countGameWins();
    final matches = countGameMatches();
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  double calcDeckWinRate(Deck deck) {
    if (state.allRecordList != null) {
      final win = countDeckWins(deck);
      final matches = countDeckMatches(deck);
      return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
    }
    return 0;
  }

  double calcGameWinRateOfFirst() {
    final allRecordList = state.allRecordList;
    final selectedGame = read(selectGameNotifierProvider).selectGame;
    final selectedGameRecord = allRecordList!.where((record) => record.gameId == selectedGame!.gameId);
    final firstRecord = selectedGameRecord.where((record) => record.firstSecond == true).toList();
    final win = firstRecord.where((record) => record.winLoss == true).length;
    final matches = countGameFirstMatches();
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  double calcDeckWinRateOfFirst(Deck deck) {
    if (state.allRecordList != null) {
      final recordList = state.allRecordList!.where((record) => record.useDeckId == deck.deckId).toList();
      final firstRecords = recordList.where((record) => record.firstSecond == true).toList();
      final win = firstRecords.where((record) => record.winLoss == true).length;
      final matches = countDeckFirstMatches(deck);
      return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
    }
    return 0;
  }

  double calcGameWinRateOfSecond() {
    final allRecordList = state.allRecordList;
    final selectedGame = read(selectGameNotifierProvider).selectGame;
    final selectedGameRecord = allRecordList!.where((record) => record.gameId == selectedGame!.gameId);
    final firstRecord = selectedGameRecord.where((record) => record.firstSecond == false).toList();
    final win = firstRecord.where((record) => record.winLoss == true).length;
    final matches = countGameSecondMatches();
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  double calcDeckWinRateOfSecond(Deck deck) {
    if (state.allRecordList != null) {
      final recordList = state.allRecordList!.where((record) => record.useDeckId == deck.deckId).toList();
      final secondRecords = recordList.where((record) => record.firstSecond == false).toList();
      final win = secondRecords.where((record) => record.winLoss == true).length;
      final matches = countDeckSecondMatches(deck);
      return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
    }
    return 0;
  }
}

final allRecordListNotifierProvider = StateNotifierProvider<RecordListNotifier, RecordListState>(
  (ref) => RecordListNotifier(ref.read),
);
