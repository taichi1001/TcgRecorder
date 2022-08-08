import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/enum/bo.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';
import 'package:tcg_manager/helper/edit_record_helper.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/input_view_settings_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/provider/text_editing_controller_provider.dart';
import 'package:tcg_manager/repository/deck_repository.dart';
import 'package:tcg_manager/repository/record_repository.dart';
import 'package:tcg_manager/repository/tag_repository.dart';
import 'package:tcg_manager/state/input_view_state.dart';

class InputViewNotifier extends StateNotifier<InputViewState> {
  InputViewNotifier(this.read) : super(InputViewState(date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
    init();
  }

  final Reader read;

  void selectDateTime(DateTime date) {
    state = state.copyWith(date: date);
  }

  void inputUseDeck(String name) {
    if (name == '') {
      state = state.copyWith(useDeck: null);
    } else {
      final deck = Deck(deck: name);
      state = state.copyWith(useDeck: deck);
    }
  }

  void inputOpponentDeck(String name) {
    if (name == '') {
      state = state.copyWith(opponentDeck: null);
    } else {
      final deck = Deck(deck: name);
      state = state.copyWith(opponentDeck: deck);
    }
  }

  void selectUseDeck(Deck deck) {
    state = state.copyWith(useDeck: deck);
    read(textEditingControllerNotifierProvider.notifier).setUseDeckController(state.useDeck!.deck);
  }

  void selectOpponentDeck(Deck deck) {
    state = state.copyWith(opponentDeck: deck);
    read(textEditingControllerNotifierProvider.notifier).setOpponentDeckController(state.opponentDeck!.deck);
  }

  void inputTag(String name) {
    if (name == '') {
      state = state.copyWith(tag: null);
    } else {
      final tag = Tag(tag: name);
      state = state.copyWith(tag: tag);
    }
  }

  void selectTag(Tag tag) {
    state = state.copyWith(tag: tag);
    read(textEditingControllerNotifierProvider.notifier).setTagController(state.tag!.tag);
  }

  void selectWinLoss(WinLoss? winloss) {
    if (winloss != null) {
      state = state.copyWith(winLoss: winloss);
    }
  }

  void selectFirstMatchWinLoss(WinLoss? winloss) {
    state = state.copyWith(firstMatchWinLoss: winloss);
  }

  void selectSecondMatchWinLoss(WinLoss? winloss) {
    state = state.copyWith(secondMatchWinLoss: winloss);
  }

  void selectThirdMatchWinLoss(WinLoss? winloss) {
    state = state.copyWith(thirdMatchWinLoss: winloss);
  }

  void selectFirstSecond(FirstSecond? firstSecond) {
    if (firstSecond != null) {
      state = state.copyWith(firstSecond: firstSecond);
    }
  }

  void selectFirstMatchFirstSecond(FirstSecond? firstSecond) {
    state = state.copyWith(firstMatchFirstSecond: firstSecond);
  }

  void selectSecondMatchFirstSecond(FirstSecond? firstSecond) {
    state = state.copyWith(secondMatchFirstSecond: firstSecond);
  }

  void selectThirdMatchFirstSecond(FirstSecond? firstSecond) {
    state = state.copyWith(thirdMatchFirstSecond: firstSecond);
  }

  void inputMemo(String memo) {
    state = state.copyWith(memo: memo);
  }

  Future _saveUseDeck(int? gameId) async {
    final checkUseDeck = await read(editRecordHelper).checkIfSelectedUseDeckIsNew(state.useDeck!.deck);
    if (checkUseDeck.isNew) {
      state = state.copyWith(
        useDeck: state.useDeck!.copyWith(
          gameId: gameId,
        ),
      );
      final useDeckId = await read(deckRepository).insert(state.useDeck!);
      state = state.copyWith(
        useDeck: state.useDeck!.copyWith(
          deckId: useDeckId,
        ),
      );
    } else {
      state = state.copyWith(useDeck: checkUseDeck.deck);
    }
  }

  Future _saveOpoonentDeck(int? gameId) async {
    final checkOpponentDeck = await read(editRecordHelper).checkIfSelectedUseDeckIsNew(state.opponentDeck!.deck);
    if (checkOpponentDeck.isNew) {
      state = state.copyWith(
        opponentDeck: state.opponentDeck!.copyWith(
          gameId: gameId,
        ),
      );
      final opponentDeckId = await read(deckRepository).insert(state.opponentDeck!);
      state = state.copyWith(
        opponentDeck: state.opponentDeck!.copyWith(
          deckId: opponentDeckId,
        ),
      );
    } else {
      state = state.copyWith(opponentDeck: checkOpponentDeck.deck);
    }
  }

  Future _saveTag(int? gameId) async {
    if (state.tag == null) return;
    // Tagが新規だった場合,opponentDeckにgameIDを設定
    final checkTag = await read(editRecordHelper).checkIfSelectedTagIsNew(state.tag!.tag);
    if (checkTag.isNew) {
      state = state.copyWith(
        tag: state.tag!.copyWith(
          gameId: gameId,
        ),
      );
      final tagId = await read(tagRepository).insert(state.tag!);
      state = state.copyWith(
        tag: state.tag!.copyWith(
          tagId: tagId,
        ),
      );
    } else {
      state = state.copyWith(tag: checkTag.tag);
    }
  }

  void _saveDate() {
    final newRecord = state.record!.copyWith(date: state.date);
    state = state.copyWith(record: newRecord);
  }

  void _saveFirstSecond() {
    state = state.copyWith(record: state.record!.copyWith(firstSecond: state.firstSecond));
  }

  void _saveFirstMatchFirstSecond() {
    state = state.copyWith(record: state.record!.copyWith(firstMatchFirstSecond: state.firstMatchFirstSecond));
  }

  void _saveSecondMatchFirstSecond() {
    state = state.copyWith(record: state.record!.copyWith(secondMatchFirstSecond: state.secondMatchFirstSecond));
  }

  void _saveThirdMatchFirstSecond() {
    state = state.copyWith(record: state.record!.copyWith(thiredMatchFirstSecond: state.thirdMatchFirstSecond));
  }

  void _saveWinLoss() {
    state = state.copyWith(record: state.record!.copyWith(winLoss: state.winLoss));
  }

  void _saveFirstMatchWinLoss() {
    state = state.copyWith(record: state.record!.copyWith(firstMatchWinLoss: state.firstMatchWinLoss));
  }

  void _saveSecondMatchWinLoss() {
    state = state.copyWith(record: state.record!.copyWith(secondMatchWinLoss: state.secondMatchWinLoss));
  }

  void _saveThirdMatchWinLoss() {
    state = state.copyWith(record: state.record!.copyWith(thirdMatchWinLoss: state.thirdMatchWinLoss));
  }

  void _calcWinLossBO3() {
    final winLossList = [state.firstMatchWinLoss, state.secondMatchWinLoss, state.thirdMatchWinLoss];
    final winCount = winLossList.where((winLoss) => winLoss == WinLoss.win).length;
    final lossCount = winLossList.where((winLoss) => winLoss == WinLoss.loss).length;
    if (winCount > lossCount) state = state.copyWith(winLoss: WinLoss.win);
    if (winCount < lossCount) state = state.copyWith(winLoss: WinLoss.loss);
    if (winCount == lossCount) state = state.copyWith(winLoss: WinLoss.draw);
  }

  void _calcFirstSecondBO3() {
    final firstSecondList = [state.firstMatchFirstSecond, state.secondMatchFirstSecond, state.thirdMatchFirstSecond];
    final firstCount = firstSecondList.where((firstSecond) => firstSecond == FirstSecond.first).length;
    final secondCount = firstSecondList.where((firstSecond) => firstSecond == FirstSecond.second).length;
    if (firstCount > secondCount) state = state.copyWith(firstSecond: FirstSecond.first);
    if (firstCount < secondCount) state = state.copyWith(firstSecond: FirstSecond.second);
    if (firstCount == secondCount) state = state.copyWith(firstSecond: state.firstMatchFirstSecond!);
  }

  Future init() async {
    final recordList = await read(allRecordListProvider.future);
    final deckList = await read(allDeckListProvider.future);
    final tagList = await read(allTagListProvider.future);
    final inputViewSettings = read(inputViewSettingsNotifierProvider);
    final fixUseDeck = inputViewSettings.fixUseDeck;
    final fixOpponentDeck = inputViewSettings.fixOpponentDeck;
    final fixTag = inputViewSettings.fixTag;
    if (recordList.isNotEmpty) {
      final previousRecord = recordList.last;
      final previousUseDeck = deckList.firstWhere((deck) => deck.deckId == previousRecord.useDeckId);
      final previousOpponentDeck = deckList.firstWhere((deck) => deck.deckId == previousRecord.opponentDeckId);
      final previousTagList = tagList.where((tag) => tag.tagId == previousRecord.tagId).toList();
      Tag? previousTag;
      if (previousTagList.isNotEmpty) previousTag = previousTagList.last;
      state = state.copyWith(
        useDeck: fixUseDeck ? previousUseDeck : null,
        opponentDeck: fixOpponentDeck ? previousOpponentDeck : null,
        tag: fixTag ? previousTag : null,
      );
      if (fixUseDeck) read(textEditingControllerNotifierProvider.notifier).setUseDeckController(previousUseDeck.deck);
      if (fixOpponentDeck) read(textEditingControllerNotifierProvider.notifier).setOpponentDeckController(previousOpponentDeck.deck);
      if (fixTag && previousTag != null) read(textEditingControllerNotifierProvider.notifier).setTagController(previousTag.tag);
    }
  }

  void resetView() {
    final fixUseDeck = read(inputViewSettingsNotifierProvider).fixUseDeck;
    final fixOpponentDeck = read(inputViewSettingsNotifierProvider).fixOpponentDeck;
    final fixTag = read(inputViewSettingsNotifierProvider).fixTag;
    state = InputViewState(
      date: state.date,
      winLoss: state.winLoss,
      firstSecond: state.firstSecond,
      useDeck: fixUseDeck ? state.useDeck : null,
      opponentDeck: fixOpponentDeck ? state.opponentDeck : null,
      tag: fixTag ? state.tag : null,
    );
    read(textEditingControllerNotifierProvider.notifier).resetInputViewController();
  }

  Future<int> saveBO1() async {
    if (state.useDeck == null || state.opponentDeck == null) return 0;
    final selectGameId = read(selectGameNotifierProvider).selectGame!.gameId;
    await _saveUseDeck(selectGameId);
    if (state.useDeck!.deck == state.opponentDeck!.deck) {
      state = state.copyWith(opponentDeck: state.useDeck);
    } else {
      await _saveOpoonentDeck(selectGameId);
    }
    await _saveTag(selectGameId);
    // record登録
    final newRecord = Record(gameId: selectGameId);
    state = state.copyWith(record: newRecord);
    _saveDate();
    _saveFirstSecond();
    _saveWinLoss();

    // recordに各種データを設定
    state = state.copyWith(
      record: state.record!.copyWith(
        useDeckId: state.useDeck!.deckId,
        opponentDeckId: state.opponentDeck!.deckId,
        tagId: state.tag?.tagId,
        bo: BO.bo1,
        memo: state.memo,
      ),
    );

    final recordCount = await read(recordRepository).insert(state.record!);
    return recordCount;
  }

  Future saveBO3() async {
    if (state.useDeck == null || state.opponentDeck == null) return 0;
    final selectGameId = read(selectGameNotifierProvider).selectGame!.gameId;
    await _saveUseDeck(selectGameId);
    if (state.useDeck!.deck == state.opponentDeck!.deck) {
      state = state.copyWith(opponentDeck: state.useDeck);
    } else {
      await _saveOpoonentDeck(selectGameId);
    }
    await _saveTag(selectGameId);
    _calcFirstSecondBO3();
    _calcWinLossBO3();
    // record登録
    final newRecord = Record(gameId: selectGameId);
    state = state.copyWith(record: newRecord);
    _saveDate();
    _saveFirstSecond();
    _saveWinLoss();
    _saveFirstMatchFirstSecond();
    _saveSecondMatchFirstSecond();
    _saveThirdMatchFirstSecond();
    _saveFirstMatchWinLoss();
    _saveSecondMatchWinLoss();
    _saveThirdMatchWinLoss();
    // recordに各種データを設定
    state = state.copyWith(
      record: state.record!.copyWith(
        useDeckId: state.useDeck!.deckId,
        opponentDeckId: state.opponentDeck!.deckId,
        tagId: state.tag?.tagId,
        bo: BO.bo3,
        memo: state.memo,
      ),
    );
    final recordCount = await read(recordRepository).insert(state.record!);
    return recordCount;
  }
}

final inputViewNotifierProvider = StateNotifierProvider<InputViewNotifier, InputViewState>(
  (ref) => InputViewNotifier(ref.read),
);
