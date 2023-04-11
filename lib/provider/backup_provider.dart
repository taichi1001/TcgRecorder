import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/main.dart';

class BackupNotifier extends StateNotifier<bool> {
  BackupNotifier(this.ref) : super(false) {
    _init();
  }

  final Ref ref;
  static const backupPrefsKey = 'backupSetting';

  late final prefs = ref.read(sharedPreferencesProvider);

  void _init() {
    final backupSetting = _getBackupSetting();
    if (backupSetting == null) return;
    state = backupSetting;
  }

  void changeSetting(bool setting) {
    state = setting;
    _save(state);
  }

  bool? _getBackupSetting() => prefs.getBool(backupPrefsKey);

  void _save(bool setting) => prefs.setBool(backupPrefsKey, setting);
}

final backupNotifierProvider = StateNotifierProvider<BackupNotifier, bool>(
  (ref) => BackupNotifier(ref),
);
