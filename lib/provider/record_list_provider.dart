import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/repository/record_repository.dart';

final allRecordListProvider = FutureProvider<List<Record>>((ref) async => await ref.read(recordRepository).getAll());
