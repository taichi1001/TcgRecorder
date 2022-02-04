import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    await read(gameRepository).update(newGame);
    await fetch();
  }
}

final allGameListNotifierProvider = StateNotifierProvider<GameListNotifier, GameListState>(
  (ref) => GameListNotifier(ref.read),
);
