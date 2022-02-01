import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/repository/game_repository.dart';
import 'package:tcg_manager/state/select_game_state.dart';

class SelectGameNotifier extends StateNotifier<SelectGameState> {
  SelectGameNotifier(this.read) : super(SelectGameState()) {
    _startupGame();
  }

  final Reader read;

  void changeGame(Game game) {
    state = state.copyWith(selectGame: game);
  }

  void changeGameForString(String name) {
    state = state.copyWith(selectGame: Game(game: name));
  }

  void scrollSelectGame(int index) {
    final newDeck = read(allGameListNotifierProvider).allGameList?[index];
    state = state.copyWith(cacheSelectGame: newDeck);
  }

  void setSelectGame() {
    state = state.copyWith(selectGame: state.cacheSelectGame);
  }

  Future<bool> saveGame(String name) async {
    final newGame = Game(game: name);
    if (_checkIfSelectedGamekNew(name)) {
      await read(gameRepository).insert(newGame);
      await read(allGameListNotifierProvider.notifier).fetch();
      final game = read(allGameListNotifierProvider).allGameList?.last;
      state = state.copyWith(selectGame: game);
      return true;
    }
    return false;
  }

  void _startupGame() {
    final records = read(allRecordListNotifierProvider).allRecordList;
    final games = read(allGameListNotifierProvider).allGameList;
    if (games != null) {
      if (records != null && records.isNotEmpty) {
        final record = records.last;
        final game = games.where((game) => game.gameId == record.gameId).last;
        state = state.copyWith(selectGame: game, cacheSelectGame: game);
      } else {
        state = state.copyWith(selectGame: games.last, cacheSelectGame: games.last);
      }
    }
  }

  bool _checkIfSelectedGamekNew(String name) {
    final gameList = read(allGameListNotifierProvider).allGameList;
    final matchList = gameList!.where((game) => game.game == name);
    if (matchList.isNotEmpty) {
      state = state.copyWith(selectGame: matchList.first);
      return false;
    }
    return true;
  }
}

final selectGameNotifierProvider = StateNotifierProvider<SelectGameNotifier, SelectGameState>(
  (ref) => SelectGameNotifier(ref.read),
);
