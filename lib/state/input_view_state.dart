import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/tag.dart';

part 'input_view_state.freezed.dart';

enum WinLoss { win, loss }

enum FirstSecond { first, second }

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
    String? memo,
    @Default(WinLoss.win) WinLoss winLoss,
    @Default(FirstSecond.first) FirstSecond firstSecond,
  }) = _InputViewState;
}
