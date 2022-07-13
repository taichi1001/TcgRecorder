import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/repository/deck_repository.dart';

final allDeckListProvider = FutureProvider<List<Deck>>((ref) async => await ref.read(deckRepository).getAll());
