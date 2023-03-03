import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/firestore_backup.dart';
import 'package:tcg_manager/repository/firestore_repository.dart';
import 'package:tcg_manager/entity/record.dart';
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

final lastBackup = StateProvider.autoDispose<DateTime?>(((ref) => ref.read(firestoreController).loadLastBackupDate()));

class FirestoreController {
  FirestoreController(this.ref);

  final Ref ref;

  late final isUser = ref.read(firebaseAuthNotifierProvider).user != null;

  FirestoreRepository get firestoreRepo => ref.read(firestoreRepository);

  Future addAll() async {
    if (!isUser) return;
    await _setAll();
    await deleteAllImage();
    await _saveAllImage();
    await saveLastBackup();
  }

  Future addRecord(Record record) async {
    if (!isUser) return;
    _setAll();
    if (record.imagePath == null || record.imagePath!.isEmpty) return;
    for (final imagePath in record.imagePath!) {
      await _saveImage(imagePath);
    }
    await saveLastBackup();
  }

  Future deleteRecord(Record record) async {
    if (!isUser) return;
    _setAll();
    if (record.imagePath == null || record.imagePath!.isEmpty) return;
    for (final imagePath in record.imagePath!) {
      await _deleteImage(imagePath);
    }
    await saveLastBackup();
  }

  Future editRecord(RecordEditViewState recordDetailState) async {
    if (!isUser) return;
    _setAll();
    if (recordDetailState.addImages.isEmpty && recordDetailState.removeImages.isEmpty) return;
    for (final imagePath in recordDetailState.addImages) {
      await _saveImage(imagePath.name);
    }
    for (final imagePath in recordDetailState.removeImages) {
      await _deleteImage(imagePath.name);
    }
    await saveLastBackup();
  }

  Future<bool> restoreAll() async {
    final user = ref.read(firebaseAuthNotifierProvider).user?.uid;
    if (user == null) return false;
    final backup = await firestoreRepo.getAll(user);
    await _setLastBackup(backup.lastBackup);
    await ref.read(dbHelper).deleteAll();
    await ref.read(gameRepository).insertList(backup.gameList);
    await ref.read(deckRepository).insertList(backup.deckList);
    await ref.read(tagRepository).insertList(backup.tagList);
    await ref.read(recordRepository).insertList(backup.recordList);
    await ref.read(dbHelper).fetchAll();
    await _restoreImage();
    return true;
  }

  Future saveLastBackup() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString('lastBackup', DateTime.now().toString());
    ref.read(lastBackup.notifier).state = loadLastBackupDate();
  }

  Future _setLastBackup(DateTime? date) async {
    if (date == null) return;
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString('lastBackup', date.toString());
    ref.read(lastBackup.notifier).state = date;
  }

  DateTime? loadLastBackupDate() {
    final prefs = ref.read(sharedPreferencesProvider);
    final lastBackupString = prefs.getString('lastBackup');
    return lastBackupString != null ? DateTime.parse(lastBackupString) : null;
  }

  Future _setAll() async {
    final record = await ref.read(allRecordListProvider.future);
    final deck = await ref.read(allDeckListProvider.future);
    final tag = await ref.read(allTagListProvider.future);
    final game = await ref.read(allGameListProvider.future);
    final user = ref.read(firebaseAuthNotifierProvider).user?.uid;
    final backup = FirestoreBackup(
      gameList: game,
      deckList: deck,
      tagList: tag,
      recordList: record,
      lastBackup: DateTime.now(),
    );
    if (!isUser) return;
    await firestoreRepo.setAll(backup, user!);
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

  Future deleteAllImage() async {
    final firebaseRef = FirebaseStorage.instance.ref().child('user/${ref.read(firebaseAuthNotifierProvider).user!.uid}');
    final list = await firebaseRef.listAll();
    for (final item in list.items) {
      await item.delete();
    }
  }
}
