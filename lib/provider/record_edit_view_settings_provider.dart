import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/enum/bo.dart';
import 'package:tcg_manager/enum/win_loss.dart';
import 'package:tcg_manager/main.dart';
import 'package:tcg_manager/state/record_edit_view_settings_state.dart';

class RecordEditViewSettingsNotifier extends StateNotifier<RecordEditViewSettingsState> {
  RecordEditViewSettingsNotifier(
    this.ref, {
    required bool draw,
    required bool bo3,
  }) : super(RecordEditViewSettingsState(draw: draw, bo3: bo3));

  final Ref ref;

  late final prefs = ref.read(sharedPreferencesProvider);

  void changeDraw(bool settings) {
    state = state.copyWith(draw: settings);
  }

  void changeBO3(bool settings) {
    state = state.copyWith(bo3: settings);
  }
}

final recordEditViewSettingsNotifierProvider =
    StateNotifierProvider.family.autoDispose<RecordEditViewSettingsNotifier, RecordEditViewSettingsState, MargedRecord>(
  (ref, margedRecord) => RecordEditViewSettingsNotifier(
    ref,
    draw: margedRecord.winLoss == WinLoss.draw,
    bo3: margedRecord.bo == BO.bo3,
  ),
);
