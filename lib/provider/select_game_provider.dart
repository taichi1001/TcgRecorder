import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/entity/game.dart';
import 'package:tcg_recorder2/state/select_game_state.dart';

class SelectGameNotifier extends StateNotifier<SelectGameState> {
  SelectGameNotifier(this.read) : super(SelectGameState()) {
    // 初期選択ゲームを取得する処理を書く
  }

  final Reader read;

  void changeGame(Game game) {
    state = state.copyWith(selectGame: game);
  }

  void changeGameForString(String name) {
    state = state.copyWith(selectGame: Game(game: name));
  }
}

final selectGameNotifierProvider = StateNotifierProvider<SelectGameNotifier, SelectGameState>(
  (ref) => SelectGameNotifier(ref.read),
);
