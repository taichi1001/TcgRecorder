// ignore_for_file: unused_result

import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/helper/initial_data_controller.dart';
import 'package:tcg_manager/provider/backup_provider.dart';
import 'package:tcg_manager/provider/firestore_backup_controller_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/repository/game_repository.dart';
import 'package:tcg_manager/state/select_game_state.dart';

class SelectGameNotifier extends StateNotifier<SelectGameState> {
  SelectGameNotifier(this.ref) : super(SelectGameState()) {
    startupGame();
  }

  final Ref ref;

  void changeGame(Game? game) {
    state = state.copyWith(selectGame: game);
  }

  void selectGame(Game game, int empty) {
    state = state.copyWith(selectGame: game);
  }

  void changeGameForString(String name) {
    state = state.copyWith(selectGame: Game(name: name));
  }

  Future changeGameForLastRecord() async {
    final allRecordList = await ref.read(allRecordListProvider.future);
    final List<Game?> allGameList = await ref.read(allGameListProvider.future);

    Game? selectedGame;

    if (allGameList.isNotEmpty) {
      if (allRecordList.isNotEmpty) {
        selectedGame = allGameList.firstWhereOrNull((element) => element?.id == allRecordList.last.gameId);
      } else {
        selectedGame = allGameList.last;
      }
    }

    state = state.copyWith(selectGame: selectedGame);
  }

  Future changeGameForId(int id) async {
    final gameList = await ref.read(allGameListProvider.future);
    final targetGame = gameList.firstWhere((element) => element.id == id, orElse: () => gameList.last);
    state = state.copyWith(selectGame: targetGame);
  }

  Future changeGameForLast() async {
    final gameList = await ref.read(allGameListProvider.future);
    state = state.copyWith(selectGame: gameList.last);
  }

  void setSelectGame(Game game) => state = state.copyWith(selectGame: game);

  Future<bool> saveGame(String name) async {
    final newGame = Game(name: name);
    if (await _checkIfSelectedGamekNew(name)) {
      await ref.read(gameRepository).insert(newGame);
      ref.refresh(allGameListProvider);
      if (ref.read(backupNotifierProvider)) await ref.read(firestoreBackupControllerProvider).addAll();
      final allGameList = await ref.read(allGameListProvider.future);
      final game = allGameList.last;
      state = state.copyWith(selectGame: game);
      return true;
    }
    return false;
  }

  void startupGame() {
    final game = ref.read(initialDataControllerProvider).loadGame();
    if (game == null) {
      state = state.copyWith(selectGame: null);
    } else {
      state = state.copyWith(selectGame: game);
    }
  }

  Future<bool> _checkIfSelectedGamekNew(String name) async {
    final gameList = await ref.read(allGameListProvider.future);
    final matchList = gameList.where((game) => game.name == name);
    if (matchList.isNotEmpty) {
      state = state.copyWith(selectGame: matchList.first);
      return false;
    }
    return true;
  }
}

final selectGameNotifierProvider = StateNotifierProvider<SelectGameNotifier, SelectGameState>(
  (ref) => SelectGameNotifier(ref),
);
