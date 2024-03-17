import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/repository/firestore_public_user_data_repository.dart';
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
    try {
      final newId = await _insert(game);
      ref.read(firestorePublicUserDataRepository).addGame(game.copyWith(id: newId), ref.read(firebaseAuthNotifierProvider).user!.uid);
      return newId;
    } on Exception catch (_) {
      throw Exception('ゲームの追加に失敗しました。ゲーム名が重複している可能性があります。');
    }
  }

  Future<int> _insert(Game game) async {
    final db = await dbProvider.database;
    return db.insert(tableName, game.toJson());
  }

  Future<int> update(Game game) async {
    final newId = await _update(game);
    ref.read(firestorePublicUserDataRepository).updateGame(game, ref.read(firebaseAuthNotifierProvider).user!.uid);
    return newId;
  }

  Future<int> _update(Game game) async {
    final db = await dbProvider.database;
    return await db.update(tableName, game.toJson(), where: 'game_id = ?', whereArgs: [game.id]);
  }

  Future<int> delete(Game game) async {
    if (game.id == null) return 0;
    final newId = await _deleteById(game.id!);
    ref.read(firestorePublicUserDataRepository).removeGame(game, ref.read(firebaseAuthNotifierProvider).user!.uid);
    return newId;
  }

  Future<int> _deleteById(int id) async {
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
    final newId = await _updateGameList(gameList);
    ref.read(firestorePublicUserDataRepository).updateGameList(gameList, ref.read(firebaseAuthNotifierProvider).user!.uid);
    return newId;
  }

  Future<List<Object?>> _updateGameList(List<Game> gameList) async {
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
