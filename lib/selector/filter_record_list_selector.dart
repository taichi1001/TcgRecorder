import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';
import 'package:tcg_manager/provider/record_list_view_provider.dart';
import 'package:tcg_manager/selector/game_record_list_selector.dart';

final filterRecordListProvider = StateProvider.autoDispose<List<Record>>((ref) {
  final recordList = ref.watch(gameRecordListProvider);
  final filter = ref.watch(recordListViewNotifierProvider);

  var filterdList = recordList;

  if (filter.startDate != null) {
    filterdList = filterdList.where((record) {
      if (record.date!.isAtSameMomentAs(filter.startDate!) || record.date!.isAfter(filter.startDate!)) {
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  if (filter.endDate != null) {
    filterdList = filterdList.where((record) {
      if (record.date!.isAtSameMomentAs(filter.endDate!) || record.date!.isBefore(filter.endDate!)) {
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  if (filter.useDeck != null) {
    filterdList = filterdList.where((record) => record.useDeckId == filter.useDeck!.deckId).toList();
  }

  if (filter.opponentDeck != null) {
    filterdList = filterdList.where((record) => record.opponentDeckId == filter.opponentDeck!.deckId).toList();
  }

  if (filter.tag != null) {
    filterdList = filterdList.where((record) => record.tagId == filter.tag!.tagId).toList();
  }

  return filterdList;
});

final filterRecordListController = Provider((ref) => FilterRecordListController(read: ref.read));

class FilterRecordListController {
  FilterRecordListController({
    required this.read,
  });
  final Reader read;

  int countMatches() {
    return read(filterRecordListProvider).length;
  }

  int countFirstMatches() {
    return read(filterRecordListProvider).where((record) => record.firstSecond == FirstSecond.first).length;
  }

  int countSecondMatches() {
    return read(filterRecordListProvider).where((record) => record.firstSecond == FirstSecond.second).length;
  }

  int countWins() {
    return read(filterRecordListProvider).where((record) => record.winLoss == WinLoss.win).length;
  }

  int countLoss() {
    return read(filterRecordListProvider).where((record) => record.winLoss == WinLoss.loss).length;
  }

  double calcWinRate() {
    final win = countWins();
    final matches = countMatches();
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  double calcWinRateOfFirst() {
    final firstRecord = read(filterRecordListProvider).where((record) => record.firstSecond == FirstSecond.first).toList();
    final win = firstRecord.where((record) => record.winLoss == WinLoss.win).length;
    final matches = countFirstMatches();
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  double calcWinRateOfSecond() {
    final firstRecord = read(filterRecordListProvider).where((record) => record.firstSecond == FirstSecond.second).toList();
    final win = firstRecord.where((record) => record.winLoss == WinLoss.win).length;
    final matches = countSecondMatches();
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  int countDeckMatches(Deck deck) {
    return read(filterRecordListProvider).where((record) => record.useDeckId == deck.deckId).length;
  }

  int countOpponentDeckMatches(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = read(filterRecordListProvider).where((record) => record.useDeckId == useDeck.deckId);
    return useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId).length;
  }

  int countUseDeckFirstMatches(Deck deck) {
    final recordList = read(filterRecordListProvider).where((record) => record.useDeckId == deck.deckId);
    final firstRecords = recordList.where((record) => record.firstSecond == FirstSecond.first);
    return firstRecords.where((record) => record.useDeckId == deck.deckId).length;
  }

  int countOpponentDeckFirstMatches(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = read(filterRecordListProvider).where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    return recordList.where((record) => record.firstSecond == FirstSecond.first).length;
  }

  int countUseDeckSecondMatches(Deck deck) {
    final recordList = read(filterRecordListProvider).where((record) => record.useDeckId == deck.deckId);
    final secondRecords = recordList.where((record) => record.firstSecond == FirstSecond.second);
    return secondRecords.where((record) => record.useDeckId == deck.deckId).length;
  }

  int countOpponentDeckSecondMatches(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = read(filterRecordListProvider).where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    return recordList.where((record) => record.firstSecond == FirstSecond.second).length;
  }

  int countUseDeckWins(Deck deck) {
    final recordList = read(filterRecordListProvider).where((record) => record.useDeckId == deck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.win).length;
  }

  int countOpponentDeckWins(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = read(filterRecordListProvider).where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.win).length;
  }

  int countUseDeckLoss(Deck deck) {
    final recordList = read(filterRecordListProvider).where((record) => record.useDeckId == deck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.loss).length;
  }

  int countOpponentDeckLoss(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = read(filterRecordListProvider).where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.loss).length;
  }

  double calcDeckUseRate(Deck useDeck) {
    return countDeckMatches(useDeck) / countMatches();
  }

  double calcUseDeckWinRate(Deck deck) {
    final win = countUseDeckWins(deck);
    final matches = countDeckMatches(deck);
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  double calcOpponentDeckWinRate(Deck useDeck, Deck opponentDeck) {
    final win = countOpponentDeckWins(useDeck, opponentDeck);
    final matches = countOpponentDeckMatches(useDeck, opponentDeck);
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  double calcUseDeckWinRateOfFirst(Deck deck) {
    final recordList = read(filterRecordListProvider).where((record) => record.useDeckId == deck.deckId);
    final firstRecords = recordList.where((record) => record.firstSecond == FirstSecond.first);
    final win = firstRecords.where((record) => record.winLoss == WinLoss.win).length;
    final matches = countUseDeckFirstMatches(deck);
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  double calcOpponentDeckWinRateOfFirst(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = read(filterRecordListProvider).where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    final firstRecords = recordList.where((record) => record.firstSecond == FirstSecond.first);
    final win = firstRecords.where((record) => record.winLoss == WinLoss.win).length;
    final matches = countOpponentDeckFirstMatches(useDeck, opponentDeck);
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  double calcUseDeckWinRateOfSecond(Deck deck) {
    final recordList = read(filterRecordListProvider).where((record) => record.useDeckId == deck.deckId);
    final secondRecords = recordList.where((record) => record.firstSecond == FirstSecond.second);
    final win = secondRecords.where((record) => record.winLoss == WinLoss.win).length;
    final matches = countUseDeckSecondMatches(deck);
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  double calcOpponentDeckWinRateOfSecond(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = read(filterRecordListProvider).where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    final secondRecords = recordList.where((record) => record.firstSecond == FirstSecond.second);
    final win = secondRecords.where((record) => record.winLoss == WinLoss.win).length;
    final matches = countOpponentDeckSecondMatches(useDeck, opponentDeck);
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }
}
