import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';

class RecordCalculator {
  RecordCalculator({
    required this.targetRecordList,
  });

  final List<Record> targetRecordList;

  int countMatches() {
    return targetRecordList.length;
  }

  int countFirstMatches() {
    return targetRecordList.where((record) => record.firstSecond == FirstSecond.first).length;
  }

  int countSecondMatches() {
    return targetRecordList.where((record) => record.firstSecond == FirstSecond.second).length;
  }

  int countWins() {
    return targetRecordList.where((record) => record.winLoss == WinLoss.win).length;
  }

  int countLoss() {
    return targetRecordList.where((record) => record.winLoss == WinLoss.loss).length;
  }

  double calcWinRate() {
    final win = countWins();
    final matches = countMatches();
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  double calcWinRateOfFirst() {
    final firstRecord = targetRecordList.where((record) => record.firstSecond == FirstSecond.first).toList();
    final win = firstRecord.where((record) => record.winLoss == WinLoss.win).length;
    final matches = countFirstMatches();
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  double calcWinRateOfSecond() {
    final firstRecord = targetRecordList.where((record) => record.firstSecond == FirstSecond.second).toList();
    final win = firstRecord.where((record) => record.winLoss == WinLoss.win).length;
    final matches = countSecondMatches();
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  int countUseDeckMatches(Deck deck) {
    return targetRecordList.where((record) => record.useDeckId == deck.deckId).length;
  }

  int countOpponentDeckMatches2(Deck deck) {
    return targetRecordList.where((record) => record.opponentDeckId == deck.deckId).length;
  }

  int countOpponentDeckMatches(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = targetRecordList.where((record) => record.useDeckId == useDeck.deckId);
    return useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId).length;
  }

  int countUseDeckFirstMatches(Deck deck) {
    final recordList = targetRecordList.where((record) => record.useDeckId == deck.deckId);
    final firstRecords = recordList.where((record) => record.firstSecond == FirstSecond.first);
    return firstRecords.where((record) => record.useDeckId == deck.deckId).length;
  }

  int countOpponentDeckFirstMatches(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = targetRecordList.where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    return recordList.where((record) => record.firstSecond == FirstSecond.first).length;
  }

  int countUseDeckSecondMatches(Deck deck) {
    final recordList = targetRecordList.where((record) => record.useDeckId == deck.deckId);
    final secondRecords = recordList.where((record) => record.firstSecond == FirstSecond.second);
    return secondRecords.where((record) => record.useDeckId == deck.deckId).length;
  }

  int countOpponentDeckSecondMatches(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = targetRecordList.where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    return recordList.where((record) => record.firstSecond == FirstSecond.second).length;
  }

  int countUseDeckWins(Deck deck) {
    final recordList = targetRecordList.where((record) => record.useDeckId == deck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.win).length;
  }

  int countOpponentDeckWins(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = targetRecordList.where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.win).length;
  }

  int countUseDeckLoss(Deck deck) {
    final recordList = targetRecordList.where((record) => record.useDeckId == deck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.loss).length;
  }

  int countOpponentDeckLoss(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = targetRecordList.where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.loss).length;
  }

  double calcUseDeckUseRate(Deck useDeck) {
    return countUseDeckMatches(useDeck) / countMatches();
  }

  double calcOpponentDeckUseRate(Deck useDeck) {
    return countOpponentDeckMatches2(useDeck) / countMatches();
  }

  double calcUseDeckWinRate(Deck deck) {
    final win = countUseDeckWins(deck);
    final matches = countUseDeckMatches(deck);
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  double calcOpponentDeckWinRate(Deck useDeck, Deck opponentDeck) {
    final win = countOpponentDeckWins(useDeck, opponentDeck);
    final matches = countOpponentDeckMatches(useDeck, opponentDeck);
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  double calcUseDeckWinRateOfFirst(Deck deck) {
    final recordList = targetRecordList.where((record) => record.useDeckId == deck.deckId);
    final firstRecords = recordList.where((record) => record.firstSecond == FirstSecond.first);
    final win = firstRecords.where((record) => record.winLoss == WinLoss.win).length;
    final matches = countUseDeckFirstMatches(deck);
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  double calcOpponentDeckWinRateOfFirst(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = targetRecordList.where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    final firstRecords = recordList.where((record) => record.firstSecond == FirstSecond.first);
    final win = firstRecords.where((record) => record.winLoss == WinLoss.win).length;
    final matches = countOpponentDeckFirstMatches(useDeck, opponentDeck);
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  double calcUseDeckWinRateOfSecond(Deck deck) {
    final recordList = targetRecordList.where((record) => record.useDeckId == deck.deckId);
    final secondRecords = recordList.where((record) => record.firstSecond == FirstSecond.second);
    final win = secondRecords.where((record) => record.winLoss == WinLoss.win).length;
    final matches = countUseDeckSecondMatches(deck);
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  double calcOpponentDeckWinRateOfSecond(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = targetRecordList.where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    final secondRecords = recordList.where((record) => record.firstSecond == FirstSecond.second);
    final win = secondRecords.where((record) => record.winLoss == WinLoss.win).length;
    final matches = countOpponentDeckSecondMatches(useDeck, opponentDeck);
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }
}
