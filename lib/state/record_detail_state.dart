import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/tag.dart';

part 'record_detail_state.freezed.dart';

@freezed
abstract class RecordDetailState with _$RecordDetailState {
  factory RecordDetailState({
    @Default(false) bool isEdit,
    required Record record,
    required MargedRecord margedRecord,
    required MargedRecord editMargedRecord,
    Deck? cacheUseDeck,
    Deck? cacheOpponentDeck,
    Tag? cacheTag,
    DateTime? cacheDate,
  }) = _RecordDetailState;
}
