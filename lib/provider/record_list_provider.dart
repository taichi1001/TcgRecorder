import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/entity/deck.dart';
import 'package:tcg_recorder2/repository/record_repository.dart';
import 'package:tcg_recorder2/state/record_list_state.dart';

class RecordListNotifier extends StateNotifier<RecordListState> {
  RecordListNotifier(this.read) : super(RecordListState());

  final Reader read;

  Future fetch() async {
    final recordList = await read(recordRepository).getAll();
    state = state.copyWith(allRecordList: recordList);
  }

  int countDeckMatches(Deck deck) {
    if (state.allRecordList != null) {
      return state.allRecordList!.where((record) => record.useDeckId == deck.deckId).length;
    }
    return 0;
  }

  int countDeckFirstMatches(Deck deck) {
    if (state.allRecordList != null) {
      final recordList = state.allRecordList!.where((record) => record.useDeckId == deck.deckId).toList();
      final firstRecords = recordList.where((record) => record.firstSecond == true).toList();
      return firstRecords.where((record) => record.useDeckId == deck.deckId).length;
    }
    return 0;
  }

  int countDeckSecondMatches(Deck deck) {
    if (state.allRecordList != null) {
      final recordList = state.allRecordList!.where((record) => record.useDeckId == deck.deckId).toList();
      final secondRecords = recordList.where((record) => record.firstSecond == false).toList();
      return secondRecords.where((record) => record.useDeckId == deck.deckId).length;
    }
    return 0;
  }

  int countDeckWins(Deck deck) {
    if (state.allRecordList != null) {
      final recordList = state.allRecordList!.where((record) => record.useDeckId == deck.deckId).toList();
      return recordList.where((record) => record.winLoss == true).length;
    }
    return 0;
  }

  int countDeckLoss(Deck deck) {
    if (state.allRecordList != null) {
      final recordList = state.allRecordList!.where((record) => record.useDeckId == deck.deckId).toList();
      return recordList.where((record) => record.winLoss == false).length;
    }
    return 0;
  }

  double calcDeckWinRate(Deck deck) {
    if (state.allRecordList != null) {
      final win = countDeckWins(deck);
      final matches = countDeckMatches(deck);
      return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
    }
    return 0;
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
