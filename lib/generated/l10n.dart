// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Enter the name of the game you want to record.`
  String get initializeGame {
    return Intl.message(
      'Enter the name of the game you want to record.',
      name: 'initializeGame',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Deck`
  String get deck {
    return Intl.message(
      'Deck',
      name: 'deck',
      desc: '',
      args: [],
    );
  }

  /// `Use Deck`
  String get useDeck {
    return Intl.message(
      'Use Deck',
      name: 'useDeck',
      desc: '',
      args: [],
    );
  }

  /// `Opponent Deck`
  String get opponentDeck {
    return Intl.message(
      'Opponent Deck',
      name: 'opponentDeck',
      desc: '',
      args: [],
    );
  }

  /// `First/Second`
  String get order {
    return Intl.message(
      'First/Second',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Win/Loss`
  String get winOrLoss {
    return Intl.message(
      'Win/Loss',
      name: 'winOrLoss',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Input`
  String get bottomInput {
    return Intl.message(
      'Input',
      name: 'bottomInput',
      desc: '',
      args: [],
    );
  }

  /// `Data`
  String get bottomData {
    return Intl.message(
      'Data',
      name: 'bottomData',
      desc: '',
      args: [],
    );
  }

  /// `List`
  String get bottomList {
    return Intl.message(
      'List',
      name: 'bottomList',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get bottomOther {
    return Intl.message(
      'Other',
      name: 'bottomOther',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get newGame {
    return Intl.message(
      'New',
      name: 'newGame',
      desc: '',
      args: [],
    );
  }

  /// `Use Deck`
  String get tableDeckName {
    return Intl.message(
      'Use Deck',
      name: 'tableDeckName',
      desc: '',
      args: [],
    );
  }

  /// `Opponent Deck`
  String get tableOpponentDeckName {
    return Intl.message(
      'Opponent Deck',
      name: 'tableOpponentDeckName',
      desc: '',
      args: [],
    );
  }

  /// `Games`
  String get tableGames {
    return Intl.message(
      'Games',
      name: 'tableGames',
      desc: '',
      args: [],
    );
  }

  /// `Win`
  String get tableWin {
    return Intl.message(
      'Win',
      name: 'tableWin',
      desc: '',
      args: [],
    );
  }

  /// `Loss`
  String get tableLoss {
    return Intl.message(
      'Loss',
      name: 'tableLoss',
      desc: '',
      args: [],
    );
  }

  /// `Win Rate`
  String get tableWinRate {
    return Intl.message(
      'Win Rate',
      name: 'tableWinRate',
      desc: '',
      args: [],
    );
  }

  /// `First Win Rate`
  String get tableFirstWinRate {
    return Intl.message(
      'First Win Rate',
      name: 'tableFirstWinRate',
      desc: '',
      args: [],
    );
  }

  /// `Second Win Rate`
  String get tableSecondWinRate {
    return Intl.message(
      'Second Win Rate',
      name: 'tableSecondWinRate',
      desc: '',
      args: [],
    );
  }

  /// `Sum`
  String get tableSum {
    return Intl.message(
      'Sum',
      name: 'tableSum',
      desc: '',
      args: [],
    );
  }

  /// `Input Game`
  String get inputgame {
    return Intl.message(
      'Input Game',
      name: 'inputgame',
      desc: '',
      args: [],
    );
  }

  /// `Input New Game`
  String get newGameDialog {
    return Intl.message(
      'Input New Game',
      name: 'newGameDialog',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to save it?`
  String get isSave {
    return Intl.message(
      'Do you want to save it?',
      name: 'isSave',
      desc: '',
      args: [],
    );
  }

  /// `First`
  String get first {
    return Intl.message(
      'First',
      name: 'first',
      desc: '',
      args: [],
    );
  }

  /// `Second`
  String get second {
    return Intl.message(
      'Second',
      name: 'second',
      desc: '',
      args: [],
    );
  }

  /// `Win`
  String get win {
    return Intl.message(
      'Win',
      name: 'win',
      desc: '',
      args: [],
    );
  }

  /// `Loss`
  String get loss {
    return Intl.message(
      'Loss',
      name: 'loss',
      desc: '',
      args: [],
    );
  }

  /// `Use Deck: `
  String get listUseDeck {
    return Intl.message(
      'Use Deck: ',
      name: 'listUseDeck',
      desc: '',
      args: [],
    );
  }

  /// `Opponent Deck: `
  String get listOpponentDeck {
    return Intl.message(
      'Opponent Deck: ',
      name: 'listOpponentDeck',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get otherTitle {
    return Intl.message(
      'Other',
      name: 'otherTitle',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get editSection {
    return Intl.message(
      'Edit',
      name: 'editSection',
      desc: '',
      args: [],
    );
  }

  /// `Edit Game`
  String get gameEdit {
    return Intl.message(
      'Edit Game',
      name: 'gameEdit',
      desc: '',
      args: [],
    );
  }

  /// `Delete All Data`
  String get allDelete {
    return Intl.message(
      'Delete All Data',
      name: 'allDelete',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get otherSection {
    return Intl.message(
      'Other',
      name: 'otherSection',
      desc: '',
      args: [],
    );
  }

  /// `App Review`
  String get review {
    return Intl.message(
      'App Review',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Delete All Data`
  String get allDeleteDialog {
    return Intl.message(
      'Delete All Data',
      name: 'allDeleteDialog',
      desc: '',
      args: [],
    );
  }

  /// `All data will be deleted and will be irreversible.`
  String get allDeleteMessage {
    return Intl.message(
      'All data will be deleted and will be irreversible.',
      name: 'allDeleteMessage',
      desc: '',
      args: [],
    );
  }

  /// `There is no record of this game.`
  String get noDataMessage {
    return Intl.message(
      'There is no record of this game.',
      name: 'noDataMessage',
      desc: '',
      args: [],
    );
  }

  /// `Can I delete it?`
  String get deleteMessage {
    return Intl.message(
      'Can I delete it?',
      name: 'deleteMessage',
      desc: '',
      args: [],
    );
  }

  /// `Graph function is not yet implemented.。`
  String get nextFunctionAnnounce1 {
    return Intl.message(
      'Graph function is not yet implemented.。',
      name: 'nextFunctionAnnounce1',
      desc: '',
      args: [],
    );
  }

  /// `We are planning to implement this in the future, so please support us.`
  String get nextFunctionAnnounce2 {
    return Intl.message(
      'We are planning to implement this in the future, so please support us.',
      name: 'nextFunctionAnnounce2',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja', countryCode: 'JP'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
