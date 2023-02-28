import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/service/database.dart';

final tagRepository = Provider.autoDispose<TagRepository>((ref) => TagRepository(ref));

class TagRepository {
  TagRepository(this.ref);

  final Ref ref;
  final dbProvider = DatabaseService.dbProvider;
  final tableName = DatabaseService.tagTableName;

  Future<int> insert(Tag tag) async {
    final db = await dbProvider.database;
    return db.insert(tableName, tag.toJson());
  }

  Future<List<Tag>> getAll() async {
    final db = await dbProvider.database;
    final result = await db.query(tableName);
    return result.isNotEmpty ? result.map((item) => Tag.fromJson(item)).toList() : [];
  }

  Future<List<Tag>> getGameTag(int id) async {
    final db = await dbProvider.database;
    final result = await db.query(tableName, where: 'game_id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.map((item) => Tag.fromJson(item)).toList() : [];
  }

  Future<int> update(Tag tag) async {
    final db = await dbProvider.database;
    return await db.update(tableName, tag.toJson(), where: 'tag_id = ?', whereArgs: [tag.tagId]);
  }

  Future<List<Object?>> insertList(List<Tag> tagList) async {
    final db = await dbProvider.database;
    final batch = db.batch();
    for (final tag in tagList) {
      batch.insert(tableName, tag.toJson());
    }
    return await batch.commit();
  }

  Future<List<Object?>> updateTagList(List<Tag> tagList) async {
    final db = await dbProvider.database;
    final batch = db.batch();
    for (final tag in tagList) {
      batch.update(tableName, tag.toJson(), where: 'tag_id = ?', whereArgs: [tag.tagId]);
    }
    return await batch.commit();
  }

  Future<int> deleteById(int id) async {
    final db = await dbProvider.database;
    return await db.delete(tableName, where: 'tag_id = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    final db = await dbProvider.database;
    return await db.delete(tableName);
  }
}
