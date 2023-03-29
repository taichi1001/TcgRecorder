import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
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
import 'package:tcg_manager/repository/firestore_share_data_repository.dart';
import 'package:tcg_manager/repository/record_repository.dart';
import 'package:tcg_manager/repository/tag_repository.dart';
import 'package:tcg_manager/selector/game_share_data_selector.dart';
import 'package:tcg_manager/state/input_view_settings_state.dart';
import 'package:tcg_manager/state/input_view_state.dart';

class InputViewNotifier extends StateNotifier<InputViewState> {
  InputViewNotifier(this.ref, this.deckHandler, this.tagHandler) : super(InputViewState(date: DateTime.now())) {
    init();
  }

  final Ref ref;
  final DeckHandler deckHandler;
  final TagHandler tagHandler;

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

  Future _saveTag(int? gameId) async {
    if (state.tag.isEmpty) return;
    final List<Tag> newTags = await tagHandler.createNewTags(gameId, state.tag);
    state = state.copyWith(tag: newTags);
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
    if (ref.read(isShareGame)) {
      final share = await ref.read(gameFirestoreShareStreamProvider.future);
      List<String> imagePathList = [];
      for (final image in state.images) {
        final strageRef = FirebaseStorage.instance.ref().child('share_data/${share!.docName}/${image.name}');
        await strageRef.putFile(File(image.path));
        final url = await strageRef.getDownloadURL();
        imagePathList.add(url);
      }
      state = state.copyWith(record: state.record!.copyWith(imagePath: imagePathList));
    } else {
      final savePath = ref.read(imagePathProvider);
      for (final image in state.images) {
        await image.saveTo('$savePath/${image.name}');
      }
      final imagePaths = state.images.map((image) => image.name).toList();
      state = state.copyWith(record: state.record!.copyWith(imagePath: imagePaths));
    }
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

  Future _saveDecks(int? selectGameId) async {
    final useDeck = await deckHandler.saveDeck(true, selectGameId, state.useDeck!);
    state = state.copyWith(useDeck: useDeck);
    Deck opponentDeck;
    if (state.useDeck!.name != state.opponentDeck!.name) {
      opponentDeck = await deckHandler.saveDeck(false, selectGameId, state.opponentDeck!);
    } else {
      opponentDeck = state.useDeck!;
    }
    state = state.copyWith(opponentDeck: opponentDeck);
  }

  void _updateRecord(BO bo, int? selectGameId) {
    state = state.copyWith(
      record: Record(
        useDeckId: state.useDeck!.id,
        opponentDeckId: state.opponentDeck!.id,
        tagId: state.tag.map((tag) => tag.id!).toList(),
        bo: bo,
        memo: state.memo,
        gameId: selectGameId,
        date: state.date,
        firstSecond: state.firstSecond,
        winLoss: state.winLoss,
      ),
    );

    if (bo == BO.bo3) {
      _calcFirstSecondBO3();
      _calcWinLossBO3();
      state = state.copyWith(
        record: state.record!.copyWith(
          firstMatchFirstSecond: state.firstMatchFirstSecond,
          secondMatchFirstSecond: state.secondMatchFirstSecond,
          thirdMatchFirstSecond: state.thirdMatchFirstSecond,
          firstMatchWinLoss: state.firstMatchWinLoss,
          secondMatchWinLoss: state.secondMatchWinLoss,
          thirdMatchWinLoss: state.thirdMatchWinLoss,
        ),
      );
    }
  }

  Future _saveRecordToRepository() async {
    final isShare = ref.read(isShareGame);
    if (isShare) {
      final share = await ref.read(gameFirestoreShareStreamProvider.future);
      ref.read(firestoreShareDataRepository).addRecord(state.record!, share!.docName);
    } else {
      await ref.read(recordRepository).insert(state.record!);
    }
  }

  Future saveRecord(BO bo) async {
    if (state.useDeck == null || state.opponentDeck == null) return;
    final selectGameId = ref.read(selectGameNotifierProvider).selectGame!.id;

    await _saveDecks(selectGameId);
    await _saveTag(selectGameId);
    _updateRecord(bo, selectGameId);
    await _saveImage();
    await _saveRecordToRepository();
  }
}

final inputViewNotifierProvider = StateNotifierProvider<InputViewNotifier, InputViewState>(
  (ref) => InputViewNotifier(
    ref,
    DeckHandler(ref),
    TagHandler(ref),
  ),
);

class DeckHandler {
  final Ref ref;

  DeckHandler(this.ref);

  Future<Deck> saveDeck(bool isUseDeck, int? gameId, Deck deck) async {
    final existingDeck = await ref.read(editRecordHelper).checkIfSelectedDeckIsNew(deck.name);

    if (existingDeck.isNew) {
      return await createNewDeck(deck, gameId);
    } else {
      return existingDeck.deck!;
    }
  }

  Future<Deck> createNewDeck(Deck deck, int? gameId) async {
    final newDeck = deck.copyWith(gameId: gameId);
    final isShare = ref.read(isShareGame);
    int? deckId;
    if (isShare) {
      final share = await ref.read(gameFirestoreShareStreamProvider.future);
      deckId = await ref.read(firestoreShareDataRepository).addDeck(newDeck, share!.docName);
    } else {
      deckId = await ref.read(deckRepository).insert(newDeck);
    }
    return newDeck.copyWith(id: deckId);
  }
}

class TagHandler {
  final Ref ref;

  TagHandler(this.ref);

  Future saveTag(int? gameId, List<Tag> tagList) async {
    if (tagList.isEmpty) return;
    return await createNewTags(gameId, tagList);
  }

  Future<List<Tag>> createNewTags(int? gameId, List<Tag> tagList) async {
    final List<Tag> newTags = [];
    for (final tag in tagList) {
      if (tag.name == '') continue;
      final existingTag = await ref.read(editRecordHelper).checkIfSelectedTagIsNew(tag.name);
      if (existingTag.isNew) {
        newTags.add(await createNewTag(tag, gameId));
      } else {
        newTags.add(existingTag.tag!);
      }
    }
    return newTags;
  }

  Future<Tag> createNewTag(Tag tag, int? gameId) async {
    final newTag = tag.copyWith(gameId: gameId);
    final isShare = ref.read(isShareGame);
    int? tagId;
    if (isShare) {
      final share = await ref.read(gameFirestoreShareStreamProvider.future);
      tagId = await ref.read(firestoreShareDataRepository).addTag(newTag, share!.docName);
    } else {
      tagId = await ref.read(tagRepository).insert(newTag);
    }
    tag = tag.copyWith(gameId: gameId, id: tagId);
    return tag;
  }
}
