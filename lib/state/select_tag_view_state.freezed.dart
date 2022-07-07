// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'select_tag_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SelectTagViewState {
  Sort get sortType => throw _privateConstructorUsedError;
  bool get isSearch => throw _privateConstructorUsedError;
  String get searchText => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectTagViewStateCopyWith<SelectTagViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectTagViewStateCopyWith<$Res> {
  factory $SelectTagViewStateCopyWith(
          SelectTagViewState value, $Res Function(SelectTagViewState) then) =
      _$SelectTagViewStateCopyWithImpl<$Res>;
  $Res call({Sort sortType, bool isSearch, String searchText});
}

/// @nodoc
class _$SelectTagViewStateCopyWithImpl<$Res>
    implements $SelectTagViewStateCopyWith<$Res> {
  _$SelectTagViewStateCopyWithImpl(this._value, this._then);

  final SelectTagViewState _value;
  // ignore: unused_field
  final $Res Function(SelectTagViewState) _then;

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
abstract class _$$_SelectTagViewStateCopyWith<$Res>
    implements $SelectTagViewStateCopyWith<$Res> {
  factory _$$_SelectTagViewStateCopyWith(_$_SelectTagViewState value,
          $Res Function(_$_SelectTagViewState) then) =
      __$$_SelectTagViewStateCopyWithImpl<$Res>;
  @override
  $Res call({Sort sortType, bool isSearch, String searchText});
}

/// @nodoc
class __$$_SelectTagViewStateCopyWithImpl<$Res>
    extends _$SelectTagViewStateCopyWithImpl<$Res>
    implements _$$_SelectTagViewStateCopyWith<$Res> {
  __$$_SelectTagViewStateCopyWithImpl(
      _$_SelectTagViewState _value, $Res Function(_$_SelectTagViewState) _then)
      : super(_value, (v) => _then(v as _$_SelectTagViewState));

  @override
  _$_SelectTagViewState get _value => super._value as _$_SelectTagViewState;

  @override
  $Res call({
    Object? sortType = freezed,
    Object? isSearch = freezed,
    Object? searchText = freezed,
  }) {
    return _then(_$_SelectTagViewState(
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

class _$_SelectTagViewState implements _SelectTagViewState {
  _$_SelectTagViewState(
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
    return 'SelectTagViewState(sortType: $sortType, isSearch: $isSearch, searchText: $searchText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SelectTagViewState &&
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
  _$$_SelectTagViewStateCopyWith<_$_SelectTagViewState> get copyWith =>
      __$$_SelectTagViewStateCopyWithImpl<_$_SelectTagViewState>(
          this, _$identity);
}

abstract class _SelectTagViewState implements SelectTagViewState {
  factory _SelectTagViewState(
      {final Sort sortType,
      final bool isSearch,
      final String searchText}) = _$_SelectTagViewState;

  @override
  Sort get sortType => throw _privateConstructorUsedError;
  @override
  bool get isSearch => throw _privateConstructorUsedError;
  @override
  String get searchText => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_SelectTagViewStateCopyWith<_$_SelectTagViewState> get copyWith =>
      throw _privateConstructorUsedError;
}
