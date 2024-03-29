import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
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
    Deck? useDeck,
    Deck? opponentDeck,
    @Default([]) List<Tag> tag,
    String? memo,
    @Default(WinLoss.win) WinLoss winLoss,
    WinLoss? firstMatchWinLoss,
    WinLoss? secondMatchWinLoss,
    WinLoss? thirdMatchWinLoss,
    @Default(FirstSecond.first) FirstSecond firstSecond,
    FirstSecond? firstMatchFirstSecond,
    FirstSecond? secondMatchFirstSecond,
    FirstSecond? thirdMatchFirstSecond,
    @Default([]) List<XFile> images,
  }) = _InputViewState;
}
