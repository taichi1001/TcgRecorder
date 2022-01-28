import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_recorder2/entity/win_rate_data.dart';

part 'game_win_rate_data_state.freezed.dart';

@freezed
abstract class GameWinRateDataState with _$GameWinRateDataState {
  factory GameWinRateDataState({
    List<WinRateData>? winRateDataList,
  }) = _GameWinRateDataState;
}
