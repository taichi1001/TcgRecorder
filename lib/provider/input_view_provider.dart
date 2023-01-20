import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcg_manager/entity/deck.dart';
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
import 'package:tcg_manager/state/input_view_state.dart';

class InputViewNotifier extends StateNotifier<InputViewState> {
  InputViewNotifier(this.ref) : super(InputViewState(date: DateTime.now())) {
    init();
  }

  final Ref ref;

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
    ref.read(textEditingControllerNotifierProvider.notifier).setUseDeckController(state.useDeck!.deck);
  }

  void selectOpponentDeck(Deck deck) {
    state = state.copyWith(opponentDeck: deck);
    ref.read(textEditingControllerNotifierProvider.notifier).setOpponentDeckController(state.opponentDeck!.deck);
  }

  void inputTag(String name, int index) {
    final tag = Tag(tag: name);
    final newTags = [...state.tag];
    if (newTags.length > index) {
      newTags[index] = tag;
    } else if (newTags.length - index <= 0) {
      for (var i = newTags.length - index; i < 0; i++) {
        newTags.add(Tag(tag: ''));
      }
      newTags.add(tag);
    }
    state = state.copyWith(tag: newTags);
  }

  void selectTag(Tag tag, int index) {
    final newTags = [...state.tag];
    if (newTags.length > index) {
      newTags[index] = tag;
    } else if (newTags.length - index <= 0) {
      for (var i = newTags.length - index; i < 0; i++) {
        newTags.add(Tag(tag: ''));
      }
      newTags.add(tag);
    }
    state = state.copyWith(tag: newTags);
    ref.read(textEditingControllerNotifierProvider.notifier).setTagController(state.tag[index].tag, index);
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

  void inputImage(XFile image) {
    final newImages = [...state.images, image];
    state = state.copyWith(images: newImages);
  }

  void removeImage(int index) {
    final newImages = [...state.images];
    newImages.removeAt(index);
    state = state.copyWith(images: newImages);
  }

  Future _saveUseDeck(int? gameId) async {
    final checkUseDeck = await ref.read(editRecordHelper).checkIfSelectedUseDeckIsNew(state.useDeck!.deck);
    if (checkUseDeck.isNew) {
      state = state.copyWith(
        useDeck: state.useDeck!.copyWith(
          gameId: gameId,
        ),
      );
      final useDeckId = await ref.read(deckRepository).insert(state.useDeck!);
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
    final checkOpponentDeck = await ref.read(editRecordHelper).checkIfSelectedUseDeckIsNew(state.opponentDeck!.deck);
    if (checkOpponentDeck.isNew) {
      state = state.copyWith(
        opponentDeck: state.opponentDeck!.copyWith(
          gameId: gameId,
        ),
      );
      final opponentDeckId = await ref.read(deckRepository).insert(state.opponentDeck!);
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
    if (state.tag.isEmpty) return;
    final List<Tag> newTags = [];
    for (final tag in state.tag) {
      if (tag.tag == '') continue;
      final checkTag = await ref.read(editRecordHelper).checkIfSelectedTagIsNew(tag.tag);
      if (checkTag.isNew) {
        final tagId = await ref.read(tagRepository).insert(tag.copyWith(gameId: gameId));
        final newTag = tag.copyWith(gameId: gameId, tagId: tagId);
        newTags.add(newTag);
      } else {
        newTags.add(checkTag.tag!);
      }
    }
    state = state.copyWith(tag: newTags);
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
    final fixUseDeck = inputViewSettings.fixUseDeck;
    final fixOpponentDeck = inputViewSettings.fixOpponentDeck;
    final fixTag = inputViewSettings.fixTag;
    if (recordList.isNotEmpty) {
      final previousRecord = recordList.last;
      final previousUseDeck = deckList.firstWhere((deck) => deck.deckId == previousRecord.useDeckId);
      final previousOpponentDeck = deckList.firstWhere((deck) => deck.deckId == previousRecord.opponentDeckId);

      final List<Tag> previousTagList = [];
      for (final tagId in previousRecord.tagId) {
        final previousTag = tagList.firstWhere((tag) => tag.tagId == tagId);
        previousTagList.add(previousTag);
      }
      state = state.copyWith(
        useDeck: fixUseDeck ? previousUseDeck : null,
        opponentDeck: fixOpponentDeck ? previousOpponentDeck : null,
        tag: fixTag ? previousTagList : [],
      );
      if (fixUseDeck) ref.read(textEditingControllerNotifierProvider.notifier).setUseDeckController(previousUseDeck.deck);
      if (fixOpponentDeck) ref.read(textEditingControllerNotifierProvider.notifier).setOpponentDeckController(previousOpponentDeck.deck);
      if (fixTag && previousTagList.isNotEmpty) {
        previousTagList.asMap().forEach((index, tag) {
          ref.read(textEditingControllerNotifierProvider.notifier).setTagController(tag.tag, index);
        });
      }
    }
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

  Future<int> saveBO1() async {
    if (state.useDeck == null || state.opponentDeck == null) return 0;
    final selectGameId = ref.read(selectGameNotifierProvider).selectGame!.gameId;
    await _saveUseDeck(selectGameId);
    if (state.useDeck!.deck == state.opponentDeck!.deck) {
      state = state.copyWith(opponentDeck: state.useDeck);
    } else {
      await _saveOpoonentDeck(selectGameId);
    }
    await _saveTag(selectGameId);
    final tagIdList = state.tag.map((tag) => tag.tagId!).toList();

    // record登録
    final newRecord = Record(gameId: selectGameId);
    state = state.copyWith(record: newRecord);
    _saveDate();
    _saveFirstSecond();
    _saveWinLoss();
    await _saveImage();

    // recordに各種データを設定
    state = state.copyWith(
      record: state.record!.copyWith(
        useDeckId: state.useDeck!.deckId,
        opponentDeckId: state.opponentDeck!.deckId,
        tagId: tagIdList,
        bo: BO.bo1,
        memo: state.memo,
      ),
    );
    final recordCount = await ref.read(recordRepository).insert(state.record!);
    return recordCount;
  }

  Future saveBO3() async {
    if (state.useDeck == null || state.opponentDeck == null) return 0;
    final selectGameId = ref.read(selectGameNotifierProvider).selectGame!.gameId;
    await _saveUseDeck(selectGameId);
    if (state.useDeck!.deck == state.opponentDeck!.deck) {
      state = state.copyWith(opponentDeck: state.useDeck);
    } else {
      await _saveOpoonentDeck(selectGameId);
    }
    await _saveTag(selectGameId);
    final tagIdList = state.tag.map((tag) => tag.tagId!).toList();

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
    await _saveImage();
    // recordに各種データを設定
    state = state.copyWith(
      record: state.record!.copyWith(
        useDeckId: state.useDeck!.deckId,
        opponentDeckId: state.opponentDeck!.deckId,
        tagId: tagIdList,
        bo: BO.bo3,
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
