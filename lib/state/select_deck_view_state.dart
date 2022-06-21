import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/enum/sort.dart';

part 'select_deck_view_state.freezed.dart';

@freezed
abstract class SelectDeckViewState with _$SelectDeckViewState {
  factory SelectDeckViewState({
    @Default(Sort.oldest) Sort sortType,
    @Default(false) bool isSearch,
  }) = _SelectDeckViewState;
}
