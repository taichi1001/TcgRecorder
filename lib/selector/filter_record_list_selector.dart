import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/provider/record_list_view_provider.dart';
import 'package:tcg_manager/selector/game_record_list_selector.dart';

final filterRecordListProvider = StateProvider<List<Record>>((ref) {
  final recordList = ref.watch(gameRecordListNotifierProvider).gameRecordList;
  final filter = ref.watch(recordListViewNotifierProvider);

  var filterdList = recordList;

  if (filter.startDate != null) {
    filterdList = filterdList!.where((record) {
      if (record.date!.isAtSameMomentAs(filter.startDate!) || record.date!.isAfter(filter.startDate!)) {
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  if (filter.endDate != null) {
    filterdList = filterdList!.where((record) {
      if (record.date!.isAtSameMomentAs(filter.endDate!) || record.date!.isBefore(filter.endDate!)) {
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  if (filter.useDeck != null) {
    filterdList = filterdList!.where((record) => record.useDeckId == filter.useDeck!.deckId).toList();
  }

  if (filter.opponentDeck != null) {
    filterdList = filterdList!.where((record) => record.opponentDeckId == filter.opponentDeck!.deckId).toList();
  }

  if (filter.tag != null) {
    filterdList = filterdList!.where((record) => record.tagId == filter.tag!.tagId).toList();
  }

  if (filterdList != null) return filterdList;
  return List.empty();
});
