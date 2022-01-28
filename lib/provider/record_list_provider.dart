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

  int countMatches(Deck deck) {
    if (state.allRecordList != null) {
      return state.allRecordList!.where((record) => record.useDeckId == deck.deckId).length;
    }
    return 0;
  }

  int countFirstMatches(Deck deck) {
    if (state.allRecordList != null) {
      final recordList =
          state.allRecordList!.where((record) => record.useDeckId == deck.deckId).toList();
      final firstRecords = recordList.where((record) => record.firstSecond == true).toList();
      return firstRecords.where((record) => record.useDeckId == deck.deckId).length;
    }
    return 0;
  }

  int countSecondMatches(Deck deck) {
    if (state.allRecordList != null) {
      final recordList =
          state.allRecordList!.where((record) => record.useDeckId == deck.deckId).toList();
      final secondRecords = recordList.where((record) => record.firstSecond == false).toList();
      return secondRecords.where((record) => record.useDeckId == deck.deckId).length;
    }
    return 0;
  }

  int countWins(Deck deck) {
    if (state.allRecordList != null) {
      final recordList =
          state.allRecordList!.where((record) => record.useDeckId == deck.deckId).toList();
      return recordList.where((record) => record.winLoss == true).length;
    }
    return 0;
  }

  int countLoss(Deck deck) {
    if (state.allRecordList != null) {
      final recordList =
          state.allRecordList!.where((record) => record.useDeckId == deck.deckId).toList();
      return recordList.where((record) => record.winLoss == false).length;
    }
    return 0;
  }

  double calcWinRate(Deck deck) {
    if (state.allRecordList != null) {
      final win = countWins(deck);
      final matches = countMatches(deck);
      return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
    }
    return 0;
  }

  double calcWinRateOfFirst(Deck deck) {
    if (state.allRecordList != null) {
      final recordList =
          state.allRecordList!.where((record) => record.useDeckId == deck.deckId).toList();
      final firstRecords = recordList.where((record) => record.firstSecond == true).toList();
      final win = firstRecords.where((record) => record.winLoss == true).length;
      final matches = countFirstMatches(deck);
      return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
    }
    return 0;
  }

  double calcWinRateOfSecond(Deck deck) {
    if (state.allRecordList != null) {
      final recordList =
          state.allRecordList!.where((record) => record.useDeckId == deck.deckId).toList();
      final secondRecords = recordList.where((record) => record.firstSecond == false).toList();
      final win = secondRecords.where((record) => record.winLoss == true).length;
      final matches = countSecondMatches(deck);
      return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
    }
    return 0;
  }
}

final allRecordListNotifierProvider = StateNotifierProvider<RecordListNotifier, RecordListState>(
  (ref) => RecordListNotifier(ref.read),
);
