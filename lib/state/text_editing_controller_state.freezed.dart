// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'text_editing_controller_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TextEditingControllerStateTearOff {
  const _$TextEditingControllerStateTearOff();

  _TextEditingControllerState call(
      {required TextEditingController useDeckController,
      required TextEditingController opponentDeckController,
      required TextEditingController tagController}) {
    return _TextEditingControllerState(
      useDeckController: useDeckController,
      opponentDeckController: opponentDeckController,
      tagController: tagController,
    );
  }
}

/// @nodoc
const $TextEditingControllerState = _$TextEditingControllerStateTearOff();

/// @nodoc
mixin _$TextEditingControllerState {
  TextEditingController get useDeckController =>
      throw _privateConstructorUsedError;
  TextEditingController get opponentDeckController =>
      throw _privateConstructorUsedError;
  TextEditingController get tagController => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TextEditingControllerStateCopyWith<TextEditingControllerState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextEditingControllerStateCopyWith<$Res> {
  factory $TextEditingControllerStateCopyWith(TextEditingControllerState value,
          $Res Function(TextEditingControllerState) then) =
      _$TextEditingControllerStateCopyWithImpl<$Res>;
  $Res call(
      {TextEditingController useDeckController,
      TextEditingController opponentDeckController,
      TextEditingController tagController});
}

/// @nodoc
class _$TextEditingControllerStateCopyWithImpl<$Res>
    implements $TextEditingControllerStateCopyWith<$Res> {
  _$TextEditingControllerStateCopyWithImpl(this._value, this._then);

  final TextEditingControllerState _value;
  // ignore: unused_field
  final $Res Function(TextEditingControllerState) _then;

  @override
  $Res call({
    Object? useDeckController = freezed,
    Object? opponentDeckController = freezed,
    Object? tagController = freezed,
  }) {
    return _then(_value.copyWith(
      useDeckController: useDeckController == freezed
          ? _value.useDeckController
          : useDeckController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      opponentDeckController: opponentDeckController == freezed
          ? _value.opponentDeckController
          : opponentDeckController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      tagController: tagController == freezed
          ? _value.tagController
          : tagController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
    ));
  }
}

/// @nodoc
abstract class _$TextEditingControllerStateCopyWith<$Res>
    implements $TextEditingControllerStateCopyWith<$Res> {
  factory _$TextEditingControllerStateCopyWith(
          _TextEditingControllerState value,
          $Res Function(_TextEditingControllerState) then) =
      __$TextEditingControllerStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {TextEditingController useDeckController,
      TextEditingController opponentDeckController,
      TextEditingController tagController});
}

/// @nodoc
class __$TextEditingControllerStateCopyWithImpl<$Res>
    extends _$TextEditingControllerStateCopyWithImpl<$Res>
    implements _$TextEditingControllerStateCopyWith<$Res> {
  __$TextEditingControllerStateCopyWithImpl(_TextEditingControllerState _value,
      $Res Function(_TextEditingControllerState) _then)
      : super(_value, (v) => _then(v as _TextEditingControllerState));

  @override
  _TextEditingControllerState get _value =>
      super._value as _TextEditingControllerState;

  @override
  $Res call({
    Object? useDeckController = freezed,
    Object? opponentDeckController = freezed,
    Object? tagController = freezed,
  }) {
    return _then(_TextEditingControllerState(
      useDeckController: useDeckController == freezed
          ? _value.useDeckController
          : useDeckController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      opponentDeckController: opponentDeckController == freezed
          ? _value.opponentDeckController
          : opponentDeckController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      tagController: tagController == freezed
          ? _value.tagController
          : tagController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
    ));
  }
}

/// @nodoc

class _$_TextEditingControllerState implements _TextEditingControllerState {
  _$_TextEditingControllerState(
      {required this.useDeckController,
      required this.opponentDeckController,
      required this.tagController});

  @override
  final TextEditingController useDeckController;
  @override
  final TextEditingController opponentDeckController;
  @override
  final TextEditingController tagController;

  @override
  String toString() {
    return 'TextEditingControllerState(useDeckController: $useDeckController, opponentDeckController: $opponentDeckController, tagController: $tagController)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TextEditingControllerState &&
            const DeepCollectionEquality()
                .equals(other.useDeckController, useDeckController) &&
            const DeepCollectionEquality()
                .equals(other.opponentDeckController, opponentDeckController) &&
            const DeepCollectionEquality()
                .equals(other.tagController, tagController));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(useDeckController),
      const DeepCollectionEquality().hash(opponentDeckController),
      const DeepCollectionEquality().hash(tagController));

  @JsonKey(ignore: true)
  @override
  _$TextEditingControllerStateCopyWith<_TextEditingControllerState>
      get copyWith => __$TextEditingControllerStateCopyWithImpl<
          _TextEditingControllerState>(this, _$identity);
}

abstract class _TextEditingControllerState
    implements TextEditingControllerState {
  factory _TextEditingControllerState(
          {required TextEditingController useDeckController,
          required TextEditingController opponentDeckController,
          required TextEditingController tagController}) =
      _$_TextEditingControllerState;

  @override
  TextEditingController get useDeckController;
  @override
  TextEditingController get opponentDeckController;
  @override
  TextEditingController get tagController;
  @override
  @JsonKey(ignore: true)
  _$TextEditingControllerStateCopyWith<_TextEditingControllerState>
      get copyWith => throw _privateConstructorUsedError;
}
