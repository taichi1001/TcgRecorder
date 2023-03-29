import 'dart:io';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/domain_data.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/enum/bo.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';
import 'package:tcg_manager/helper/db_helper.dart';
import 'package:tcg_manager/helper/edit_record_helper.dart';
import 'package:tcg_manager/main.dart';
import 'package:tcg_manager/provider/backup_provider.dart';
import 'package:tcg_manager/repository/deck_repository.dart';
import 'package:tcg_manager/provider/firestore_backup_controller_provider.dart';
import 'package:tcg_manager/repository/firestore_share_data_repository.dart';
import 'package:tcg_manager/repository/record_repository.dart';
import 'package:tcg_manager/repository/tag_repository.dart';
import 'package:tcg_manager/selector/game_share_data_selector.dart';
import 'package:tcg_manager/selector/sorted_record_list_selector.dart';
import 'package:tcg_manager/state/record_detail_state.dart';

class RecordEditViewNotifier extends StateNotifier<RecordEditViewState> {
  RecordEditViewNotifier({
    required this.ref,
    required this.record,
    required this.margedRecord,
    required this.imagePath,
  }) : super(
          RecordEditViewState(
              record: record,
              margedRecord: margedRecord,
              editMargedRecord: margedRecord,
              images: margedRecord.imagePaths == null ? [] : margedRecord.imagePaths!.map((e) => XFile('$imagePath/$e')).toList()),
        );

  final Ref ref;
  final Record record;
  final MargedRecord margedRecord;
  final String imagePath;

  void changeIsEdit() {
    state = state.copyWith(isEdit: !state.isEdit);
  }

  void editUseDeck(String name) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(useDeck: name));
  }

  void selectUseDeck(DomainData deck, int empty) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(useDeck: deck.name));
  }

  void editOpponentDeck(String name) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(opponentDeck: name));
  }

  void selectOpponentDeck(DomainData deck, int empty) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(opponentDeck: deck.name));
  }

  void editTag(String name, int index) {
    final newTags = [...state.editMargedRecord.tag];
    if (newTags.length > index) {
      newTags[index] = name;
    } else if (newTags.length - index <= 0) {
      for (var i = newTags.length - index; i < 0; i++) {
        newTags.add('');
      }
      newTags.add(name);
    }
    state = state.copyWith(
      editMargedRecord: state.editMargedRecord.copyWith(
        tag: newTags,
      ),
    );
  }

  void selectTag(DomainData tag, int index) {
    final newTags = [...state.editMargedRecord.tag];
    if (newTags.length > index) {
      newTags[index] = tag.name;
    } else if (newTags.length - index <= 0) {
      for (var i = newTags.length - index; i < 0; i++) {
        newTags.add('');
      }
      newTags.add(tag.name);
    }
    state = state.copyWith(
      editMargedRecord: state.editMargedRecord.copyWith(
        tag: newTags,
      ),
    );
  }

  void selectDateTime(DateTime date) {
    state = state.copyWith(
      editMargedRecord: state.editMargedRecord.copyWith(
        date: date,
      ),
    );
  }

  void editWinLoss(WinLoss? winnLoss) {
    if (winnLoss == null) return;
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(winLoss: winnLoss));
  }

  void editFirstMatchWinLoss(WinLoss? winnLoss) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(firstMatchWinLoss: winnLoss));
  }

  void editSecondMatchWinLoss(WinLoss? winnLoss) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(secondMatchWinLoss: winnLoss));
  }

  void editThirdMatchWinLoss(WinLoss? winnLoss) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(thirdMatchWinLoss: winnLoss));
  }

  void editFirstSecond(FirstSecond? firstSecond) {
    if (firstSecond == null) return;
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(firstSecond: firstSecond));
  }

  void editFirstMatchFirstSecond(FirstSecond? firstSecond) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(firstMatchFirstSecond: firstSecond));
  }

  void editSecondMatchFirstSecond(FirstSecond? firstSecond) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(secondMatchFirstSecond: firstSecond));
  }

  void editThirdMatchFirstSecond(FirstSecond? firstSecond) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(thirdMatchFirstSecond: firstSecond));
  }

  void editMemo(String memo) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(memo: memo));
  }

  void inputImage(XFile image) {
    final newImages = [...state.images, image];
    final newAddImages = [...state.addImages, image];
    state = state.copyWith(
      images: newImages,
      addImages: newAddImages,
    );
  }

  void removeImage(int index) {
    final newImages = [...state.images];
    final removeImage = newImages.removeAt(index);
    final newRemoveImages = [...state.removeImages, removeImage];
    state = state.copyWith(
      images: newImages,
      removeImages: newRemoveImages,
    );
  }

  RecordEditViewState _updateRecord(BO bo, {required bool isBO3}) {
    return state.copyWith(
      record: state.record.copyWith(
        bo: bo,
        date: state.editMargedRecord.date,
        winLoss: isBO3 ? state.margedRecord.winLoss : state.editMargedRecord.winLoss,
        firstSecond: isBO3 ? state.margedRecord.firstSecond : state.editMargedRecord.firstSecond,
        memo: state.editMargedRecord.memo,
        firstMatchFirstSecond: isBO3 ? state.margedRecord.firstMatchFirstSecond : null,
        secondMatchFirstSecond: isBO3 ? state.margedRecord.secondMatchFirstSecond : null,
        thirdMatchFirstSecond: isBO3 ? state.margedRecord.thirdMatchFirstSecond : null,
        firstMatchWinLoss: isBO3 ? state.margedRecord.firstMatchWinLoss : null,
        secondMatchWinLoss: isBO3 ? state.margedRecord.secondMatchWinLoss : null,
        thirdMatchWinLoss: isBO3 ? state.margedRecord.thirdMatchWinLoss : null,
      ),
    );
  }

  Future saveEditRecord({required bool isBO3}) async {
    state = state.copyWith(margedRecord: state.editMargedRecord);
    await _saveEditUseDeck();
    await _saveEditOpponentDeck();
    await _saveEditTag();
    await _saveImage();

    if (isBO3) {
      _calcFirstSecondBO3();
      _calcWinLossBO3();
    }
    state = _updateRecord(isBO3 ? BO.bo3 : BO.bo1, isBO3: isBO3);

    final isShare = ref.read(isShareGame);
    if (isShare) {
      final share = await ref.read(gameFirestoreShareStreamProvider.future);
      await ref.read(firestoreShareDataRepository).updateRecord(state.record, share!.docName);
    } else {
      await ref.read(recordRepository).update(state.record);
      await ref.read(dbHelper).fetchAll();
    }
    if (ref.read(backupNotifierProvider)) {
      await ref.read(firestoreBackupControllerProvider).editRecord(state);
    }
  }

  void _calcWinLossBO3() {
    final winLossList = [
      state.editMargedRecord.firstMatchWinLoss,
      state.editMargedRecord.secondMatchWinLoss,
      state.editMargedRecord.thirdMatchWinLoss
    ];
    final winCount = winLossList.where((winLoss) => winLoss == WinLoss.win).length;
    final lossCount = winLossList.where((winLoss) => winLoss == WinLoss.loss).length;
    if (winCount > lossCount) {
      state = state.copyWith(
        margedRecord: state.margedRecord.copyWith(
          winLoss: WinLoss.win,
        ),
      );
    }
    if (winCount < lossCount) {
      state = state.copyWith(
        margedRecord: state.margedRecord.copyWith(
          winLoss: WinLoss.loss,
        ),
      );
    }
    if (winCount == lossCount) {
      state = state.copyWith(
        margedRecord: state.margedRecord.copyWith(
          winLoss: WinLoss.draw,
        ),
      );
    }
  }

  void _calcFirstSecondBO3() {
    final firstSecondList = [
      state.editMargedRecord.firstMatchFirstSecond,
      state.editMargedRecord.secondMatchFirstSecond,
      state.editMargedRecord.thirdMatchFirstSecond
    ];
    final firstCount = firstSecondList.where((firstSecond) => firstSecond == FirstSecond.first).length;
    final secondCount = firstSecondList.where((firstSecond) => firstSecond == FirstSecond.second).length;
    if (firstCount > secondCount) {
      state = state.copyWith(
        margedRecord: state.margedRecord.copyWith(
          firstSecond: FirstSecond.first,
        ),
      );
    }
    if (firstCount < secondCount) {
      state = state.copyWith(
        margedRecord: state.margedRecord.copyWith(
          firstSecond: FirstSecond.second,
        ),
      );
    }
    if (firstCount == secondCount) {
      state = state.copyWith(
        margedRecord: state.margedRecord.copyWith(
          firstSecond: state.editMargedRecord.firstMatchFirstSecond!,
        ),
      );
    }
  }

  Future<int> _registerNewDeck(String deckName) async {
    final isShare = ref.read(isShareGame);
    if (isShare) {
      final share = await ref.read(gameFirestoreShareStreamProvider.future);
      return await ref.read(firestoreShareDataRepository).addDeck(
            Deck(
              name: deckName,
              gameId: state.record.gameId,
            ),
            share!.docName,
          );
    } else {
      return await ref.read(deckRepository).insert(
            Deck(
              name: deckName,
              gameId: state.record.gameId,
            ),
          );
    }
  }

  Future<int> _getDeckId(String deckName) async {
    final checkDeck = await ref.read(editRecordHelper).checkIfSelectedDeckIsNew(deckName);
    if (checkDeck.isNew) {
      return await _registerNewDeck(deckName);
    } else {
      return checkDeck.deck!.id!;
    }
  }

  Future _saveEditDeck(String deckName, bool isUseDeck) async {
    final newDeckId = await _getDeckId(deckName);

    // recordに新しいデッキIDを登録
    if (isUseDeck) {
      state = state.copyWith(record: state.record.copyWith(useDeckId: newDeckId));
    } else {
      state = state.copyWith(record: state.record.copyWith(opponentDeckId: newDeckId));
    }
  }

  Future _saveEditUseDeck() async {
    await _saveEditDeck(state.margedRecord.useDeck, true);
  }

  Future _saveEditOpponentDeck() async {
    await _saveEditDeck(state.margedRecord.opponentDeck, false);
  }

  Future<int> _registerNewTag(String tagName) async {
    final isShare = ref.read(isShareGame);
    if (isShare) {
      final share = await ref.read(gameFirestoreShareStreamProvider.future);
      final newId = await ref.read(firestoreShareDataRepository).addTag(
            Tag(name: tagName, gameId: state.record.gameId),
            share!.docName,
          );
      return newId;
    } else {
      return await ref.read(tagRepository).insert(
            Tag(name: tagName, gameId: state.record.gameId),
          );
    }
  }

  Future<int> _getTagId(String tagName) async {
    final checkTag = await ref.read(editRecordHelper).checkIfSelectedTagIsNew(tagName);
    if (checkTag.isNew) {
      return await _registerNewTag(tagName);
    } else {
      return checkTag.tag!.id!;
    }
  }

  Future _saveEditTag() async {
    if (state.margedRecord.tag.isEmpty) return;

    final newTags = <int>[];
    for (final tag in state.margedRecord.tag) {
      if (tag == '') continue;
      final newTagId = await _getTagId(tag);
      newTags.add(newTagId);
    }

    state = state.copyWith(record: state.record.copyWith(tagId: newTags));
  }

  Future _saveImage() async {
    final savePath = ref.read(imagePathProvider);

    //　アプリ内で削除した画像を実際に削除する場所
    final removeImagePaths = state.removeImages.map((image) => '$savePath/${image.name}').toList();
    for (final path in removeImagePaths) {
      final dir = Directory(path);
      dir.deleteSync(recursive: true);
    }
    for (final image in state.images) {
      await image.saveTo('$savePath/${image.name}');
    }
    final imagePaths = state.images.map((image) => image.name).toList();
    state = state.copyWith(record: state.record.copyWith(imagePath: imagePaths));
  }
}

final recordListProvider = Provider.autoDispose<List<Record>>((ref) {
  ref.keepAlive();
  final recordList = ref.watch(sortedRecordListProvider);
  final state = recordList.when(
    data: (recordList) => recordList,
    error: (_, __) => [],
    loading: () => [],
  );
  return state.cast();
});

final recordEditViewNotifierProvider =
    StateNotifierProvider.family.autoDispose<RecordEditViewNotifier, RecordEditViewState, MargedRecord>((ref, margedRecord) {
  final recordList = ref.watch(recordListProvider);
  final record = recordList.firstWhere((record) => record.recordId == margedRecord.recordId);
  final imagePath = ref.read(imagePathProvider);
  return RecordEditViewNotifier(ref: ref, record: record, margedRecord: margedRecord, imagePath: imagePath);
});
