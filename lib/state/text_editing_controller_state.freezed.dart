// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text_editing_controller_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TextEditingControllerState {
  TextEditingController get useDeckController =>
      throw _privateConstructorUsedError;
  TextEditingController get opponentDeckController =>
      throw _privateConstructorUsedError;
  List<TextEditingController> get tagController =>
      throw _privateConstructorUsedError;
  TextEditingController get memoController =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TextEditingControllerStateCopyWith<TextEditingControllerState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextEditingControllerStateCopyWith<$Res> {
  factory $TextEditingControllerStateCopyWith(TextEditingControllerState value,
          $Res Function(TextEditingControllerState) then) =
      _$TextEditingControllerStateCopyWithImpl<$Res,
          TextEditingControllerState>;
  @useResult
  $Res call(
      {TextEditingController useDeckController,
      TextEditingController opponentDeckController,
      List<TextEditingController> tagController,
      TextEditingController memoController});
}

/// @nodoc
class _$TextEditingControllerStateCopyWithImpl<$Res,
        $Val extends TextEditingControllerState>
    implements $TextEditingControllerStateCopyWith<$Res> {
  _$TextEditingControllerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? useDeckController = null,
    Object? opponentDeckController = null,
    Object? tagController = null,
    Object? memoController = null,
  }) {
    return _then(_value.copyWith(
      useDeckController: null == useDeckController
          ? _value.useDeckController
          : useDeckController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      opponentDeckController: null == opponentDeckController
          ? _value.opponentDeckController
          : opponentDeckController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      tagController: null == tagController
          ? _value.tagController
          : tagController // ignore: cast_nullable_to_non_nullable
              as List<TextEditingController>,
      memoController: null == memoController
          ? _value.memoController
          : memoController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TextEditingControllerStateImplCopyWith<$Res>
    implements $TextEditingControllerStateCopyWith<$Res> {
  factory _$$TextEditingControllerStateImplCopyWith(
          _$TextEditingControllerStateImpl value,
          $Res Function(_$TextEditingControllerStateImpl) then) =
      __$$TextEditingControllerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TextEditingController useDeckController,
      TextEditingController opponentDeckController,
      List<TextEditingController> tagController,
      TextEditingController memoController});
}

/// @nodoc
class __$$TextEditingControllerStateImplCopyWithImpl<$Res>
    extends _$TextEditingControllerStateCopyWithImpl<$Res,
        _$TextEditingControllerStateImpl>
    implements _$$TextEditingControllerStateImplCopyWith<$Res> {
  __$$TextEditingControllerStateImplCopyWithImpl(
      _$TextEditingControllerStateImpl _value,
      $Res Function(_$TextEditingControllerStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? useDeckController = null,
    Object? opponentDeckController = null,
    Object? tagController = null,
    Object? memoController = null,
  }) {
    return _then(_$TextEditingControllerStateImpl(
      useDeckController: null == useDeckController
          ? _value.useDeckController
          : useDeckController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      opponentDeckController: null == opponentDeckController
          ? _value.opponentDeckController
          : opponentDeckController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      tagController: null == tagController
          ? _value._tagController
          : tagController // ignore: cast_nullable_to_non_nullable
              as List<TextEditingController>,
      memoController: null == memoController
          ? _value.memoController
          : memoController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
    ));
  }
}

/// @nodoc

class _$TextEditingControllerStateImpl implements _TextEditingControllerState {
  _$TextEditingControllerStateImpl(
      {required this.useDeckController,
      required this.opponentDeckController,
      required final List<TextEditingController> tagController,
      required this.memoController})
      : _tagController = tagController;

  @override
  final TextEditingController useDeckController;
  @override
  final TextEditingController opponentDeckController;
  final List<TextEditingController> _tagController;
  @override
  List<TextEditingController> get tagController {
    if (_tagController is EqualUnmodifiableListView) return _tagController;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tagController);
  }

  @override
  final TextEditingController memoController;

  @override
  String toString() {
    return 'TextEditingControllerState(useDeckController: $useDeckController, opponentDeckController: $opponentDeckController, tagController: $tagController, memoController: $memoController)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextEditingControllerStateImpl &&
            (identical(other.useDeckController, useDeckController) ||
                other.useDeckController == useDeckController) &&
            (identical(other.opponentDeckController, opponentDeckController) ||
                other.opponentDeckController == opponentDeckController) &&
            const DeepCollectionEquality()
                .equals(other._tagController, _tagController) &&
            (identical(other.memoController, memoController) ||
                other.memoController == memoController));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      useDeckController,
      opponentDeckController,
      const DeepCollectionEquality().hash(_tagController),
      memoController);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TextEditingControllerStateImplCopyWith<_$TextEditingControllerStateImpl>
      get copyWith => __$$TextEditingControllerStateImplCopyWithImpl<
          _$TextEditingControllerStateImpl>(this, _$identity);
}

abstract class _TextEditingControllerState
    implements TextEditingControllerState {
  factory _TextEditingControllerState(
          {required final TextEditingController useDeckController,
          required final TextEditingController opponentDeckController,
          required final List<TextEditingController> tagController,
          required final TextEditingController memoController}) =
      _$TextEditingControllerStateImpl;

  @override
  TextEditingController get useDeckController;
  @override
  TextEditingController get opponentDeckController;
  @override
  List<TextEditingController> get tagController;
  @override
  TextEditingController get memoController;
  @override
  @JsonKey(ignore: true)
  _$$TextEditingControllerStateImplCopyWith<_$TextEditingControllerStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
