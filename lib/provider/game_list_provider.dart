import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/repository/game_repository.dart';
import 'package:tcg_manager/state/game_list_state.dart';

class GameListNotifier extends StateNotifier<GameListState> {
  GameListNotifier(this.read) : super(GameListState());

  final Reader read;

  Future fetch() async {
    final gameList = await read(gameRepository).getAll();
    state = state.copyWith(allGameList: gameList);
  }

  Future updateName(String name, int index) async {
    final game = state.allGameList![index];
    final newGame = game.copyWith(game: name);
    try {
      await read(gameRepository).update(newGame);
      await fetch();
      // 編集したゲームがselectGameと同じだった場合の処理
      if (read(selectGameNotifierProvider).selectGame!.gameId == newGame.gameId) {
        read(selectGameNotifierProvider.notifier).changeGame(newGame);
      }
    } catch (e) {
      rethrow;
    }
  }
}

final allGameList = FutureProvider.autoDispose<List<Game>>(
  (ref) async {
    final gameList = await ref.read(gameRepository).getAll();
    return gameList;
  },
);

final abc = FutureProvider.autoDispose<List<Game>>((ref) async {
  final all = await ref.watch(allGameList.future);
  final ab = all.where((element) => element.game == '').toList();
  return ab;
});

final allGameListNotifierProvider = StateNotifierProvider<GameListNotifier, GameListState>(
  (ref) => GameListNotifier(ref.read),
);
