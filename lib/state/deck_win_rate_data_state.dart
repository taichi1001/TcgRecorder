import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_recorder2/entity/win_rate_data.dart';

part 'deck_win_rate_data_state.freezed.dart';

@freezed
abstract class DeckWinRateDataState with _$DeckWinRateDataState {
  factory DeckWinRateDataState({
    List<WinRateData>? winRateDataList,
  }) = _DeckWinRateDataState;
}
