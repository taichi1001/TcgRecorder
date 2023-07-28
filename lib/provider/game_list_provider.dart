import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/repository/game_repository.dart';

final allGameListProvider = FutureProvider.autoDispose<List<Game>>((ref) async => await ref.read(gameRepository).getAll());
