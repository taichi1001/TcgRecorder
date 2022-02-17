// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'record_sort_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RecordSortStateTearOff {
  const _$RecordSortStateTearOff();

  _RecordSortState call({Sort sort = Sort.date, Order order = Order.ascending}) {
    return _RecordSortState(
      sort: sort,
      order: order,
    );
  }
}

/// @nodoc
const $RecordSortState = _$RecordSortStateTearOff();

/// @nodoc
mixin _$RecordSortState {
  Sort get sort => throw _privateConstructorUsedError;
  Order get order => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecordSortStateCopyWith<RecordSortState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordSortStateCopyWith<$Res> {
  factory $RecordSortStateCopyWith(RecordSortState value, $Res Function(RecordSortState) then) = _$RecordSortStateCopyWithImpl<$Res>;
  $Res call({Sort sort, Order order});
}

/// @nodoc
class _$RecordSortStateCopyWithImpl<$Res> implements $RecordSortStateCopyWith<$Res> {
  _$RecordSortStateCopyWithImpl(this._value, this._then);

  final RecordSortState _value;
  // ignore: unused_field
  final $Res Function(RecordSortState) _then;

  @override
  $Res call({
    Object? sort = freezed,
    Object? order = freezed,
  }) {
    return _then(_value.copyWith(
      sort: sort == freezed
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as Sort,
      order: order == freezed
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as Order,
    ));
  }
}

/// @nodoc
abstract class _$RecordSortStateCopyWith<$Res> implements $RecordSortStateCopyWith<$Res> {
  factory _$RecordSortStateCopyWith(_RecordSortState value, $Res Function(_RecordSortState) then) = __$RecordSortStateCopyWithImpl<$Res>;
  @override
  $Res call({Sort sort, Order order});
}

/// @nodoc
class __$RecordSortStateCopyWithImpl<$Res> extends _$RecordSortStateCopyWithImpl<$Res> implements _$RecordSortStateCopyWith<$Res> {
  __$RecordSortStateCopyWithImpl(_RecordSortState _value, $Res Function(_RecordSortState) _then)
      : super(_value, (v) => _then(v as _RecordSortState));

  @override
  _RecordSortState get _value => super._value as _RecordSortState;

  @override
  $Res call({
    Object? sort = freezed,
    Object? order = freezed,
  }) {
    return _then(_RecordSortState(
      sort: sort == freezed
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as Sort,
      order: order == freezed
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as Order,
    ));
  }
}

/// @nodoc

class _$_RecordSortState implements _RecordSortState {
  _$_RecordSortState({this.sort = Sort.date, this.order = Order.ascending});

  @JsonKey()
  @override
  final Sort sort;
  @JsonKey()
  @override
  final Order order;

  @override
  String toString() {
    return 'RecordSortState(sort: $sort, order: $order)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecordSortState &&
            const DeepCollectionEquality().equals(other.sort, sort) &&
            const DeepCollectionEquality().equals(other.order, order));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(sort), const DeepCollectionEquality().hash(order));

  @JsonKey(ignore: true)
  @override
  _$RecordSortStateCopyWith<_RecordSortState> get copyWith => __$RecordSortStateCopyWithImpl<_RecordSortState>(this, _$identity);
}

abstract class _RecordSortState implements RecordSortState {
  factory _RecordSortState({Sort sort, Order order}) = _$_RecordSortState;

  @override
  Sort get sort;
  @override
  Order get order;
  @override
  @JsonKey(ignore: true)
  _$RecordSortStateCopyWith<_RecordSortState> get copyWith => throw _privateConstructorUsedError;
}
