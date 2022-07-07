import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/repository/game_repository.dart';

final allGameListProvider = FutureProvider<List<Game>>((ref) async {
  final gameList = await ref.read(gameRepository).getAll();
  return gameList;
});
