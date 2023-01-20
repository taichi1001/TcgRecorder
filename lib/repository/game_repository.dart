import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/dao/geme_dao.dart';
import 'package:tcg_manager/entity/game.dart';

final gameRepository = Provider.autoDispose<GameRepository>((ref) => GameRepositoryImpl(ref));

abstract class GameRepository {
  Future<List<Game>> getAll();

  Future<int> insert(Game game);

  Future<int> update(Game game);

  Future<int> deleteById(int id);

  Future deleteAll();
}

class GameRepositoryImpl implements GameRepository {
  GameRepositoryImpl(this.ref);

  final Ref ref;
  final gameDao = GameDao();

  @override
  Future<List<Game>> getAll() => gameDao.getAll();

  @override
  Future<int> insert(Game game) => gameDao.create(game);

  @override
  Future<int> update(Game game) => gameDao.update(game);

  @override
  Future<int> deleteById(int id) => gameDao.delete(id);

  @override
  Future deleteAll() => gameDao.deleteAll();
}
