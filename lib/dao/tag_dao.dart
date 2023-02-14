import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/service/database.dart';

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

  Future<List<Object?>> insertTagList(List<Tag> tagList) async {
    final db = await dbProvider.database;
    final batch = db.batch();
    for (final tag in tagList) {
      batch.insert(tableName, tag.toJson());
    }
    final result = await batch.commit();
    return result;
  }

  Future<List<Object?>> updateTagList(List<Tag> tagList) async {
    final db = await dbProvider.database;
    final batch = db.batch();
    for (final tag in tagList) {
      batch.update(tableName, tag.toJson(), where: 'tag_id = ?', whereArgs: [tag.tagId]);
    }
    final result = await batch.commit();
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
