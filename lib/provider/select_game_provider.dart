import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/entity/game.dart';
import 'package:tcg_recorder2/provider/game_list_provider.dart';
import 'package:tcg_recorder2/provider/record_list_provider.dart';
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

  void reset() {
    state = state.copyWith(selectGame: null);
  }

  Future startupGame() async {
    final records = read(allRecordListNotifierProvider).allRecordList;
    final games = read(allGameListNotifierProvider).allGameList;
    if (games != null) {
      print(records);
      if (records != null && records.isNotEmpty) {
        final record = records.last;
        final game = games.where((game) => game.gameId == record.gameId).last;
        state = state.copyWith(selectGame: game);
      } else {
        state = state.copyWith(selectGame: games.last);
      }
    }
  }
}

final selectGameNotifierProvider = StateNotifierProvider<SelectGameNotifier, SelectGameState>(
  (ref) => SelectGameNotifier(ref.read),
);
