import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/selector/game_record_list_selector.dart';
import 'package:tcg_manager/selector/game_tag_list_selector.dart';

final recentlyUseTagProvider = FutureProvider.autoDispose<List<Tag>>((ref) async {
  final recordList = await ref.watch(gameRecordListProvider.future);

  // レコードを最新順に並び替え
  recordList.sort((a, b) {
    int result = -a.date!.compareTo(b.date!);
    if (result == 0) {
      result = -a.recordId!.compareTo(b.recordId!);
    }
    return result;
  });
  // 直近使用した、または使用されたタグ10個のIDを抽出
  List<int> recentlyTagIdList = [];
  for (final record in recordList) {
    if (recentlyTagIdList.length == 5) break;
    if (recentlyTagIdList.length == 6) {
      recentlyTagIdList.removeLast();
      break;
    }
    if (record.tagId.isNotEmpty) {
      recentlyTagIdList.addAll(record.tagId);
      recentlyTagIdList = recentlyTagIdList.toSet().toList();
    }
  }
  // IDが一致するタグを抽出
  final tagList = await ref.watch(gameTagListProvider.future);
  final List<Tag> recentlyTagList = [];
  for (final id in recentlyTagIdList) {
    for (final tag in tagList) {
      if (id == tag.tagId) {
        recentlyTagList.add(tag);
        break;
      }
    }
  }
  return recentlyTagList;
});
