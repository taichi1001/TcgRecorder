import 'package:tcg_recorder/service/database.dart';
import 'package:tcg_recorder/entity/tag.dart';

class TagDao {
  final dbProvider = DatabaseService.dbProvider;
  final tableName = DatabaseService.tagTableName;

  Future<int> create(Tag tag) async {
    final db = await dbProvider.database;
    final result = db.insert(tableName, tag.toDatabaseJson());
    return result;
  }

  Future<List<Tag>> getAll() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> result = await db.query(tableName);
    final List<Tag> tags = result.isNotEmpty
        ? result.map((item) => Tag.fromDatabaseJson(item)).toList()
        : [];
    return tags;
  }

  Future<List<Tag>> getGameTag(int id) async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> result =
        await db.query(tableName, where: 'game_id = ?', whereArgs: [id]);
    final List<Tag> tags = result.isNotEmpty
        ? result.map((item) => Tag.fromDatabaseJson(item)).toList()
        : [];
    return tags;
  }

  Future<int> update(Tag tag) async {
    final db = await dbProvider.database;
    final result = await db.update(tableName, tag.toDatabaseJson(),
        where: 'tag_id = ?', whereArgs: [tag.tagId]);
    return result;
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    final result =
        await db.delete(tableName, where: 'tag_id = ?', whereArgs: [id]);
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
