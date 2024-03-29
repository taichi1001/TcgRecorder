import 'package:freezed_annotation/freezed_annotation.dart';

part 'win_rate_data.freezed.dart';

@freezed
class WinRateData with _$WinRateData {
  factory WinRateData({
    @Default('') String deck,
    @Default(0) int matches,
    @Default(0) int firstMatches,
    @Default(0) int secondMatches,
    @Default(0) int win,
    @Default(0) int firstMatchesWin,
    @Default(0) int secondMatchesWin,
    @Default(0) int loss,
    @Default(0) int firstMatchesLoss,
    @Default(0) int secondMatchesLoss,
    @Default(0) int draw,
    @Default(0) int firstMatchesDraw,
    @Default(0) int secondMatchesDraw,
    @Default(0) double useRate,
    @Default(0) double winRate,
    @Default(0) double winRateOfFirst,
    @Default(0) double winRateOfSecond,
  }) = _WinRateData;
}
