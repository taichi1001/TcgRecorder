import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/service/database.dart';

class GameDao {
  final dbProvider = DatabaseService.dbProvider;
  final tableName = DatabaseService.gameTableName;

  Future<int> create(Game game) async {
    final db = await dbProvider.database;
    final result = db.insert(tableName, game.toDatabaseJson());
    return result;
  }

  Future<List<Game>> getAll() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> result = await db.query(tableName);
    final List<Game> games = result.isNotEmpty
        ? result.map((item) => Game.fromDatabaseJson(item)).toList()
        : [];
    return games;
  }

  Future<int> update(Game game) async {
    final db = await dbProvider.database;
    final result = await db.update(tableName, game.toDatabaseJson(),
        where: 'game_id = ?', whereArgs: [game.gameId]);
    return result;
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    final result =
        await db.delete(tableName, where: 'game_id = ?', whereArgs: [id]);
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
