import 'package:freezed_annotation/freezed_annotation.dart';

part 'input_view_settings_state.freezed.dart';

@freezed
abstract class InputViewSettingsState with _$InputViewSettingsState {
  factory InputViewSettingsState({
    @Default(false) final bool fixUseDeck,
    @Default(false) final bool fixOpponentDeck,
    @Default(false) final bool fixTag,
  }) = _InputViewSettingsState;
}
