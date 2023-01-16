// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_deck_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SelectDeckViewState {
  Sort get sortType => throw _privateConstructorUsedError;
  bool get isSearch => throw _privateConstructorUsedError;
  String get searchText => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectDeckViewStateCopyWith<SelectDeckViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectDeckViewStateCopyWith<$Res> {
  factory $SelectDeckViewStateCopyWith(
          SelectDeckViewState value, $Res Function(SelectDeckViewState) then) =
      _$SelectDeckViewStateCopyWithImpl<$Res, SelectDeckViewState>;
  @useResult
  $Res call({Sort sortType, bool isSearch, String searchText});
}

/// @nodoc
class _$SelectDeckViewStateCopyWithImpl<$Res, $Val extends SelectDeckViewState>
    implements $SelectDeckViewStateCopyWith<$Res> {
  _$SelectDeckViewStateCopyWithImpl(this._value, this._then);

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
abstract class _$$_SelectDeckViewStateCopyWith<$Res>
    implements $SelectDeckViewStateCopyWith<$Res> {
  factory _$$_SelectDeckViewStateCopyWith(_$_SelectDeckViewState value,
          $Res Function(_$_SelectDeckViewState) then) =
      __$$_SelectDeckViewStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Sort sortType, bool isSearch, String searchText});
}

/// @nodoc
class __$$_SelectDeckViewStateCopyWithImpl<$Res>
    extends _$SelectDeckViewStateCopyWithImpl<$Res, _$_SelectDeckViewState>
    implements _$$_SelectDeckViewStateCopyWith<$Res> {
  __$$_SelectDeckViewStateCopyWithImpl(_$_SelectDeckViewState _value,
      $Res Function(_$_SelectDeckViewState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sortType = null,
    Object? isSearch = null,
    Object? searchText = null,
  }) {
    return _then(_$_SelectDeckViewState(
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

class _$_SelectDeckViewState implements _SelectDeckViewState {
  _$_SelectDeckViewState(
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
    return 'SelectDeckViewState(sortType: $sortType, isSearch: $isSearch, searchText: $searchText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SelectDeckViewState &&
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
  _$$_SelectDeckViewStateCopyWith<_$_SelectDeckViewState> get copyWith =>
      __$$_SelectDeckViewStateCopyWithImpl<_$_SelectDeckViewState>(
          this, _$identity);
}

abstract class _SelectDeckViewState implements SelectDeckViewState {
  factory _SelectDeckViewState(
      {final Sort sortType,
      final bool isSearch,
      final String searchText}) = _$_SelectDeckViewState;

  @override
  Sort get sortType;
  @override
  bool get isSearch;
  @override
  String get searchText;
  @override
  @JsonKey(ignore: true)
  _$$_SelectDeckViewStateCopyWith<_$_SelectDeckViewState> get copyWith =>
      throw _privateConstructorUsedError;
}
