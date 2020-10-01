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
        inputScreenTitle: 'データ入力',
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
        inputUseDeckHint: '使用デッキ',
        inputUseDeckLabel: '使用デッキを入力してください',
        inputOpponentDeckLabel: '対戦相手のデッキ',
        inputOpponentDeckHint: '対戦相手のデッキを入力してください',
        confirmation: '確認',
        confirmationText: '登録しますか？',
        ok: 'はい',
        submit: '完了',
        cancel: 'キャンセル',
      );

  factory Message.en() => Message(
        inputScreenTitle: 'Data Input',
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
      );
}
