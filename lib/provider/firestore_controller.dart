import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/repository/firestore_repository.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/helper/db_helper.dart';
import 'package:tcg_manager/main.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/repository/deck_repository.dart';
import 'package:tcg_manager/repository/game_repository.dart';
import 'package:tcg_manager/repository/record_repository.dart';
import 'package:tcg_manager/repository/tag_repository.dart';
import 'package:tcg_manager/state/record_detail_state.dart';

final firestoreController = Provider.autoDispose<FirestoreController>((ref) => FirestoreController(ref));

class FirestoreController {
  FirestoreController(this.ref);

  final Ref ref;

  late final isUser = ref.read(firebaseAuthNotifierProvider).user != null;

  FirestoreRepository get firestoreRepo => ref.read(firestoreRepository);

  Future addAll() async {
    if (!isUser) return;
    await _setAll();
    await _deleteAllImage();
    await _saveAllImage();
  }

  Future addRecord(Record record) async {
    if (!isUser) return;
    _setAll();
    if (record.imagePath == null || record.imagePath!.isEmpty) return;
    for (final imagePath in record.imagePath!) {
      await _saveImage(imagePath);
    }
  }

  Future deleteRecord(Record record) async {
    if (!isUser) return;
    _setAll();
    if (record.imagePath == null || record.imagePath!.isEmpty) return;
    for (final imagePath in record.imagePath!) {
      await _deleteImage(imagePath);
    }
  }

  Future editRecord(RecordDetailState recordDetailState) async {
    if (!isUser) return;
    _setAll();
    if (recordDetailState.addImages.isEmpty && recordDetailState.removeImages.isEmpty) return;
    for (final imagePath in recordDetailState.addImages) {
      await _saveImage(imagePath.name);
    }
    for (final imagePath in recordDetailState.removeImages) {
      await _deleteImage(imagePath.name);
    }
  }

  Future<bool> restoreAll() async {
    final user = ref.read(firebaseAuthNotifierProvider).user?.uid;
    if (user == null) return false;
    final allData = await firestoreRepo.getAll(user);
    if (allData == null) return false;
    final gameJson = allData['game'] as List;
    final gameList = gameJson.map((e) => Game.fromJson(e)).toList();
    final deckJson = allData['deck'] as List;
    final deckList = deckJson.map((e) => Deck.fromJson(e)).toList();
    final tagJson = allData['tag'] as List;
    final tagList = tagJson.map((e) => Tag.fromJson(e)).toList();
    final recordJson = allData['record'] as List;
    final recordList = recordJson.map((e) => Record.fromJson(e)).toList();

    await ref.read(dbHelper).deleteAll();

    await ref.read(gameRepository).insertList(gameList);
    await ref.read(deckRepository).insertList(deckList);
    await ref.read(tagRepository).insertList(tagList);
    await ref.read(recordRepository).insertList(recordList);

    await ref.read(dbHelper).fetchAll();
    await _restoreImage();
    return true;
  }

  Future _setAll() async {
    final record = await ref.read(allRecordListProvider.future);
    final deck = await ref.read(allDeckListProvider.future);
    final tag = await ref.read(allTagListProvider.future);
    final game = await ref.read(allGameListProvider.future);
    final user = ref.read(firebaseAuthNotifierProvider).user?.uid;

    if (!isUser) return;
    await firestoreRepo.setAll(
      {
        'game': game.map((e) => e.toJson()).toList(),
        'deck': deck.map((e) => e.toJson()).toList(),
        'tag': tag.map((e) => e.toJson()).toList(),
        'record': record.map((e) => e.toJson()).toList(),
      },
      user!,
    );
  }

  Future _saveImage(String imagePath) async {
    final strageRef = FirebaseStorage.instance.ref().child('user/${ref.read(firebaseAuthNotifierProvider).user?.uid}/$imagePath');
    final savePath = ref.read(imagePathProvider);
    final file = File('$savePath/$imagePath');
    await strageRef.putFile(file);
  }

  Future _saveAllImage() async {
    final allRecordList = await ref.read(allRecordListProvider.future);
    final isImageRecordList = allRecordList.where((record) => record.imagePath != null && record.imagePath!.isNotEmpty).toList();
    for (final record in isImageRecordList) {
      for (final imagePath in record.imagePath!) {
        _saveImage(imagePath);
      }
    }
  }

  Future _restoreImage() async {
    final allRecordList = await ref.read(allRecordListProvider.future);
    final isImageRecordList = allRecordList.where((record) => record.imagePath != null && record.imagePath!.isNotEmpty).toList();
    for (final record in isImageRecordList) {
      for (final imagePath in record.imagePath!) {
        final strageRef = FirebaseStorage.instance.ref().child('user/${ref.read(firebaseAuthNotifierProvider).user?.uid}/$imagePath');
        final savePath = ref.read(imagePathProvider);
        final file = File('$savePath/$imagePath');
        await strageRef.writeToFile(file);
      }
    }
  }

  Future _deleteImage(String imagePath) async {
    final strageRef = FirebaseStorage.instance.ref().child('user/${ref.read(firebaseAuthNotifierProvider).user!.uid}/$imagePath');
    await strageRef.delete();
  }

  Future _deleteAllImage() async {
    final firebaseRef = FirebaseStorage.instance.ref().child('user/${ref.read(firebaseAuthNotifierProvider).user!.uid}');
    final list = await firebaseRef.listAll();
    for (final item in list.items) {
      await item.delete();
    }
  }
}
