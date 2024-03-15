import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/repository/firestore_public_game_repository.dart';

final sortedPublicGameListProvider = FutureProvider((ref) async {
  final publicGameList = await ref.watch(publicGameListProvider.future);
  publicGameList.sort((a, b) {
    // id=0のものを最後にし、日本語を最初に、その後にアルファベット順にする
    if (a.id == 0 && b.id != 0) return 1;
    if (a.id != 0 && b.id == 0) return -1;
    final isAJapanese = RegExp(r'^[\u3040-\u30ff\u3400-\u4dbf\u4e00-\u9fff\uF900-\uFAFF\uFF66-\uFF9F]').hasMatch(a.name);
    final isBJapanese = RegExp(r'^[\u3040-\u30ff\u3400-\u4dbf\u4e00-\u9fff\uF900-\uFAFF\uFF66-\uFF9F]').hasMatch(b.name);
    if (isAJapanese && !isBJapanese) return -1;
    if (!isAJapanese && isBJapanese) return 1;
    return a.name.compareTo(b.name);
  });
  return publicGameList;
});
