import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/domain_data.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/enum/bo.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';
import 'package:tcg_manager/helper/edit_record_helper.dart';
import 'package:tcg_manager/main.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/input_view_settings_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/provider/text_editing_controller_provider.dart';
import 'package:tcg_manager/repository/deck_repository.dart';
import 'package:tcg_manager/repository/record_repository.dart';
import 'package:tcg_manager/repository/tag_repository.dart';
import 'package:tcg_manager/state/input_view_settings_state.dart';
import 'package:tcg_manager/state/input_view_state.dart';

class InputViewNotifier extends StateNotifier<InputViewState> {
  InputViewNotifier(this.ref) : super(InputViewState(date: DateTime.now())) {
    init();
  }

  final Ref ref;

  void selectDateTime(DateTime date) {
    state = state.copyWith(date: date);
  }

  void inputDeck(String name, bool isUseDeck) {
    final deck = name == '' ? null : Deck(name: name);
    state = isUseDeck ? state.copyWith(useDeck: deck) : state.copyWith(opponentDeck: deck);
  }

  void selectDeck(DomainData deck, int empty, bool isUseDeck) {
    state = isUseDeck ? state.copyWith(useDeck: deck as Deck) : state.copyWith(opponentDeck: deck as Deck);
    ref.read(textEditingControllerNotifierProvider.notifier).setDeckController(deck.name, isUseDeck);
  }

  void inputTag(String name, int index) {
    _updateTags(Tag(name: name), index);
  }

  void selectTag(DomainData tag, int index) {
    _updateTags(tag as Tag, index);
    ref.read(textEditingControllerNotifierProvider.notifier).setTagController(tag.name, index);
  }

  void _updateTags(Tag tag, int index) {
    final newTags = [...state.tag];
    final tagsLength = newTags.length;

    if (tagsLength > index) {
      newTags[index] = tag;
    } else {
      for (var i = tagsLength - index; i < 0; i++) {
        newTags.add(Tag(name: ''));
      }
      newTags.add(tag);
    }
    state = state.copyWith(tag: newTags);
  }

  void selectWinLoss(WinLoss? winloss) {
    if (winloss != null) {
      state = state.copyWith(winLoss: winloss);
    }
  }

  void selectMatchWinLoss(WinLoss? winloss, int matchIndex) {
    switch (matchIndex) {
      case 1:
        state = state.copyWith(firstMatchWinLoss: winloss);
        break;
      case 2:
        state = state.copyWith(secondMatchWinLoss: winloss);
        break;
      case 3:
        state = state.copyWith(thirdMatchWinLoss: winloss);
        break;
    }
  }

  void selectFirstSecond(FirstSecond? firstSecond) {
    if (firstSecond != null) {
      state = state.copyWith(firstSecond: firstSecond);
    }
  }

  void selectMatchFirstSecond(FirstSecond? firstSecond, int matchIndex) {
    switch (matchIndex) {
      case 1:
        state = state.copyWith(firstMatchFirstSecond: firstSecond);
        break;
      case 2:
        state = state.copyWith(secondMatchFirstSecond: firstSecond);
        break;
      case 3:
        state = state.copyWith(thirdMatchFirstSecond: firstSecond);
        break;
    }
  }

  void inputMemo(String memo) {
    state = state.copyWith(memo: memo);
  }

  void inputImage(XFile image) {
    final newImages = [...state.images, image];
    state = state.copyWith(images: newImages);
  }

  void removeImage(int index) {
    final newImages = [...state.images];
    newImages.removeAt(index);
    state = state.copyWith(images: newImages);
  }

  Future<void> _saveDeck(bool isUseDeck, int? gameId) async {
    final deck = isUseDeck ? state.useDeck! : state.opponentDeck!;
    final checkDeck = await ref.read(editRecordHelper).checkIfSelectedDeckIsNew(deck.name);

    if (checkDeck.isNew) {
      final newDeck = deck.copyWith(gameId: gameId);
      final deckId = await ref.read(deckRepository).insert(newDeck);
      final updatedDeck = newDeck.copyWith(id: deckId);

      state = isUseDeck ? state.copyWith(useDeck: updatedDeck) : state.copyWith(opponentDeck: updatedDeck);
    } else {
      state = isUseDeck ? state.copyWith(useDeck: checkDeck.deck) : state.copyWith(opponentDeck: checkDeck.deck);
    }
  }

  Future _saveTag(int? gameId) async {
    if (state.tag.isEmpty) return;
    final List<Tag> newTags = [];
    for (final tag in state.tag) {
      if (tag.name == '') continue;
      final checkTag = await ref.read(editRecordHelper).checkIfSelectedTagIsNew(tag.name);
      if (checkTag.isNew) {
        final tagId = await ref.read(tagRepository).insert(tag.copyWith(gameId: gameId));
        final newTag = tag.copyWith(gameId: gameId, id: tagId);
        newTags.add(newTag);
      } else {
        newTags.add(checkTag.tag!);
      }
    }
    state = state.copyWith(tag: newTags);
  }

  void _updateRecordState({Record? updatedRecord}) {
    state = state.copyWith(record: updatedRecord ?? state.record);
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
    state = state.copyWith(record: state.record!.copyWith(thirdMatchFirstSecond: state.thirdMatchFirstSecond));
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

  Future _saveImage() async {
    final savePath = ref.read(imagePathProvider);
    for (final image in state.images) {
      await image.saveTo('$savePath/${image.name}');
    }
    final imagePaths = state.images.map((image) => image.name).toList();
    state = state.copyWith(record: state.record!.copyWith(imagePath: imagePaths));
  }

  Future init() async {
    final recordList = await ref.read(allRecordListProvider.future);
    final deckList = await ref.read(allDeckListProvider.future);
    final tagList = await ref.read(allTagListProvider.future);
    final inputViewSettings = ref.read(inputViewSettingsNotifierProvider);

    if (recordList.isNotEmpty) {
      final previousRecord = recordList.last;
      final previousUseDeck = deckList.firstWhere((deck) => deck.id == previousRecord.useDeckId);
      final previousOpponentDeck = deckList.firstWhere((deck) => deck.id == previousRecord.opponentDeckId);
      final previousTagList = tagList.where((tag) => previousRecord.tagId.contains(tag.id)).toList();

      setUpInitialState(inputViewSettings, previousUseDeck, previousOpponentDeck, previousTagList);
    } else {
      ref.read(textEditingControllerNotifierProvider.notifier).resetInputViewController();
      state = InputViewState(date: DateTime.now());
    }
  }

  void setUpInitialState(
      InputViewSettingsState inputViewSettings, Deck previousUseDeck, Deck previousOpponentDeck, List<Tag> previousTagList) {
    if (inputViewSettings.fixUseDeck) {
      ref.read(textEditingControllerNotifierProvider.notifier).setDeckController(previousUseDeck.name, true);
    }
    if (inputViewSettings.fixOpponentDeck) {
      ref.read(textEditingControllerNotifierProvider.notifier).setDeckController(previousOpponentDeck.name, false);
    }
    if (inputViewSettings.fixTag && previousTagList.isNotEmpty) {
      previousTagList.asMap().forEach((index, tag) {
        ref.read(textEditingControllerNotifierProvider.notifier).setTagController(tag.name, index);
      });
    }

    state = state.copyWith(
      useDeck: inputViewSettings.fixUseDeck ? previousUseDeck : null,
      opponentDeck: inputViewSettings.fixOpponentDeck ? previousOpponentDeck : null,
      tag: inputViewSettings.fixTag ? previousTagList : [],
    );
  }

  void resetView() {
    final fixUseDeck = ref.read(inputViewSettingsNotifierProvider).fixUseDeck;
    final fixOpponentDeck = ref.read(inputViewSettingsNotifierProvider).fixOpponentDeck;
    final fixTag = ref.read(inputViewSettingsNotifierProvider).fixTag;
    state = InputViewState(
      date: state.date,
      winLoss: state.winLoss,
      firstSecond: state.firstSecond,
      useDeck: fixUseDeck ? state.useDeck : null,
      opponentDeck: fixOpponentDeck ? state.opponentDeck : null,
      tag: fixTag ? state.tag : [],
    );
    ref.read(textEditingControllerNotifierProvider.notifier).resetInputViewController();
  }

  void resetViewAll() {
    state = InputViewState(date: DateTime.now());
    ref.read(textEditingControllerNotifierProvider.notifier).resetAllInputViewController();
  }

  Future<int> saveRecord(BO bo) async {
    if (state.useDeck == null || state.opponentDeck == null) return 0;
    final selectGameId = ref.read(selectGameNotifierProvider).selectGame!.id;

    await _saveDeck(true, selectGameId);
    if (state.useDeck!.name != state.opponentDeck!.name) {
      await _saveDeck(false, selectGameId);
    } else {
      state = state.copyWith(opponentDeck: state.useDeck);
    }

    await _saveTag(selectGameId);
    final tagIdList = state.tag.map((tag) => tag.id!).toList();

    if (bo == BO.bo3) {
      _calcFirstSecondBO3();
      _calcWinLossBO3();
    }

    final newRecord = Record(gameId: selectGameId);
    _updateRecordState(updatedRecord: newRecord);

    _saveDate();
    _saveFirstSecond();
    _saveWinLoss();

    if (bo == BO.bo3) {
      _saveFirstMatchFirstSecond();
      _saveSecondMatchFirstSecond();
      _saveThirdMatchFirstSecond();
      _saveFirstMatchWinLoss();
      _saveSecondMatchWinLoss();
      _saveThirdMatchWinLoss();
    }

    await _saveImage();

    _updateRecordState(
      updatedRecord: state.record!.copyWith(
        useDeckId: state.useDeck!.id,
        opponentDeckId: state.opponentDeck!.id,
        tagId: tagIdList,
        bo: bo,
        memo: state.memo,
      ),
    );

    final recordCount = await ref.read(recordRepository).insert(state.record!);
    return recordCount;
  }
}

final inputViewNotifierProvider = StateNotifierProvider<InputViewNotifier, InputViewState>(
  (ref) => InputViewNotifier(ref),
);
