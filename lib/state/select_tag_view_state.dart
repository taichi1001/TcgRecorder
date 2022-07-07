import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/enum/sort.dart';

part 'select_tag_view_state.freezed.dart';

@freezed
abstract class SelectTagViewState with _$SelectTagViewState {
  factory SelectTagViewState({
    @Default(Sort.oldest) Sort sortType,
    @Default(false) bool isSearch,
    @Default('') String searchText,
  }) = _SelectTagViewState;
}
