import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_recorder2/entity/deck.dart';

part 'deck_list_state.freezed.dart';

@freezed
abstract class DeckListState with _$DeckListState {
  factory DeckListState({
    List<Deck>? allDeckList,
  }) = _DeckListState;
}
