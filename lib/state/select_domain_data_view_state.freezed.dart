// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_domain_data_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SelectDomainDataViewState {
  Sort get sortType => throw _privateConstructorUsedError;
  bool get isSearch => throw _privateConstructorUsedError;
  String get searchText => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectDomainDataViewStateCopyWith<SelectDomainDataViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectDomainDataViewStateCopyWith<$Res> {
  factory $SelectDomainDataViewStateCopyWith(SelectDomainDataViewState value,
          $Res Function(SelectDomainDataViewState) then) =
      _$SelectDomainDataViewStateCopyWithImpl<$Res, SelectDomainDataViewState>;
  @useResult
  $Res call({Sort sortType, bool isSearch, String searchText});
}

/// @nodoc
class _$SelectDomainDataViewStateCopyWithImpl<$Res,
        $Val extends SelectDomainDataViewState>
    implements $SelectDomainDataViewStateCopyWith<$Res> {
  _$SelectDomainDataViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sortType = null,
    Object? isSearch = null,
    Object? searchText = null,
  }) {
    return _then(_value.copyWith(
      sortType: null == sortType
          ? _value.sortType
          : sortType // ignore: cast_nullable_to_non_nullable
              as Sort,
      isSearch: null == isSearch
          ? _value.isSearch
          : isSearch // ignore: cast_nullable_to_non_nullable
              as bool,
      searchText: null == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SelectDomainDataViewStateImplCopyWith<$Res>
    implements $SelectDomainDataViewStateCopyWith<$Res> {
  factory _$$SelectDomainDataViewStateImplCopyWith(
          _$SelectDomainDataViewStateImpl value,
          $Res Function(_$SelectDomainDataViewStateImpl) then) =
      __$$SelectDomainDataViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Sort sortType, bool isSearch, String searchText});
}

/// @nodoc
class __$$SelectDomainDataViewStateImplCopyWithImpl<$Res>
    extends _$SelectDomainDataViewStateCopyWithImpl<$Res,
        _$SelectDomainDataViewStateImpl>
    implements _$$SelectDomainDataViewStateImplCopyWith<$Res> {
  __$$SelectDomainDataViewStateImplCopyWithImpl(
      _$SelectDomainDataViewStateImpl _value,
      $Res Function(_$SelectDomainDataViewStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sortType = null,
    Object? isSearch = null,
    Object? searchText = null,
  }) {
    return _then(_$SelectDomainDataViewStateImpl(
      sortType: null == sortType
          ? _value.sortType
          : sortType // ignore: cast_nullable_to_non_nullable
              as Sort,
      isSearch: null == isSearch
          ? _value.isSearch
          : isSearch // ignore: cast_nullable_to_non_nullable
              as bool,
      searchText: null == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SelectDomainDataViewStateImpl implements _SelectDomainDataViewState {
  _$SelectDomainDataViewStateImpl(
      {this.sortType = Sort.oldest,
      this.isSearch = false,
      this.searchText = ''});

  @override
  @JsonKey()
  final Sort sortType;
  @override
  @JsonKey()
  final bool isSearch;
  @override
  @JsonKey()
  final String searchText;

  @override
  String toString() {
    return 'SelectDomainDataViewState(sortType: $sortType, isSearch: $isSearch, searchText: $searchText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectDomainDataViewStateImpl &&
            (identical(other.sortType, sortType) ||
                other.sortType == sortType) &&
            (identical(other.isSearch, isSearch) ||
                other.isSearch == isSearch) &&
            (identical(other.searchText, searchText) ||
                other.searchText == searchText));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sortType, isSearch, searchText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectDomainDataViewStateImplCopyWith<_$SelectDomainDataViewStateImpl>
      get copyWith => __$$SelectDomainDataViewStateImplCopyWithImpl<
          _$SelectDomainDataViewStateImpl>(this, _$identity);
}

abstract class _SelectDomainDataViewState implements SelectDomainDataViewState {
  factory _SelectDomainDataViewState(
      {final Sort sortType,
      final bool isSearch,
      final String searchText}) = _$SelectDomainDataViewStateImpl;

  @override
  Sort get sortType;
  @override
  bool get isSearch;
  @override
  String get searchText;
  @override
  @JsonKey(ignore: true)
  _$$SelectDomainDataViewStateImplCopyWith<_$SelectDomainDataViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
