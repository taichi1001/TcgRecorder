import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/enum/Sort.dart';

part 'record_list_view_state.freezed.dart';

@freezed
abstract class RecordListViewState with _$RecordListViewState {
  factory RecordListViewState({
    @Default(Sort.newest) final Sort sort,
    final DateTime? startDate,
    final DateTime? endDate,
    final Deck? useDeck,
    final Deck? opponentDeck,
    final Tag? tag,
    @Default(Sort.newest) final Sort cacheOrder,
    final DateTime? cacheStartDate,
    final DateTime? cacheEndDate,
    final Deck? cacheUseDeck,
    final Deck? cacheOpponentDeck,
    final Tag? cacheTag,
  }) = _RecordListViewState;
}
