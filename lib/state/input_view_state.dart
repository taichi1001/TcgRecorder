import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_recorder2/entity/deck.dart';
import 'package:tcg_recorder2/entity/record.dart';
import 'package:tcg_recorder2/entity/tag.dart';

part 'input_view_state.freezed.dart';

@freezed
abstract class InputViewState with _$InputViewState {
  factory InputViewState({
    Record? record,
    required DateTime date,
    DateTime? cacheDate,
    Deck? useDeck,
    Deck? cacheUseDeck,
    Deck? opponentDeck,
    Deck? cacheOpponentDeck,
    Tag? tag,
    Tag? cacheTag,
    @Default(true) bool winLoss,
    @Default(true) bool firstSecond,
  }) = _InputViewState;
}
