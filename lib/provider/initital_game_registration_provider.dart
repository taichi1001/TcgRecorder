import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/entity/game.dart';
import 'package:tcg_recorder2/repository/game_repository.dart';
import 'package:tcg_recorder2/state/initial_game_registration_state.dart';

class InitialGameRegistrationNotifier extends StateNotifier<InitialGameRegistrationState> {
  InitialGameRegistrationNotifier(this.read) : super(InitialGameRegistrationState()) {
    // 初期選択ゲームを取得する処理を書く
  }

  final Reader read;

  void changeGameForString(String name) {
    state = state.copyWith(initialGame: Game(game: name));
  }

  Future save() async {
    if (state.initialGame != null) read(gameRepository).insert(state.initialGame!);
  }
}

final initialGameRegistrationNotifierProvider =
    StateNotifierProvider<InitialGameRegistrationNotifier, InitialGameRegistrationState>(
  (ref) => InitialGameRegistrationNotifier(ref.read),
);
