// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
      _$SelectDeckViewStateCopyWithImpl<$Res>;
  $Res call({Sort sortType, bool isSearch, String searchText});
}

/// @nodoc
class _$SelectDeckViewStateCopyWithImpl<$Res>
    implements $SelectDeckViewStateCopyWith<$Res> {
  _$SelectDeckViewStateCopyWithImpl(this._value, this._then);

  final SelectDeckViewState _value;
  // ignore: unused_field
  final $Res Function(SelectDeckViewState) _then;

  @override
  $Res call({
    Object? sortType = freezed,
    Object? isSearch = freezed,
    Object? searchText = freezed,
  }) {
    return _then(_value.copyWith(
      sortType: sortType == freezed
          ? _value.sortType
          : sortType // ignore: cast_nullable_to_non_nullable
              as Sort,
      isSearch: isSearch == freezed
          ? _value.isSearch
          : isSearch // ignore: cast_nullable_to_non_nullable
              as bool,
      searchText: searchText == freezed
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_SelectDeckViewStateCopyWith<$Res>
    implements $SelectDeckViewStateCopyWith<$Res> {
  factory _$$_SelectDeckViewStateCopyWith(_$_SelectDeckViewState value,
          $Res Function(_$_SelectDeckViewState) then) =
      __$$_SelectDeckViewStateCopyWithImpl<$Res>;
  @override
  $Res call({Sort sortType, bool isSearch, String searchText});
}

/// @nodoc
class __$$_SelectDeckViewStateCopyWithImpl<$Res>
    extends _$SelectDeckViewStateCopyWithImpl<$Res>
    implements _$$_SelectDeckViewStateCopyWith<$Res> {
  __$$_SelectDeckViewStateCopyWithImpl(_$_SelectDeckViewState _value,
      $Res Function(_$_SelectDeckViewState) _then)
      : super(_value, (v) => _then(v as _$_SelectDeckViewState));

  @override
  _$_SelectDeckViewState get _value => super._value as _$_SelectDeckViewState;

  @override
  $Res call({
    Object? sortType = freezed,
    Object? isSearch = freezed,
    Object? searchText = freezed,
  }) {
    return _then(_$_SelectDeckViewState(
      sortType: sortType == freezed
          ? _value.sortType
          : sortType // ignore: cast_nullable_to_non_nullable
              as Sort,
      isSearch: isSearch == freezed
          ? _value.isSearch
          : isSearch // ignore: cast_nullable_to_non_nullable
              as bool,
      searchText: searchText == freezed
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
            const DeepCollectionEquality().equals(other.sortType, sortType) &&
            const DeepCollectionEquality().equals(other.isSearch, isSearch) &&
            const DeepCollectionEquality()
                .equals(other.searchText, searchText));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(sortType),
      const DeepCollectionEquality().hash(isSearch),
      const DeepCollectionEquality().hash(searchText));

  @JsonKey(ignore: true)
  @override
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
  Sort get sortType => throw _privateConstructorUsedError;
  @override
  bool get isSearch => throw _privateConstructorUsedError;
  @override
  String get searchText => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_SelectDeckViewStateCopyWith<_$_SelectDeckViewState> get copyWith =>
      throw _privateConstructorUsedError;
}
