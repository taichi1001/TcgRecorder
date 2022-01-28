import 'package:tcg_recorder2/entity/game.dart';
import 'package:tcg_recorder2/service/database.dart';

class GameDao {
  final dbProvider = DatabaseService.dbProvider;
  final tableName = DatabaseService.gameTableName;

  Future<int> create(Game game) async {
    final db = await dbProvider.database;
    final result = db.insert(tableName, game.toJson());
    return result;
  }

  Future<List<Game>> getAll() async {
    final db = await dbProvider.database;
    final result = await db.query(tableName);
    final List<Game> games = result.isNotEmpty ? result.map((item) => Game.fromJson(item)).toList() : [];
    return games;
  }

  Future<int> update(Game game) async {
    final db = await dbProvider.database;
    final result = await db.update(tableName, game.toJson(), where: 'game_id = ?', whereArgs: [game.gameId]);
    return result;
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    final result = await db.delete(tableName, where: 'game_id = ?', whereArgs: [id]);
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
