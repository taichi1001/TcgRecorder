import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/repository/game_repository.dart';
import 'package:tcg_recorder2/state/game_list_state.dart';

class GameListNotifier extends StateNotifier<GameListState> {
  GameListNotifier(this.read) : super(GameListState());

  final Reader read;

  Future fetch() async {
    final gameList = await read(gameRepository).getAll();
    state = state.copyWith(allGameList: gameList);
  }
}

final allGameListNotifierProvider = StateNotifierProvider<GameListNotifier, GameListState>(
  (ref) => GameListNotifier(ref.read),
);
