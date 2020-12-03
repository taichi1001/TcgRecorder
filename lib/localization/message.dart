import 'package:flutter/material.dart';

class Message {
  Message({
    @required this.inputScreenTitle,
    @required this.gameListTitle,
    @required this.input,
    @required this.data,
    @required this.graphTabName,
    @required this.listTabName,
    @required this.noItem,
    @required this.delete,
    @required this.recordDeck,
    @required this.first,
    @required this.second,
    @required this.win,
    @required this.lose,
    @required this.inputGameHint,
    @required this.inputGameLabel,
    @required this.inputUseDeckLabel,
    @required this.inputUseDeckHint,
    @required this.inputOpponentDeckLabel,
    @required this.inputOpponentDeckHint,
    @required this.inputTagLabel,
    @required this.inputTagHint,
    @required this.cancel,
    @required this.confirmation,
    @required this.confirmationText,
    @required this.ok,
    @required this.submit,
    @required this.winRate,
    @required this.useageRate,
    @required this.deckDetailScreenDeckName,
    @required this.deckDetailScreenMatches,
    @required this.deckDetailScreenWin,
    @required this.deckDetailScreenLose,
    @required this.deckDetailScreenWinRate,
    @required this.opponentDeckPercentageGraphTitle,
    @required this.useDeckPercentageGraphTitle,
    @required this.winRateGraphTitle,
    @required this.dataScreenTitle,
    @required this.vsDeckDetailScreenTitle,
  });

  final String input;
  final String data;
  final String inputScreenTitle;
  final String gameListTitle;
  final String graphTabName;
  final String listTabName;
  final String noItem;
  final String delete;
  final String Function(String, String) recordDeck;
  final String first;
  final String second;
  final String win;
  final String lose;
  final String inputGameLabel;
  final String inputGameHint;
  final String inputUseDeckLabel;
  final String inputUseDeckHint;
  final String inputOpponentDeckLabel;
  final String inputOpponentDeckHint;
  final String inputTagLabel;
  final String inputTagHint;
  final String submit;
  final String cancel;
  final String ok;
  final String confirmation;
  final String confirmationText;
  final String winRate;
  final String useageRate;
  final String deckDetailScreenDeckName;
  final String deckDetailScreenMatches;
  final String deckDetailScreenWin;
  final String deckDetailScreenLose;
  final String deckDetailScreenWinRate;
  final String opponentDeckPercentageGraphTitle;
  final String useDeckPercentageGraphTitle;
  final String winRateGraphTitle;
  final String Function(String) dataScreenTitle;
  final String Function(String) vsDeckDetailScreenTitle;

  factory Message.of(Locale locale) {
    switch (locale.languageCode) {
      case 'ja':
        return Message.ja();
      case 'en':
        return Message.en();
      default:
        return Message.en();
    }
  }

  factory Message.ja() => Message(
        inputScreenTitle: '入力',
        gameListTitle: 'ゲーム一覧',
        input: '入力',
        data: 'データ',
        graphTabName: 'グラフ',
        listTabName: 'リスト',
        noItem: 'データがありません。',
        delete: '削除',
        recordDeck: (mydeck, opponentDeck) => '使用デッキ：$mydeck\n対戦デッキ：$opponentDeck',
        first: '先攻',
        second: '後攻',
        win: '勝ち',
        lose: '負け',
        inputGameLabel: 'ゲーム名',
        inputGameHint: 'ゲーム名を入力してください',
        inputTagLabel: 'タグ名',
        inputTagHint: 'タグ名を入力してください(必須ではない)',
        inputUseDeckLabel: '使用デッキ',
        inputUseDeckHint: '使用デッキを入力してください',
        inputOpponentDeckLabel: '対戦相手のデッキ',
        inputOpponentDeckHint: '対戦相手のデッキを入力してください',
        confirmation: '確認',
        confirmationText: '登録しますか？',
        ok: 'はい',
        submit: '登録する',
        cancel: 'キャンセル',
        winRate: '勝率',
        useageRate: '使用率',
        deckDetailScreenDeckName: '対戦デッキ',
        deckDetailScreenMatches: '試合数',
        deckDetailScreenWin: '勝',
        deckDetailScreenLose: '負',
        deckDetailScreenWinRate: '勝率',
        useDeckPercentageGraphTitle: 'デッキ使用率',
        opponentDeckPercentageGraphTitle: '対戦相手デッキ使用率',
        winRateGraphTitle: '勝率推移',
        dataScreenTitle: (game) => game,
        vsDeckDetailScreenTitle: (deck) => deck,
      );

  factory Message.en() => Message(
        inputScreenTitle: 'Input',
        gameListTitle: 'Game List',
        input: 'Input',
        data: 'Data',
        graphTabName: 'Graph',
        listTabName: 'List',
        noItem: 'No Items',
        delete: 'Delete',
        recordDeck: (mydeck, opponentDeck) => 'Use Deck：$mydeck\nOpponet Deck：$opponentDeck',
        first: '1st',
        second: '2nd',
        win: 'Win',
        lose: 'Lose',
        inputGameLabel: 'Game',
        inputGameHint: 'Enter Game',
        inputTagLabel: 'Tag',
        inputTagHint: 'Enter Tag (Not required)',
        inputUseDeckHint: 'Use Deck',
        inputUseDeckLabel: 'Enter Use Deck',
        inputOpponentDeckLabel: 'Opponent Deck',
        inputOpponentDeckHint: 'Enter Opponent Deck',
        confirmation: 'Confirmation',
        confirmationText: 'Do you want to register?',
        ok: 'OK',
        submit: 'Submit',
        cancel: 'CANCEL',
        winRate: 'Winning Percentage',
        useageRate: 'Useage Rate',
        deckDetailScreenDeckName: 'Opponent Deck',
        deckDetailScreenMatches: 'Match',
        deckDetailScreenWin: 'Win',
        deckDetailScreenLose: 'Lose',
        deckDetailScreenWinRate: '%',
        useDeckPercentageGraphTitle: 'Deck Useage',
        opponentDeckPercentageGraphTitle: 'Opponent Deck Useage',
        winRateGraphTitle: 'Winning Ratios',
        dataScreenTitle: (game) => game,
        vsDeckDetailScreenTitle: (deck) => '$deck\'s Matchup Data',
      );
}
