import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/entity/record2.dart';
import 'package:tcg_recorder/service/database.dart';

class Record2Dao {
  final dbProvider = DatabaseService.dbProvider;
  final tableName = DatabaseService.record2TableName;

  Future<int> create(Record2 record) async {
    final db = await dbProvider.database;
    final result = db.insert(tableName, record.toDatabaseJson());
    return result;
  }

  Future<List<Record2>> getAll() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> result = await db.query(tableName);
    final List<Record2> records = result.isNotEmpty
        ? result.map((item) => Game.fromDatabaseJson(item)).toList()
        : [];
    return records;
  }

  Future<int> update(Record2 record) async {
    final db = await dbProvider.database;
    final result = await db.update(tableName, record.toDatabaseJson(),
        where: 'record_id = ?', whereArgs: [record.recordId]);
    return result;
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    final result =
        await db.delete(tableName, where: 'record_id = ?', whereArgs: [id]);
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
