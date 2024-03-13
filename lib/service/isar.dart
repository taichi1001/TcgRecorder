import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:tcg_manager/main.dart';
import 'package:tcg_manager/provider/database_version_provider.dart';
import 'package:tcg_manager/provider/user_activity_provider.dart';

final isarProvider = Provider((ref) {
  final savePath = ref.watch(imagePathProvider);
  return Isar.open(schemas: [UserActivityLogSchema, DatabaseVersionSchema], directory: savePath);
});
