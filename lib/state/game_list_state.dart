import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/entity/game.dart';

part 'game_list_state.freezed.dart';

@freezed
abstract class GameListState with _$GameListState {
  factory GameListState({
    List<Game>? allGameList,
  }) = _GameListState;
}
