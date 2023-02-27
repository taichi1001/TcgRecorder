// ignore_for_file: unused_result

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/provider/backup_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/repository/game_repository.dart';
import 'package:tcg_manager/provider/firestore_controller.dart';
import 'package:tcg_manager/state/select_game_state.dart';

class SelectGameNotifier extends StateNotifier<SelectGameState> {
  SelectGameNotifier(this.ref) : super(SelectGameState()) {
    startupGame();
  }

  final StateNotifierProviderRef ref;

  void changeGame(Game game) {
    state = state.copyWith(selectGame: game);
  }

  void changeGameForString(String name) {
    state = state.copyWith(selectGame: Game(game: name));
  }

  void scrollSelectGame(int index) async {
    final gameList = await ref.read(allGameListProvider.future);
    final newDeck = gameList[index];
    state = state.copyWith(cacheSelectGame: newDeck);
  }

  void setSelectGame() {
    state = state.copyWith(selectGame: state.cacheSelectGame);
  }

  Future<bool> saveGame(String name) async {
    final newGame = Game(game: name);
    if (await _checkIfSelectedGamekNew(name)) {
      await ref.read(gameRepository).insert(newGame);
      ref.refresh(allGameListProvider);
      if (ref.read(backupNotifierProvider)) await ref.read(firestoreController).setAll();
      final allGameList = await ref.read(allGameListProvider.future);
      final game = allGameList.last;
      state = state.copyWith(selectGame: game);
      return true;
    }
    return false;
  }

  Future startupGame() async {
    final records = await ref.read(allRecordListProvider.future);
    final games = await ref.read(allGameListProvider.future);
    if (records.isNotEmpty) {
      // レコードが存在する場合、最後に登録したレコードのゲームを選択ゲームとする
      final record = records.last;
      final game = games.where((game) => game.gameId == record.gameId).last;
      state = state.copyWith(selectGame: game, cacheSelectGame: game);
    } else {
      // レコードが存在しない場合、最後に登録したゲームを選択ゲームとする
      state = state.copyWith(selectGame: games.last, cacheSelectGame: games.last);
    }
  }

  Future<bool> _checkIfSelectedGamekNew(String name) async {
    final gameList = await ref.read(allGameListProvider.future);
    final matchList = gameList.where((game) => game.game == name);
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
