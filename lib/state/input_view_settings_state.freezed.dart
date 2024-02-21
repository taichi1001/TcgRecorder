// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'input_view_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InputViewSettingsState {
  bool get fixUseDeck => throw _privateConstructorUsedError;
  bool get fixOpponentDeck => throw _privateConstructorUsedError;
  bool get fixTag => throw _privateConstructorUsedError;
  bool get draw => throw _privateConstructorUsedError;
  bool get bo3 => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InputViewSettingsStateCopyWith<InputViewSettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InputViewSettingsStateCopyWith<$Res> {
  factory $InputViewSettingsStateCopyWith(InputViewSettingsState value,
          $Res Function(InputViewSettingsState) then) =
      _$InputViewSettingsStateCopyWithImpl<$Res, InputViewSettingsState>;
  @useResult
  $Res call(
      {bool fixUseDeck,
      bool fixOpponentDeck,
      bool fixTag,
      bool draw,
      bool bo3});
}

/// @nodoc
class _$InputViewSettingsStateCopyWithImpl<$Res,
        $Val extends InputViewSettingsState>
    implements $InputViewSettingsStateCopyWith<$Res> {
  _$InputViewSettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fixUseDeck = null,
    Object? fixOpponentDeck = null,
    Object? fixTag = null,
    Object? draw = null,
    Object? bo3 = null,
  }) {
    return _then(_value.copyWith(
      fixUseDeck: null == fixUseDeck
          ? _value.fixUseDeck
          : fixUseDeck // ignore: cast_nullable_to_non_nullable
              as bool,
      fixOpponentDeck: null == fixOpponentDeck
          ? _value.fixOpponentDeck
          : fixOpponentDeck // ignore: cast_nullable_to_non_nullable
              as bool,
      fixTag: null == fixTag
          ? _value.fixTag
          : fixTag // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$InputViewSettingsStateImplCopyWith<$Res>
    implements $InputViewSettingsStateCopyWith<$Res> {
  factory _$$InputViewSettingsStateImplCopyWith(
          _$InputViewSettingsStateImpl value,
          $Res Function(_$InputViewSettingsStateImpl) then) =
      __$$InputViewSettingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool fixUseDeck,
      bool fixOpponentDeck,
      bool fixTag,
      bool draw,
      bool bo3});
}

/// @nodoc
class __$$InputViewSettingsStateImplCopyWithImpl<$Res>
    extends _$InputViewSettingsStateCopyWithImpl<$Res,
        _$InputViewSettingsStateImpl>
    implements _$$InputViewSettingsStateImplCopyWith<$Res> {
  __$$InputViewSettingsStateImplCopyWithImpl(
      _$InputViewSettingsStateImpl _value,
      $Res Function(_$InputViewSettingsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fixUseDeck = null,
    Object? fixOpponentDeck = null,
    Object? fixTag = null,
    Object? draw = null,
    Object? bo3 = null,
  }) {
    return _then(_$InputViewSettingsStateImpl(
      fixUseDeck: null == fixUseDeck
          ? _value.fixUseDeck
          : fixUseDeck // ignore: cast_nullable_to_non_nullable
              as bool,
      fixOpponentDeck: null == fixOpponentDeck
          ? _value.fixOpponentDeck
          : fixOpponentDeck // ignore: cast_nullable_to_non_nullable
              as bool,
      fixTag: null == fixTag
          ? _value.fixTag
          : fixTag // ignore: cast_nullable_to_non_nullable
              as bool,
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

class _$InputViewSettingsStateImpl implements _InputViewSettingsState {
  _$InputViewSettingsStateImpl(
      {this.fixUseDeck = false,
      this.fixOpponentDeck = false,
      this.fixTag = false,
      this.draw = false,
      this.bo3 = false});

  @override
  @JsonKey()
  final bool fixUseDeck;
  @override
  @JsonKey()
  final bool fixOpponentDeck;
  @override
  @JsonKey()
  final bool fixTag;
  @override
  @JsonKey()
  final bool draw;
  @override
  @JsonKey()
  final bool bo3;

  @override
  String toString() {
    return 'InputViewSettingsState(fixUseDeck: $fixUseDeck, fixOpponentDeck: $fixOpponentDeck, fixTag: $fixTag, draw: $draw, bo3: $bo3)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InputViewSettingsStateImpl &&
            (identical(other.fixUseDeck, fixUseDeck) ||
                other.fixUseDeck == fixUseDeck) &&
            (identical(other.fixOpponentDeck, fixOpponentDeck) ||
                other.fixOpponentDeck == fixOpponentDeck) &&
            (identical(other.fixTag, fixTag) || other.fixTag == fixTag) &&
            (identical(other.draw, draw) || other.draw == draw) &&
            (identical(other.bo3, bo3) || other.bo3 == bo3));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, fixUseDeck, fixOpponentDeck, fixTag, draw, bo3);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InputViewSettingsStateImplCopyWith<_$InputViewSettingsStateImpl>
      get copyWith => __$$InputViewSettingsStateImplCopyWithImpl<
          _$InputViewSettingsStateImpl>(this, _$identity);
}

abstract class _InputViewSettingsState implements InputViewSettingsState {
  factory _InputViewSettingsState(
      {final bool fixUseDeck,
      final bool fixOpponentDeck,
      final bool fixTag,
      final bool draw,
      final bool bo3}) = _$InputViewSettingsStateImpl;

  @override
  bool get fixUseDeck;
  @override
  bool get fixOpponentDeck;
  @override
  bool get fixTag;
  @override
  bool get draw;
  @override
  bool get bo3;
  @override
  @JsonKey(ignore: true)
  _$$InputViewSettingsStateImplCopyWith<_$InputViewSettingsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
