import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/service/database.dart';

final gameRepository = Provider.autoDispose<GameRepository>((ref) => GameRepository(ref));

class GameRepository {
  GameRepository(this.ref);

  final Ref ref;
  final dbProvider = DatabaseService.dbProvider;
  final tableName = DatabaseService.gameTableName;

  Future<List<Game>> getAll() async {
    final db = await dbProvider.database;
    final result = await db.query(tableName);
    return result.isNotEmpty ? result.map((item) => Game.fromJson(item)).toList() : [];
  }

  Future<int> insert(Game game) async {
    final db = await dbProvider.database;
    return db.insert(tableName, game.toJson());
  }

  Future<int> update(Game game) async {
    final db = await dbProvider.database;
    return await db.update(tableName, game.toJson(), where: 'game_id = ?', whereArgs: [game.id]);
  }

  Future<int> deleteById(int id) async {
    final db = await dbProvider.database;
    return await db.delete(tableName, where: 'game_id = ?', whereArgs: [id]);
  }

  Future<List<Object?>> insertList(List<Game> games) async {
    final db = await dbProvider.database;
    final batch = db.batch();
    for (final game in games) {
      batch.insert(tableName, game.toJson());
    }
    return await batch.commit();
  }

  Future<List<Object?>> updateGameList(List<Game> gameList) async {
    final db = await dbProvider.database;
    final batch = db.batch();
    for (final game in gameList) {
      batch.update(tableName, game.toJson(), where: 'game_id = ?', whereArgs: [game.id]);
    }
    return await batch.commit();
  }

  Future<int> deleteAll() async {
    final db = await dbProvider.database;
    return await db.delete(tableName);
  }
}
