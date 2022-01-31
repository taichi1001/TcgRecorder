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

  Future delete(int i) async {
    await read(recordRepository).deleteById(i);
    await fetch();
  }

  int countUseDeckMatches(Deck deck) {
    if (state.allRecordList != null) {
      return state.allRecordList!.where((record) => record.useDeckId == deck.deckId).length;
    }
    return 0;
  }

  int countOpponentDeckMatches(Deck useDeck, Deck opponentDeck) {
    if (state.allRecordList != null) {
      final useDeckRecordList = state.allRecordList!.where((record) => record.useDeckId == useDeck.deckId);
      return useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId).length;
    }
    return 0;
  }

  int countUseDeckFirstMatches(Deck deck) {
    if (state.allRecordList != null) {
      final recordList = state.allRecordList!.where((record) => record.useDeckId == deck.deckId);
      final firstRecords = recordList.where((record) => record.firstSecond == true);
      return firstRecords.where((record) => record.useDeckId == deck.deckId).length;
    }
    return 0;
  }

  int countOpponentDeckFirstMatches(Deck useDeck, Deck opponentDeck) {
    if (state.allRecordList != null) {
      final useDeckRecordList = state.allRecordList!.where((record) => record.useDeckId == useDeck.deckId);
      final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
      return recordList.where((record) => record.firstSecond == true).length;
    }
    return 0;
  }

  int countUseDeckSecondMatches(Deck deck) {
    if (state.allRecordList != null) {
      final recordList = state.allRecordList!.where((record) => record.useDeckId == deck.deckId);
      final secondRecords = recordList.where((record) => record.firstSecond == false);
      return secondRecords.where((record) => record.useDeckId == deck.deckId).length;
    }
    return 0;
  }

  int countOpponentDeckSecondMatches(Deck useDeck, Deck opponentDeck) {
    if (state.allRecordList != null) {
      final useDeckRecordList = state.allRecordList!.where((record) => record.useDeckId == useDeck.deckId);
      final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
      return recordList.where((record) => record.firstSecond == false).length;
    }
    return 0;
  }

  int countUseDeckWins(Deck deck) {
    if (state.allRecordList != null) {
      final recordList = state.allRecordList!.where((record) => record.useDeckId == deck.deckId);
      return recordList.where((record) => record.winLoss == true).length;
    }
    return 0;
  }

  int countOpponentDeckWins(Deck useDeck, Deck opponentDeck) {
    if (state.allRecordList != null) {
      final useDeckRecordList = state.allRecordList!.where((record) => record.useDeckId == useDeck.deckId);
      final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
      return recordList.where((record) => record.winLoss == true).length;
    }
    return 0;
  }

  int countUseDeckLoss(Deck deck) {
    if (state.allRecordList != null) {
      final recordList = state.allRecordList!.where((record) => record.useDeckId == deck.deckId);
      return recordList.where((record) => record.winLoss == false).length;
    }
    return 0;
  }

  int countOpponentDeckLoss(Deck useDeck, Deck opponentDeck) {
    if (state.allRecordList != null) {
      final useDeckRecordList = state.allRecordList!.where((record) => record.useDeckId == useDeck.deckId);
      final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
      return recordList.where((record) => record.winLoss == false).length;
    }
    return 0;
  }

  double calcUseDeckWinRate(Deck deck) {
    if (state.allRecordList != null) {
      final win = countUseDeckWins(deck);
      final matches = countUseDeckMatches(deck);
      return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
    }
    return 0;
  }

  double calcOpponentDeckWinRate(Deck useDeck, Deck opponentDeck) {
    if (state.allRecordList != null) {
      final win = countOpponentDeckWins(useDeck, opponentDeck);
      final matches = countOpponentDeckMatches(useDeck, opponentDeck);
      return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
    }
    return 0;
  }

  double calcUseDeckWinRateOfFirst(Deck deck) {
    if (state.allRecordList != null) {
      final recordList = state.allRecordList!.where((record) => record.useDeckId == deck.deckId);
      final firstRecords = recordList.where((record) => record.firstSecond == true);
      final win = firstRecords.where((record) => record.winLoss == true).length;
      final matches = countUseDeckFirstMatches(deck);
      return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
    }
    return 0;
  }

  double calcOpponentDeckWinRateOfFirst(Deck useDeck, Deck opponentDeck) {
    if (state.allRecordList != null) {
      final useDeckRecordList = state.allRecordList!.where((record) => record.useDeckId == useDeck.deckId);
      final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
      final firstRecords = recordList.where((record) => record.firstSecond == true);
      final win = firstRecords.where((record) => record.winLoss == true).length;
      final matches = countOpponentDeckFirstMatches(useDeck, opponentDeck);
      return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
    }
    return 0;
  }

  double calcUseDeckWinRateOfSecond(Deck deck) {
    if (state.allRecordList != null) {
      final recordList = state.allRecordList!.where((record) => record.useDeckId == deck.deckId);
      final secondRecords = recordList.where((record) => record.firstSecond == false);
      final win = secondRecords.where((record) => record.winLoss == true).length;
      final matches = countUseDeckSecondMatches(deck);
      return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
    }
    return 0;
  }

  double calcOpponentDeckWinRateOfSecond(Deck useDeck, Deck opponentDeck) {
    if (state.allRecordList != null) {
      final useDeckRecordList = state.allRecordList!.where((record) => record.useDeckId == useDeck.deckId);
      final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
      final firstRecords = recordList.where((record) => record.firstSecond == false);
      final win = firstRecords.where((record) => record.winLoss == true).length;
      final matches = countOpponentDeckSecondMatches(useDeck, opponentDeck);
      return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
    }
    return 0;
  }
}

final allRecordListNotifierProvider = StateNotifierProvider<RecordListNotifier, RecordListState>(
  (ref) => RecordListNotifier(ref.read),
);
