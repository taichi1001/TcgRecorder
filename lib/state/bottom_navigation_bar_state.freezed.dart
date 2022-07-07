// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bottom_navigation_bar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BottomNavigationBarState {
  BottomTabItem get viewItem => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BottomNavigationBarStateCopyWith<BottomNavigationBarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BottomNavigationBarStateCopyWith<$Res> {
  factory $BottomNavigationBarStateCopyWith(BottomNavigationBarState value,
          $Res Function(BottomNavigationBarState) then) =
      _$BottomNavigationBarStateCopyWithImpl<$Res>;
  $Res call({BottomTabItem viewItem});
}

/// @nodoc
class _$BottomNavigationBarStateCopyWithImpl<$Res>
    implements $BottomNavigationBarStateCopyWith<$Res> {
  _$BottomNavigationBarStateCopyWithImpl(this._value, this._then);

  final BottomNavigationBarState _value;
  // ignore: unused_field
  final $Res Function(BottomNavigationBarState) _then;

  @override
  $Res call({
    Object? viewItem = freezed,
  }) {
    return _then(_value.copyWith(
      viewItem: viewItem == freezed
          ? _value.viewItem
          : viewItem // ignore: cast_nullable_to_non_nullable
              as BottomTabItem,
    ));
  }
}

/// @nodoc
abstract class _$$_BottomNavigationBarStateCopyWith<$Res>
    implements $BottomNavigationBarStateCopyWith<$Res> {
  factory _$$_BottomNavigationBarStateCopyWith(
          _$_BottomNavigationBarState value,
          $Res Function(_$_BottomNavigationBarState) then) =
      __$$_BottomNavigationBarStateCopyWithImpl<$Res>;
  @override
  $Res call({BottomTabItem viewItem});
}

/// @nodoc
class __$$_BottomNavigationBarStateCopyWithImpl<$Res>
    extends _$BottomNavigationBarStateCopyWithImpl<$Res>
    implements _$$_BottomNavigationBarStateCopyWith<$Res> {
  __$$_BottomNavigationBarStateCopyWithImpl(_$_BottomNavigationBarState _value,
      $Res Function(_$_BottomNavigationBarState) _then)
      : super(_value, (v) => _then(v as _$_BottomNavigationBarState));

  @override
  _$_BottomNavigationBarState get _value =>
      super._value as _$_BottomNavigationBarState;

  @override
  $Res call({
    Object? viewItem = freezed,
  }) {
    return _then(_$_BottomNavigationBarState(
      viewItem: viewItem == freezed
          ? _value.viewItem
          : viewItem // ignore: cast_nullable_to_non_nullable
              as BottomTabItem,
    ));
  }
}

/// @nodoc

class _$_BottomNavigationBarState implements _BottomNavigationBarState {
  _$_BottomNavigationBarState({this.viewItem = BottomTabItem.inputScreen});

  @override
  @JsonKey()
  final BottomTabItem viewItem;

  @override
  String toString() {
    return 'BottomNavigationBarState(viewItem: $viewItem)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BottomNavigationBarState &&
            const DeepCollectionEquality().equals(other.viewItem, viewItem));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(viewItem));

  @JsonKey(ignore: true)
  @override
  _$$_BottomNavigationBarStateCopyWith<_$_BottomNavigationBarState>
      get copyWith => __$$_BottomNavigationBarStateCopyWithImpl<
          _$_BottomNavigationBarState>(this, _$identity);
}

abstract class _BottomNavigationBarState implements BottomNavigationBarState {
  factory _BottomNavigationBarState({final BottomTabItem viewItem}) =
      _$_BottomNavigationBarState;

  @override
  BottomTabItem get viewItem => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_BottomNavigationBarStateCopyWith<_$_BottomNavigationBarState>
      get copyWith => throw _privateConstructorUsedError;
}
