import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/entity/game.dart';

part 'initial_game_registration_state.freezed.dart';

@freezed
abstract class InitialGameRegistrationState with _$InitialGameRegistrationState {
  factory InitialGameRegistrationState({
    Game? initialGame,
  }) = _InitialGameRegistrationState;
}
