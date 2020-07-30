import 'package:tcg_recorder/service/database.dart';
import 'package:tcg_recorder/entity/name.dart';

class NameDao {
  final dbProvider = DatabaseService.dbProvider;
  final tableName = DatabaseService.nameTableName;

  Future<int> create(Name name) async {
    final db = await dbProvider.database;
    final result = db.insert(tableName, name.toDatabaseJson());
    return result;
  }

  Future<List<Name>> getAll() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> result = await db.query(tableName);
    final List<Name> names = result.isNotEmpty
        ? result.map((item) => Name.fromDatabaseJson(item)).toList()
        : [];
    return names;
  }

  Future<int> update(Name name) async {
    final db = await dbProvider.database;
    final result = await db.update(tableName, name.toDatabaseJson(),
        where: 'name_id = ?', whereArgs: [name.nameId]);
    return result;
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    final result =
        await db.delete(tableName, where: 'name_id = ?', whereArgs: [id]);
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
