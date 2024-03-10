import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/repository/firestore_public_user_data_repository.dart';
import 'package:tcg_manager/service/database.dart';

final recordRepository = Provider.autoDispose<RecordRepository>((ref) => RecordRepository(ref));

class RecordRepository {
  RecordRepository(this.ref);

  final Ref ref;
  final dbProvider = DatabaseService.dbProvider;
  final tableName = DatabaseService.recordTableName;

  Future<List<Record>> getAll() async {
    final db = await dbProvider.database;
    final result = await db.query(tableName);
    return result.isNotEmpty ? result.map((item) => Record.fromJson(item)).toList() : [];
  }

  Future<Record?> getRecordId(int id) async {
    final db = await dbProvider.database;
    final result = await db.query(tableName, where: 'record_id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.map((item) => Record.fromJson(item)).toList().first : null;
  }

  Future<List<Record>> getGameRecord(int id) async {
    final db = await dbProvider.database;
    final result = await db.query(tableName, where: 'game_id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.map((item) => Record.fromJson(item)).toList() : [];
  }

  Future<List<Record>> getTagRecord(int id) async {
    final db = await dbProvider.database;
    final result = await db.query(tableName, where: 'tag_id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.map((item) => Record.fromJson(item)).toList() : [];
  }

  Future<int> insert(Record record) async {
    final newId = await _insert(record);
    ref.read(firestorePublicUserDataRepository).addRecord(record.copyWith(id: newId), ref.read(firebaseAuthNotifierProvider).user!.uid);
    return newId;
  }

  Future<int> _insert(Record record) async {
    final db = await dbProvider.database;
    return db.insert(tableName, record.toJson());
  }

  Future<int> update(Record record) async {
    final newId = await _update(record);
    ref.read(firestorePublicUserDataRepository).updateRecord(record.copyWith(id: newId), ref.read(firebaseAuthNotifierProvider).user!.uid);
    return newId;
  }

  Future<int> _update(Record record) async {
    final db = await dbProvider.database;
    return await db.update(tableName, record.toJson(), where: 'record_id = ?', whereArgs: [record.id]);
  }

  Future<List<Object?>> insertList(List<Record> records) async {
    final db = await dbProvider.database;
    final batch = db.batch();
    for (final record in records) {
      batch.insert(tableName, record.toJson());
    }
    return await batch.commit();
  }

  Future<List<Object?>> updateRecordList(List<Record> recordList) async {
    final db = await dbProvider.database;
    final batch = db.batch();
    for (final record in recordList) {
      batch.update(tableName, record.toJson(), where: 'record_id = ?', whereArgs: [record.id]);
    }
    return await batch.commit();
  }

  Future<int> delete(Record record) async {
    final newId = await _deleteById(record.id!);
    ref.read(firestorePublicUserDataRepository).removeRecord(record, ref.read(firebaseAuthNotifierProvider).user!.uid);
    return newId;
  }

  Future<int> _deleteById(int id) async {
    final db = await dbProvider.database;
    return await db.delete(tableName, where: 'record_id = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    final db = await dbProvider.database;
    return await db.delete(tableName);
  }
}
