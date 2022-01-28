import 'package:tcg_recorder2/entity/tag.dart';
import 'package:tcg_recorder2/service/database.dart';

class TagDao {
  final dbProvider = DatabaseService.dbProvider;
  final tableName = DatabaseService.tagTableName;

  Future<int> create(Tag tag) async {
    final db = await dbProvider.database;
    final result = db.insert(tableName, tag.toJson());
    return result;
  }

  Future<List<Tag>> getAll() async {
    final db = await dbProvider.database;
    final result = await db.query(tableName);
    final List<Tag> tags = result.isNotEmpty ? result.map((item) => Tag.fromJson(item)).toList() : [];
    return tags;
  }

  Future<List<Tag>> getGameTag(int id) async {
    final db = await dbProvider.database;
    final result = await db.query(tableName, where: 'game_id = ?', whereArgs: [id]);
    final List<Tag> tags = result.isNotEmpty ? result.map((item) => Tag.fromJson(item)).toList() : [];
    return tags;
  }

  Future<int> update(Tag tag) async {
    final db = await dbProvider.database;
    final result = await db.update(tableName, tag.toJson(), where: 'tag_id = ?', whereArgs: [tag.tagId]);
    return result;
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    final result = await db.delete(tableName, where: 'tag_id = ?', whereArgs: [id]);
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
