import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';

part 'input_view_state.freezed.dart';

@freezed
abstract class InputViewState with _$InputViewState {
  factory InputViewState({
    Record? record,
    required DateTime date,
    DateTime? cacheDate,
    Deck? useDeck,
    Deck? opponentDeck,
    Tag? tag,
    String? memo,
    @Default(WinLoss.win) WinLoss winLoss,
    @Default(FirstSecond.first) FirstSecond firstSecond,
  }) = _InputViewState;
}
