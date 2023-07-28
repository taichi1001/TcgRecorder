import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/repository/tag_repository.dart';

final allTagListProvider = FutureProvider.autoDispose<List<Tag>>((ref) async => await ref.read(tagRepository).getAll());
