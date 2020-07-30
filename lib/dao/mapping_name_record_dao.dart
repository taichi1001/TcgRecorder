import 'package:tcg_recorder/service/database.dart';
import 'package:tcg_recorder/entity/mapping_name_record.dart';

class CorrespondenceNameRecordDao {
  final dbProvider = DatabaseService.dbProvider;
  final tableName = DatabaseService.mappingNameRecordTableName;

  Future<int> create(MappingNameRecord mapping) async {
    final db = await dbProvider.database;
    final result = db.insert(tableName, mapping.toDatabaseJson());
    return result;
  }

  Future<List<MappingNameRecord>> getAll() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> result = await db.query(tableName);
    final List<MappingNameRecord> mapping = result.isNotEmpty
        ? result
            .map((item) => MappingNameRecord.fromDatabaseJson(item))
            .toList()
        : [];
    return mapping;
  }

  Future<int> update(MappingNameRecord mapping) async {
    final db = await dbProvider.database;
    final result = await db.update(tableName, mapping.toDatabaseJson(),
        where: 'mapping_id = ?', whereArgs: [mapping.mappingId]);
    return result;
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    final result = await db
        .delete(tableName, where: 'mapping_id = ?', whereArgs: [id]);
    return result;
  }

  Future<int> deleteByRecordId(int id) async {
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
