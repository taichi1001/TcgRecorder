// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'record_edit_view_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RecordEditViewSettingsState {
  bool get draw => throw _privateConstructorUsedError;
  bool get bo3 => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecordEditViewSettingsStateCopyWith<RecordEditViewSettingsState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordEditViewSettingsStateCopyWith<$Res> {
  factory $RecordEditViewSettingsStateCopyWith(
          RecordEditViewSettingsState value,
          $Res Function(RecordEditViewSettingsState) then) =
      _$RecordEditViewSettingsStateCopyWithImpl<$Res,
          RecordEditViewSettingsState>;
  @useResult
  $Res call({bool draw, bool bo3});
}

/// @nodoc
class _$RecordEditViewSettingsStateCopyWithImpl<$Res,
        $Val extends RecordEditViewSettingsState>
    implements $RecordEditViewSettingsStateCopyWith<$Res> {
  _$RecordEditViewSettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? draw = null,
    Object? bo3 = null,
  }) {
    return _then(_value.copyWith(
      draw: null == draw
          ? _value.draw
          : draw // ignore: cast_nullable_to_non_nullable
              as bool,
      bo3: null == bo3
          ? _value.bo3
          : bo3 // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecordEditViewSettingsStateCopyWith<$Res>
    implements $RecordEditViewSettingsStateCopyWith<$Res> {
  factory _$$_RecordEditViewSettingsStateCopyWith(
          _$_RecordEditViewSettingsState value,
          $Res Function(_$_RecordEditViewSettingsState) then) =
      __$$_RecordEditViewSettingsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool draw, bool bo3});
}

/// @nodoc
class __$$_RecordEditViewSettingsStateCopyWithImpl<$Res>
    extends _$RecordEditViewSettingsStateCopyWithImpl<$Res,
        _$_RecordEditViewSettingsState>
    implements _$$_RecordEditViewSettingsStateCopyWith<$Res> {
  __$$_RecordEditViewSettingsStateCopyWithImpl(
      _$_RecordEditViewSettingsState _value,
      $Res Function(_$_RecordEditViewSettingsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? draw = null,
    Object? bo3 = null,
  }) {
    return _then(_$_RecordEditViewSettingsState(
      draw: null == draw
          ? _value.draw
          : draw // ignore: cast_nullable_to_non_nullable
              as bool,
      bo3: null == bo3
          ? _value.bo3
          : bo3 // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_RecordEditViewSettingsState implements _RecordEditViewSettingsState {
  _$_RecordEditViewSettingsState({this.draw = false, this.bo3 = false});

  @override
  @JsonKey()
  final bool draw;
  @override
  @JsonKey()
  final bool bo3;

  @override
  String toString() {
    return 'RecordEditViewSettingsState(draw: $draw, bo3: $bo3)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecordEditViewSettingsState &&
            (identical(other.draw, draw) || other.draw == draw) &&
            (identical(other.bo3, bo3) || other.bo3 == bo3));
  }

  @override
  int get hashCode => Object.hash(runtimeType, draw, bo3);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecordEditViewSettingsStateCopyWith<_$_RecordEditViewSettingsState>
      get copyWith => __$$_RecordEditViewSettingsStateCopyWithImpl<
          _$_RecordEditViewSettingsState>(this, _$identity);
}

abstract class _RecordEditViewSettingsState
    implements RecordEditViewSettingsState {
  factory _RecordEditViewSettingsState({final bool draw, final bool bo3}) =
      _$_RecordEditViewSettingsState;

  @override
  bool get draw;
  @override
  bool get bo3;
  @override
  @JsonKey(ignore: true)
  _$$_RecordEditViewSettingsStateCopyWith<_$_RecordEditViewSettingsState>
      get copyWith => throw _privateConstructorUsedError;
}
