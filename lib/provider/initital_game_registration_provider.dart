import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/helper/initial_data_controller.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/repository/game_repository.dart';
import 'package:tcg_manager/state/initial_game_registration_state.dart';

class InitialGameRegistrationNotifier extends StateNotifier<InitialGameRegistrationState> {
  InitialGameRegistrationNotifier(this.ref) : super(InitialGameRegistrationState());

  final Ref ref;

  void changeGameForString(String name) {
    state = state.copyWith(initialGame: Game(name: name));
  }

  void reset() {
    state = state.copyWith(initialGame: null);
  }

  Future save() async {
    if (state.initialGame != null) {
      final id = await ref.read(gameRepository).insert(state.initialGame!);
      ref.read(initialDataControllerProvider).saveGame(state.initialGame!.copyWith(id: id));
      ref.invalidate(allGameListProvider);
    }
  }
}

final initialGameRegistrationNotifierProvider =
    StateNotifierProvider.autoDispose<InitialGameRegistrationNotifier, InitialGameRegistrationState>(
  (ref) => InitialGameRegistrationNotifier(ref),
);
