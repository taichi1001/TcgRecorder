import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tcg_manager/provider/user_activity_provider.dart';
import 'package:tcg_manager/service/isar.dart';

part 'database_version_provider.g.dart';

@Collection()
class DatabaseVersion {
  @Id()
  int id = 0;
  late int version;
}

@Riverpod(keepAlive: true)
class DatabaseVersionNotifier extends _$DatabaseVersionNotifier {
  @override
  DatabaseVersion build() {
    final isar = ref.watch(isarProvider);

    //　変更を監視
    isar.databaseVersions.where().watch().listen((event) {
      final count = event.first;
      state = count;
    });

    final version = isar.databaseVersions.where().findFirst();
    if (version != null) {
      return version;
    } else {
      return DatabaseVersion()..version = 1;
    }
  }

  /// データベースのバージョンを更新する

  void updateDatabaseVersion(int version) {
    final oldVersion = state.version;
    if (oldVersion < version) {
      final isar = ref.watch(isarProvider);
      isar.write((isar) => isar.databaseVersions.put(state..version = version));
    }
    if (oldVersion < 2) {
      _migrationV1ToV2();
    }
  }

  void _migrationV1ToV2() {
    final isar = ref.watch(isarProvider);
    final userActivityLog = ref.watch(userActivityLogNotifierProvider);
    isar.write((isar) => isar.userActivityLogs.put(userActivityLog..isPublicDataUploaded = false));
  }
}
