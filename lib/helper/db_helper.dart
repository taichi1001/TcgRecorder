import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/repository/deck_repository.dart';
import 'package:tcg_manager/repository/game_repository.dart';
import 'package:tcg_manager/repository/record_repository.dart';
import 'package:tcg_manager/repository/tag_repository.dart';

class DbHelper {
  DbHelper(this.read);
  final Reader read;

  Future deleteAll() async {
    await read(recordRepository).deleteAll();
    await read(tagRepository).deleteAll();
    await read(deckRepository).deleteAll();
    await read(gameRepository).deleteAll();
    await fetchAll();
  }

  Future fetchAll() async {
    await read(allGameListNotifierProvider.notifier).fetch();
    await read(allDeckListNotifierProvider.notifier).fetch();
    await read(allTagListNotifierProvider.notifier).fetch();
    await read(allRecordListNotifierProvider.notifier).fetch();
  }
}

final dbHelper = Provider((ref) => DbHelper(ref.read));
