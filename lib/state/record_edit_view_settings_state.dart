import 'package:freezed_annotation/freezed_annotation.dart';

part 'record_edit_view_settings_state.freezed.dart';

@freezed
abstract class RecordEditViewSettingsState with _$RecordEditViewSettingsState {
  factory RecordEditViewSettingsState({
    @Default(false) final bool draw,
    @Default(false) final bool bo3,
  }) = _RecordEditViewSettingsState;
}
