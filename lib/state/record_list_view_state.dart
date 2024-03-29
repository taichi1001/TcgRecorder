import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/enum/sort.dart';

part 'record_list_view_state.freezed.dart';

@freezed
abstract class RecordListViewState with _$RecordListViewState {
  factory RecordListViewState({
    @Default(Sort.newest) final Sort sort,
    final DateTime? startDate,
    final DateTime? endDate,
    final DateTime? startTime,
    final DateTime? endTime,
    final Deck? useDeck,
    final Deck? opponentDeck,
    @Default([]) final List<Tag> tagList,
    @Default(Sort.newest) final Sort cacheOrder,
    final DateTime? cacheStartDate,
    final DateTime? cacheEndDate,
  }) = _RecordListViewState;
}
