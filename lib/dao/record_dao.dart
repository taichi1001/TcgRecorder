import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/service/database.dart';

class RecordDao {
  final dbProvider = DatabaseService.dbProvider;
  final tableName = DatabaseService.recordTableName;

  Future<int> create(Record record) async {
    final db = await dbProvider.database;
    final result = db.insert(tableName, record.toJson());
    return result;
  }

  Future<List<Record>> getAll() async {
    final db = await dbProvider.database;
    final result = await db.query(tableName);
    final List<Record> records = result.isNotEmpty ? result.map((item) => Record.fromJson(item)).toList() : [];
    return records;
  }

  Future<Record?> getRecordId(int id) async {
    final db = await dbProvider.database;
    final result = await db.query(tableName, where: 'record_id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.map((item) => Record.fromJson(item)).toList().first : null;
  }

  Future<List<Record>> getGameRecord(int id) async {
    final db = await dbProvider.database;
    final result = await db.query(tableName, where: 'game_id = ?', whereArgs: [id]);
    final List<Record> records = result.isNotEmpty ? result.map((item) => Record.fromJson(item)).toList() : [];
    return records;
  }

  Future<List<Record>> getTagRecord(int id) async {
    final db = await dbProvider.database;
    final result = await db.query(tableName, where: 'tag_id = ?', whereArgs: [id]);
    final List<Record> records = result.isNotEmpty ? result.map((item) => Record.fromJson(item)).toList() : [];
    return records;
  }

  Future<int> update(Record record) async {
    final db = await dbProvider.database;
    final result = await db.update(tableName, record.toJson(), where: 'record_id = ?', whereArgs: [record.recordId]);
    return result;
  }

  Future<List<Object?>> updateRecordList(List<Record> recordList) async {
    final db = await dbProvider.database;
    final batch = db.batch();
    for (final record in recordList) {
      batch.update(tableName, record.toJson(), where: 'record_id = ?', whereArgs: [record.recordId]);
    }
    final result = await batch.commit();
    return result;
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    final result = await db.delete(tableName, where: 'record_id = ?', whereArgs: [id]);
    return result;
  }

  //not use this sample
  Future deleteAll() async {
    final db = await dbProvider.database;
    final result = await db.delete(
      tableName,
    );

    return result;
  }
}
