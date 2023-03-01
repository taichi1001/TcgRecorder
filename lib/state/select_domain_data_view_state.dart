import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/enum/sort.dart';

part 'select_domain_data_view_state.freezed.dart';

@freezed
abstract class SelectDomainDataViewState with _$SelectDomainDataViewState {
  factory SelectDomainDataViewState({
    @Default(Sort.oldest) Sort sortType,
    @Default(false) bool isSearch,
    @Default('') String searchText,
  }) = _SelectDomainDataViewState;
}
