import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';

class RecordCalculator {
  RecordCalculator({
    required this.targetRecordList,
  });

  final List<Record> targetRecordList;

  /// 対象のリストの試合数をカウント
  int countMatches() => targetRecordList.length;

  /// 対象リストの先攻試合数をカウント
  int countFirstMatches() => targetRecordList.where((record) => record.firstSecond == FirstSecond.first).length;

  /// 対象リストの後攻試合数をカウント
  int countSecondMatches() => targetRecordList.where((record) => record.firstSecond == FirstSecond.second).length;

  /// 対象リストの勝数をカウント
  int countWins() => targetRecordList.where((record) => record.winLoss == WinLoss.win).length;

  /// 対象リストの先攻勝数をカウント
  int countFirstMatchesWins() =>
      targetRecordList.where((record) => record.firstSecond == FirstSecond.first && record.winLoss == WinLoss.win).length;

  /// 対象リストの後攻勝数をカウント
  int countSecondMatchesWins() =>
      targetRecordList.where((record) => record.firstSecond == FirstSecond.second && record.winLoss == WinLoss.win).length;

  /// 対象リストの負数をカウント
  int countLoss() => targetRecordList.where((record) => record.winLoss == WinLoss.loss).length;

  /// 対象リストの先攻負数をカウント
  int countFirstMatchesLoss() =>
      targetRecordList.where((record) => record.firstSecond == FirstSecond.first && record.winLoss == WinLoss.loss).length;

  /// 対象リストの後攻負数をカウント
  int countSecondMatchesLoss() =>
      targetRecordList.where((record) => record.firstSecond == FirstSecond.second && record.winLoss == WinLoss.loss).length;

  /// 対象リストの引き分け数をカウント
  int countDraw() => targetRecordList.where((record) => record.winLoss == WinLoss.draw).length;

  /// 対象リストの先攻引き分け数をカウント
  int countFirstMatchesDraw() =>
      targetRecordList.where((record) => record.firstSecond == FirstSecond.first && record.winLoss == WinLoss.draw).length;

  /// 対象リストの後攻引き分け数をカウント
  int countSecondMatchesDraw() =>
      targetRecordList.where((record) => record.firstSecond == FirstSecond.second && record.winLoss == WinLoss.draw).length;

  /// 対象リスト全体の勝率を計算
  double calcWinRate() {
    final win = countWins();
    final matches = countMatches();
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  /// 対象リスト全体の先攻勝率を計算
  double calcWinRateOfFirst() {
    final firstRecord = targetRecordList.where((record) => record.firstSecond == FirstSecond.first).toList();
    final win = firstRecord.where((record) => record.winLoss == WinLoss.win).length;
    final matches = countFirstMatches();
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  /// 対象リスト全体の後攻勝率を計算
  double calcWinRateOfSecond() {
    final firstRecord = targetRecordList.where((record) => record.firstSecond == FirstSecond.second).toList();
    final win = firstRecord.where((record) => record.winLoss == WinLoss.win).length;
    final matches = countSecondMatches();
    return double.parse((win.toDouble() / matches.toDouble() * 100).toStringAsFixed(1));
  }

  /// 対象リスト内で指定した使用デッキの試合数をカウント
  int countUseDeckMatches(Deck deck) => targetRecordList.where((record) => record.useDeckId == deck.deckId).length;

  /// 対象リスト内で指定した対戦相手デッキの試合数をカウント
  int countOpponentDeckMatches2(Deck deck) => targetRecordList.where((record) => record.opponentDeckId == deck.deckId).length;

  /// 対象リスト内で使用デッキと対戦相手デッキを指定して該当する試合数をカウント
  int countOpponentDeckMatches(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = targetRecordList.where((record) => record.useDeckId == useDeck.deckId);
    return useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId).length;
  }

  /// 対象リスト内で使用デッキを指定して該当する先攻試合数をカウント
  int countUseDeckFirstMatches(Deck deck) {
    final recordList = targetRecordList.where((record) => record.useDeckId == deck.deckId);
    final firstRecords = recordList.where((record) => record.firstSecond == FirstSecond.first);
    return firstRecords.where((record) => record.useDeckId == deck.deckId).length;
  }

  /// 対象リスト内で使用デッキと対戦相手デッキを指定して該当する先攻試合数をカウント
  int countOpponentDeckFirstMatches(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = targetRecordList.where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    return recordList.where((record) => record.firstSecond == FirstSecond.first).length;
  }

  /// 対象リスト内で使用デッキを指定して該当する後攻試合数をカウント
  int countUseDeckSecondMatches(Deck deck) {
    final recordList = targetRecordList.where((record) => record.useDeckId == deck.deckId);
    final secondRecords = recordList.where((record) => record.firstSecond == FirstSecond.second);
    return secondRecords.where((record) => record.useDeckId == deck.deckId).length;
  }

  /// 対象リスト内で使用デッキと対戦相手デッキを指定して該当する後攻試合数をカウント
  int countOpponentDeckSecondMatches(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = targetRecordList.where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    return recordList.where((record) => record.firstSecond == FirstSecond.second).length;
  }

  /// 対象リスト内で使用デッキを指定して該当する勝利数をカウント
  int countUseDeckWins(Deck deck) {
    final recordList = targetRecordList.where((record) => record.useDeckId == deck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.win).length;
  }

  /// 対象リスト内で使用デッキを指定して該当する先攻勝利数をカウント
  int countUseDeckFirstMatchesWins(Deck deck) {
    final recordList = targetRecordList.where((record) => record.useDeckId == deck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.win && record.firstSecond == FirstSecond.first).length;
  }

  /// 対象リスト内で使用デッキを指定して該当する後攻勝利数をカウント
  int countUseDeckSecondMatchesWins(Deck deck) {
    final recordList = targetRecordList.where((record) => record.useDeckId == deck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.win && record.firstSecond == FirstSecond.second).length;
  }

  /// 対象リスト内で使用デッキと対戦相手を指定して該当する勝利数をカウント
  int countOpponentDeckWins(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = targetRecordList.where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.win).length;
  }

  /// 対象リスト内で使用デッキと対戦相手を指定して該当する先攻勝利数をカウント
  int countOpponentDeckFirstMatchesWins(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = targetRecordList.where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.win && record.firstSecond == FirstSecond.first).length;
  }

  /// 対象リスト内で使用デッキと対戦相手を指定して該当する後攻勝利数をカウント
  int countOpponentDeckSecondMatchesWins(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = targetRecordList.where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.win && record.firstSecond == FirstSecond.second).length;
  }

  /// 対象リスト内で使用デッキを指定して該当する負け数をカウント
  int countUseDeckLoss(Deck deck) {
    final recordList = targetRecordList.where((record) => record.useDeckId == deck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.loss).length;
  }

  /// 対象リスト内で使用デッキを指定して該当する先攻負け数をカウント
  int countUseDeckFirstMatchesLoss(Deck deck) {
    final recordList = targetRecordList.where((record) => record.useDeckId == deck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.loss && record.firstSecond == FirstSecond.first).length;
  }

  /// 対象リスト内で使用デッキを指定して該当する後攻負け数をカウント
  int countUseDeckSecondMatchesLoss(Deck deck) {
    final recordList = targetRecordList.where((record) => record.useDeckId == deck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.loss && record.firstSecond == FirstSecond.second).length;
  }

  /// 対象リスト内で使用デッキと対戦相手を指定して該当する負け数をカウント
  int countOpponentDeckLoss(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = targetRecordList.where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.loss).length;
  }

  /// 対象リスト内で使用デッキと対戦相手を指定して該当する先攻負け数をカウント
  int countOpponentDeckFirstMatchesLoss(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = targetRecordList.where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.loss && record.firstSecond == FirstSecond.first).length;
  }

  /// 対象リスト内で使用デッキと対戦相手を指定して該当する後攻負け数をカウント
  int countOpponentDeckSecondMatchesLoss(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = targetRecordList.where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.loss && record.firstSecond == FirstSecond.second).length;
  }

  /// 対象リスト内で使用デッキを指定して該当する引き分け数をカウント
  int countUseDeckDraw(Deck deck) {
    final recordList = targetRecordList.where((record) => record.useDeckId == deck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.draw).length;
  }

  /// 対象リスト内で使用デッキを指定して該当する先攻引き分け数をカウント
  int countUseDeckFirstMatchesDraw(Deck deck) {
    final recordList = targetRecordList.where((record) => record.useDeckId == deck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.draw && record.firstSecond == FirstSecond.first).length;
  }

  /// 対象リスト内で使用デッキを指定して該当する後攻引き分け数をカウント
  int countUseDeckSecondMatchesDraw(Deck deck) {
    final recordList = targetRecordList.where((record) => record.useDeckId == deck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.draw && record.firstSecond == FirstSecond.second).length;
  }

  /// 対象リスト内で使用デッキと対戦相手を指定して該当する引き分け数をカウント
  int countOpponentDeckDraw(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = targetRecordList.where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.draw).length;
  }

  /// 対象リスト内で使用デッキと対戦相手を指定して該当する先攻引き分け数をカウント
  int countOpponentDeckFirstMatchesDraw(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = targetRecordList.where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.draw && record.firstSecond == FirstSecond.first).length;
  }

  /// 対象リスト内で使用デッキと対戦相手を指定して該当する後攻引き分け数をカウント
  int countOpponentDeckSecondMatchesDraw(Deck useDeck, Deck opponentDeck) {
    final useDeckRecordList = targetRecordList.where((record) => record.useDeckId == useDeck.deckId);
    final recordList = useDeckRecordList.where((record) => record.opponentDeckId == opponentDeck.deckId);
    return recordList.where((record) => record.winLoss == WinLoss.draw && record.firstSecond == FirstSecond.second).length;
  }

  double calcUseDeckUseRate(Deck useDeck) => countUseDeckMatches(useDeck) / countMatches();

  double calcOpponentDeckUseRate(Deck useDeck) => countOpponentDeckMatches2(useDeck) / countMatches();

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
