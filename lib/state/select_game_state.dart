import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_recorder2/entity/game.dart';

part 'select_game_state.freezed.dart';

@freezed
abstract class SelectGameState with _$SelectGameState {
  factory SelectGameState({
    Game? selectGame,
    Game? cacheSelectGame,
  }) = _SelectGameState;
}
