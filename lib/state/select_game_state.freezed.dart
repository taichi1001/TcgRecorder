// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SelectGameState {
  Game? get selectGame => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectGameStateCopyWith<SelectGameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectGameStateCopyWith<$Res> {
  factory $SelectGameStateCopyWith(
          SelectGameState value, $Res Function(SelectGameState) then) =
      _$SelectGameStateCopyWithImpl<$Res, SelectGameState>;
  @useResult
  $Res call({Game? selectGame});

  $GameCopyWith<$Res>? get selectGame;
}

/// @nodoc
class _$SelectGameStateCopyWithImpl<$Res, $Val extends SelectGameState>
    implements $SelectGameStateCopyWith<$Res> {
  _$SelectGameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectGame = freezed,
  }) {
    return _then(_value.copyWith(
      selectGame: freezed == selectGame
          ? _value.selectGame
          : selectGame // ignore: cast_nullable_to_non_nullable
              as Game?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GameCopyWith<$Res>? get selectGame {
    if (_value.selectGame == null) {
      return null;
    }

    return $GameCopyWith<$Res>(_value.selectGame!, (value) {
      return _then(_value.copyWith(selectGame: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SelectGameStateImplCopyWith<$Res>
    implements $SelectGameStateCopyWith<$Res> {
  factory _$$SelectGameStateImplCopyWith(_$SelectGameStateImpl value,
          $Res Function(_$SelectGameStateImpl) then) =
      __$$SelectGameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Game? selectGame});

  @override
  $GameCopyWith<$Res>? get selectGame;
}

/// @nodoc
class __$$SelectGameStateImplCopyWithImpl<$Res>
    extends _$SelectGameStateCopyWithImpl<$Res, _$SelectGameStateImpl>
    implements _$$SelectGameStateImplCopyWith<$Res> {
  __$$SelectGameStateImplCopyWithImpl(
      _$SelectGameStateImpl _value, $Res Function(_$SelectGameStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectGame = freezed,
  }) {
    return _then(_$SelectGameStateImpl(
      selectGame: freezed == selectGame
          ? _value.selectGame
          : selectGame // ignore: cast_nullable_to_non_nullable
              as Game?,
    ));
  }
}

/// @nodoc

class _$SelectGameStateImpl implements _SelectGameState {
  _$SelectGameStateImpl({this.selectGame});

  @override
  final Game? selectGame;

  @override
  String toString() {
    return 'SelectGameState(selectGame: $selectGame)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectGameStateImpl &&
            (identical(other.selectGame, selectGame) ||
                other.selectGame == selectGame));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectGame);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectGameStateImplCopyWith<_$SelectGameStateImpl> get copyWith =>
      __$$SelectGameStateImplCopyWithImpl<_$SelectGameStateImpl>(
          this, _$identity);
}

abstract class _SelectGameState implements SelectGameState {
  factory _SelectGameState({final Game? selectGame}) = _$SelectGameStateImpl;

  @override
  Game? get selectGame;
  @override
  @JsonKey(ignore: true)
  _$$SelectGameStateImplCopyWith<_$SelectGameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
