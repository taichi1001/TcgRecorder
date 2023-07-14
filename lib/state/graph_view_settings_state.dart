import 'package:freezed_annotation/freezed_annotation.dart';

part 'graph_view_settings_state.freezed.dart';

@freezed
abstract class GraphViewSettingsState with _$GraphViewSettingsState {
  factory GraphViewSettingsState({
    @Default(true) final bool matches,
    @Default(true) final bool firstMatches,
    @Default(true) final bool secondMatches,
    @Default(true) final bool win,
    @Default(true) final bool firstMatchesWin,
    @Default(true) final bool secondMatchesWin,
    @Default(true) final bool loss,
    @Default(true) final bool firstMatchesLoss,
    @Default(true) final bool secondMatchesLoss,
    @Default(true) final bool draw,
    @Default(true) final bool firstMatchesDraw,
    @Default(true) final bool secondMatchesDraw,
    @Default(true) final bool winRate,
    @Default(true) final bool firstWinRate,
    @Default(true) final bool secondWinRate,
  }) = _GraphViewSettingsState;
}
