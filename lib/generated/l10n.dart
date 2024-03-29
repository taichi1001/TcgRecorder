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

  /// `Tag (Optional)`
  String get tag {
    return Intl.message(
      'Tag (Optional)',
      name: 'tag',
      desc: '',
      args: [],
    );
  }

  /// `Memo`
  String get memo {
    return Intl.message(
      'Memo',
      name: 'memo',
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

  /// `Draw`
  String get draw {
    return Intl.message(
      'Draw',
      name: 'draw',
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

  /// `Edit Deck`
  String get deckEdit {
    return Intl.message(
      'Edit Deck',
      name: 'deckEdit',
      desc: '',
      args: [],
    );
  }

  /// `Edit Tag`
  String get tagEdit {
    return Intl.message(
      'Edit Tag',
      name: 'tagEdit',
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

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get contactForm {
    return Intl.message(
      'Contact',
      name: 'contactForm',
      desc: '',
      args: [],
    );
  }

  /// `Newest`
  String get newest {
    return Intl.message(
      'Newest',
      name: 'newest',
      desc: '',
      args: [],
    );
  }

  /// `Oldest`
  String get oldest {
    return Intl.message(
      'Oldest',
      name: 'oldest',
      desc: '',
      args: [],
    );
  }

  /// `Keep notes to look back on. (Optional)`
  String get memoTag {
    return Intl.message(
      'Keep notes to look back on. (Optional)',
      name: 'memoTag',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get editButton {
    return Intl.message(
      'Edit',
      name: 'editButton',
      desc: '',
      args: [],
    );
  }

  /// `No tag`
  String get noTag {
    return Intl.message(
      'No tag',
      name: 'noTag',
      desc: '',
      args: [],
    );
  }

  /// `No memo`
  String get noMemo {
    return Intl.message(
      'No memo',
      name: 'noMemo',
      desc: '',
      args: [],
    );
  }

  /// `Use deck distribution`
  String get useDeckDistribution {
    return Intl.message(
      'Use deck distribution',
      name: 'useDeckDistribution',
      desc: '',
      args: [],
    );
  }

  /// `Opponent deck distribution`
  String get opponentDeckDistribution {
    return Intl.message(
      'Opponent deck distribution',
      name: 'opponentDeckDistribution',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get settingSection {
    return Intl.message(
      'Setting',
      name: 'settingSection',
      desc: '',
      args: [],
    );
  }

  /// `Input View Settings`
  String get inputViewSettings {
    return Intl.message(
      'Input View Settings',
      name: 'inputViewSettings',
      desc: '',
      args: [],
    );
  }

  /// `dd/MM/yyyy`
  String get dateFormat {
    return Intl.message(
      'dd/MM/yyyy',
      name: 'dateFormat',
      desc: '',
      args: [],
    );
  }

  /// `yyyy/MM/dd日 HH:mm`
  String get dateFormatIncludeTime {
    return Intl.message(
      'yyyy/MM/dd日 HH:mm',
      name: 'dateFormatIncludeTime',
      desc: '',
      args: [],
    );
  }

  /// `1`
  String get recordListFirst {
    return Intl.message(
      '1',
      name: 'recordListFirst',
      desc: '',
      args: [],
    );
  }

  /// `2`
  String get recordListSecond {
    return Intl.message(
      '2',
      name: 'recordListSecond',
      desc: '',
      args: [],
    );
  }

  /// `Deletes the selected record.`
  String get recordListDeleteDialogTitle {
    return Intl.message(
      'Deletes the selected record.',
      name: 'recordListDeleteDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `This operation cannot be undone.`
  String get recordListDeleteDialogMessage {
    return Intl.message(
      'This operation cannot be undone.',
      name: 'recordListDeleteDialogMessage',
      desc: '',
      args: [],
    );
  }

  /// `Memo: `
  String get recordListMemo {
    return Intl.message(
      'Memo: ',
      name: 'recordListMemo',
      desc: '',
      args: [],
    );
  }

  /// `No tag`
  String get recordListNoTag {
    return Intl.message(
      'No tag',
      name: 'recordListNoTag',
      desc: '',
      args: [],
    );
  }

  /// `The content I am editing is not saved, may I go back?`
  String get recordEditDialogMessage {
    return Intl.message(
      'The content I am editing is not saved, may I go back?',
      name: 'recordEditDialogMessage',
      desc: '',
      args: [],
    );
  }

  /// `Change theme`
  String get themeChange {
    return Intl.message(
      'Change theme',
      name: 'themeChange',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Premium Plan`
  String get premiumPlan {
    return Intl.message(
      'Premium Plan',
      name: 'premiumPlan',
      desc: '',
      args: [],
    );
  }

  /// `Win the game with more detailed recording and analysis!`
  String get premiumPlanCatchCopy {
    return Intl.message(
      'Win the game with more detailed recording and analysis!',
      name: 'premiumPlanCatchCopy',
      desc: '',
      args: [],
    );
  }

  /// `Record multiple tags`
  String get premiumPlanTagTitle {
    return Intl.message(
      'Record multiple tags',
      name: 'premiumPlanTagTitle',
      desc: '',
      args: [],
    );
  }

  /// `Various tag combinations can be recorded.`
  String get premiumPlanTagDescription {
    return Intl.message(
      'Various tag combinations can be recorded.',
      name: 'premiumPlanTagDescription',
      desc: '',
      args: [],
    );
  }

  /// `Recorded BO3 and draw`
  String get premiumPlanDrawTitle {
    return Intl.message(
      'Recorded BO3 and draw',
      name: 'premiumPlanDrawTitle',
      desc: '',
      args: [],
    );
  }

  /// `It can be used to record a variety of match formats.`
  String get premiumPlanDrawDescription {
    return Intl.message(
      'It can be used to record a variety of match formats.',
      name: 'premiumPlanDrawDescription',
      desc: '',
      args: [],
    );
  }

  /// `Record Images'`
  String get premiumPlanImageTitle {
    return Intl.message(
      'Record Images\'',
      name: 'premiumPlanImageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Images can be recorded with them. \nHow about putting up a Јn deck recipe or something?`
  String get premiumPlanImageDescription {
    return Intl.message(
      'Images can be recorded with them. \nHow about putting up a Јn deck recipe or something?',
      name: 'premiumPlanImageDescription',
      desc: '',
      args: [],
    );
  }

  /// `Export`
  String get premiumPlanExportTitle {
    return Intl.message(
      'Export',
      name: 'premiumPlanExportTitle',
      desc: '',
      args: [],
    );
  }

  /// `Export in CSV format. \nYou can analyze freely according to your ideas.`
  String get premiumPlanExportDescription {
    return Intl.message(
      'Export in CSV format. \nYou can analyze freely according to your ideas.',
      name: 'premiumPlanExportDescription',
      desc: '',
      args: [],
    );
  }

  /// `No ads displayed`
  String get premiumPlanADBlockTitle {
    return Intl.message(
      'No ads displayed',
      name: 'premiumPlanADBlockTitle',
      desc: '',
      args: [],
    );
  }

  /// `All advertisements in the application will be hidden.`
  String get premiumPlanADBlockDescription {
    return Intl.message(
      'All advertisements in the application will be hidden.',
      name: 'premiumPlanADBlockDescription',
      desc: '',
      args: [],
    );
  }

  /// `Automatic backup`
  String get premiumPlanBackupTitle {
    return Intl.message(
      'Automatic backup',
      name: 'premiumPlanBackupTitle',
      desc: '',
      args: [],
    );
  }

  /// `You can always backup the latest data.`
  String get premiumPlanBackupDescription {
    return Intl.message(
      'You can always backup the latest data.',
      name: 'premiumPlanBackupDescription',
      desc: '',
      args: [],
    );
  }

  /// `Game Sharing Restrictions Lifted`
  String get premiumPlanShareTitle {
    return Intl.message(
      'Game Sharing Restrictions Lifted',
      name: 'premiumPlanShareTitle',
      desc: '',
      args: [],
    );
  }

  /// `Unlimited game sharing.`
  String get premiumPlanShareDescription {
    return Intl.message(
      'Unlimited game sharing.',
      name: 'premiumPlanShareDescription',
      desc: '',
      args: [],
    );
  }

  /// `year`
  String get year {
    return Intl.message(
      'year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `month`
  String get month {
    return Intl.message(
      'month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Annual Plan`
  String get yearPlan {
    return Intl.message(
      'Annual Plan',
      name: 'yearPlan',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Plan`
  String get monthPlan {
    return Intl.message(
      'Monthly Plan',
      name: 'monthPlan',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Anytime`
  String get cancelAnytime {
    return Intl.message(
      'Cancel Anytime',
      name: 'cancelAnytime',
      desc: '',
      args: [],
    );
  }

  /// `\ First Week Free /`
  String get freePeriod {
    return Intl.message(
      '\\ First Week Free /',
      name: 'freePeriod',
      desc: '',
      args: [],
    );
  }

  /// `Free Trial`
  String get freePlanButton {
    return Intl.message(
      'Free Trial',
      name: 'freePlanButton',
      desc: '',
      args: [],
    );
  }

  /// `From the end of the free period`
  String get afterFree {
    return Intl.message(
      'From the end of the free period',
      name: 'afterFree',
      desc: '',
      args: [],
    );
  }

  /// `Restore Subscriptions`
  String get restoreButton {
    return Intl.message(
      'Restore Subscriptions',
      name: 'restoreButton',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Use`
  String get termsOfUse {
    return Intl.message(
      'Terms of Use',
      name: 'termsOfUse',
      desc: '',
      args: [],
    );
  }

  /// `● The Free Trial is only available to first time Premium Plan subscribers. \nIf you do not cancel at least 24 hours before the end of the trial period, you will automatically be charged for the continued purchase.`
  String get freePlanDescription {
    return Intl.message(
      '● The Free Trial is only available to first time Premium Plan subscribers. \nIf you do not cancel at least 24 hours before the end of the trial period, you will automatically be charged for the continued purchase.',
      name: 'freePlanDescription',
      desc: '',
      args: [],
    );
  }

  /// `● If you wish to terminate your subscription, please cancel at least 24 hours prior to the end of your subscription period.`
  String get planUpdateDescription {
    return Intl.message(
      '● If you wish to terminate your subscription, please cancel at least 24 hours prior to the end of your subscription period.',
      name: 'planUpdateDescription',
      desc: '',
      args: [],
    );
  }

  /// `Save 2 months`
  String get value2Mont {
    return Intl.message(
      'Save 2 months',
      name: 'value2Mont',
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
