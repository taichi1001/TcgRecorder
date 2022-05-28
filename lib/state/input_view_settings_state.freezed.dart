// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'input_view_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$InputViewSettingsStateTearOff {
  const _$InputViewSettingsStateTearOff();

  _InputViewSettingsState call(
      {bool fixUseDeck = false,
      bool fixOpponentDeck = false,
      bool fixTag = false}) {
    return _InputViewSettingsState(
      fixUseDeck: fixUseDeck,
      fixOpponentDeck: fixOpponentDeck,
      fixTag: fixTag,
    );
  }
}

/// @nodoc
const $InputViewSettingsState = _$InputViewSettingsStateTearOff();

/// @nodoc
mixin _$InputViewSettingsState {
  bool get fixUseDeck => throw _privateConstructorUsedError;
  bool get fixOpponentDeck => throw _privateConstructorUsedError;
  bool get fixTag => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InputViewSettingsStateCopyWith<InputViewSettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InputViewSettingsStateCopyWith<$Res> {
  factory $InputViewSettingsStateCopyWith(InputViewSettingsState value,
          $Res Function(InputViewSettingsState) then) =
      _$InputViewSettingsStateCopyWithImpl<$Res>;
  $Res call({bool fixUseDeck, bool fixOpponentDeck, bool fixTag});
}

/// @nodoc
class _$InputViewSettingsStateCopyWithImpl<$Res>
    implements $InputViewSettingsStateCopyWith<$Res> {
  _$InputViewSettingsStateCopyWithImpl(this._value, this._then);

  final InputViewSettingsState _value;
  // ignore: unused_field
  final $Res Function(InputViewSettingsState) _then;

  @override
  $Res call({
    Object? fixUseDeck = freezed,
    Object? fixOpponentDeck = freezed,
    Object? fixTag = freezed,
  }) {
    return _then(_value.copyWith(
      fixUseDeck: fixUseDeck == freezed
          ? _value.fixUseDeck
          : fixUseDeck // ignore: cast_nullable_to_non_nullable
              as bool,
      fixOpponentDeck: fixOpponentDeck == freezed
          ? _value.fixOpponentDeck
          : fixOpponentDeck // ignore: cast_nullable_to_non_nullable
              as bool,
      fixTag: fixTag == freezed
          ? _value.fixTag
          : fixTag // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$InputViewSettingsStateCopyWith<$Res>
    implements $InputViewSettingsStateCopyWith<$Res> {
  factory _$InputViewSettingsStateCopyWith(_InputViewSettingsState value,
          $Res Function(_InputViewSettingsState) then) =
      __$InputViewSettingsStateCopyWithImpl<$Res>;
  @override
  $Res call({bool fixUseDeck, bool fixOpponentDeck, bool fixTag});
}

/// @nodoc
class __$InputViewSettingsStateCopyWithImpl<$Res>
    extends _$InputViewSettingsStateCopyWithImpl<$Res>
    implements _$InputViewSettingsStateCopyWith<$Res> {
  __$InputViewSettingsStateCopyWithImpl(_InputViewSettingsState _value,
      $Res Function(_InputViewSettingsState) _then)
      : super(_value, (v) => _then(v as _InputViewSettingsState));

  @override
  _InputViewSettingsState get _value => super._value as _InputViewSettingsState;

  @override
  $Res call({
    Object? fixUseDeck = freezed,
    Object? fixOpponentDeck = freezed,
    Object? fixTag = freezed,
  }) {
    return _then(_InputViewSettingsState(
      fixUseDeck: fixUseDeck == freezed
          ? _value.fixUseDeck
          : fixUseDeck // ignore: cast_nullable_to_non_nullable
              as bool,
      fixOpponentDeck: fixOpponentDeck == freezed
          ? _value.fixOpponentDeck
          : fixOpponentDeck // ignore: cast_nullable_to_non_nullable
              as bool,
      fixTag: fixTag == freezed
          ? _value.fixTag
          : fixTag // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_InputViewSettingsState implements _InputViewSettingsState {
  _$_InputViewSettingsState(
      {this.fixUseDeck = false,
      this.fixOpponentDeck = false,
      this.fixTag = false});

  @JsonKey()
  @override
  final bool fixUseDeck;
  @JsonKey()
  @override
  final bool fixOpponentDeck;
  @JsonKey()
  @override
  final bool fixTag;

  @override
  String toString() {
    return 'InputViewSettingsState(fixUseDeck: $fixUseDeck, fixOpponentDeck: $fixOpponentDeck, fixTag: $fixTag)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InputViewSettingsState &&
            const DeepCollectionEquality()
                .equals(other.fixUseDeck, fixUseDeck) &&
            const DeepCollectionEquality()
                .equals(other.fixOpponentDeck, fixOpponentDeck) &&
            const DeepCollectionEquality().equals(other.fixTag, fixTag));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(fixUseDeck),
      const DeepCollectionEquality().hash(fixOpponentDeck),
      const DeepCollectionEquality().hash(fixTag));

  @JsonKey(ignore: true)
  @override
  _$InputViewSettingsStateCopyWith<_InputViewSettingsState> get copyWith =>
      __$InputViewSettingsStateCopyWithImpl<_InputViewSettingsState>(
          this, _$identity);
}

abstract class _InputViewSettingsState implements InputViewSettingsState {
  factory _InputViewSettingsState(
      {bool fixUseDeck,
      bool fixOpponentDeck,
      bool fixTag}) = _$_InputViewSettingsState;

  @override
  bool get fixUseDeck;
  @override
  bool get fixOpponentDeck;
  @override
  bool get fixTag;
  @override
  @JsonKey(ignore: true)
  _$InputViewSettingsStateCopyWith<_InputViewSettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}
