// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firestore_backup.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FirestoreBackup _$FirestoreBackupFromJson(Map<String, dynamic> json) {
  return _FirestoreBackup.fromJson(json);
}

/// @nodoc
mixin _$FirestoreBackup {
  List<Game> get gameList => throw _privateConstructorUsedError;
  List<Deck> get deckList => throw _privateConstructorUsedError;
  List<Tag> get tagList => throw _privateConstructorUsedError;
  List<Record> get recordList => throw _privateConstructorUsedError;
  DateTime? get lastBackup => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirestoreBackupCopyWith<FirestoreBackup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirestoreBackupCopyWith<$Res> {
  factory $FirestoreBackupCopyWith(
          FirestoreBackup value, $Res Function(FirestoreBackup) then) =
      _$FirestoreBackupCopyWithImpl<$Res, FirestoreBackup>;
  @useResult
  $Res call(
      {List<Game> gameList,
      List<Deck> deckList,
      List<Tag> tagList,
      List<Record> recordList,
      DateTime? lastBackup});
}

/// @nodoc
class _$FirestoreBackupCopyWithImpl<$Res, $Val extends FirestoreBackup>
    implements $FirestoreBackupCopyWith<$Res> {
  _$FirestoreBackupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameList = null,
    Object? deckList = null,
    Object? tagList = null,
    Object? recordList = null,
    Object? lastBackup = freezed,
  }) {
    return _then(_value.copyWith(
      gameList: null == gameList
          ? _value.gameList
          : gameList // ignore: cast_nullable_to_non_nullable
              as List<Game>,
      deckList: null == deckList
          ? _value.deckList
          : deckList // ignore: cast_nullable_to_non_nullable
              as List<Deck>,
      tagList: null == tagList
          ? _value.tagList
          : tagList // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
      recordList: null == recordList
          ? _value.recordList
          : recordList // ignore: cast_nullable_to_non_nullable
              as List<Record>,
      lastBackup: freezed == lastBackup
          ? _value.lastBackup
          : lastBackup // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FirestoreBackupImplCopyWith<$Res>
    implements $FirestoreBackupCopyWith<$Res> {
  factory _$$FirestoreBackupImplCopyWith(_$FirestoreBackupImpl value,
          $Res Function(_$FirestoreBackupImpl) then) =
      __$$FirestoreBackupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Game> gameList,
      List<Deck> deckList,
      List<Tag> tagList,
      List<Record> recordList,
      DateTime? lastBackup});
}

/// @nodoc
class __$$FirestoreBackupImplCopyWithImpl<$Res>
    extends _$FirestoreBackupCopyWithImpl<$Res, _$FirestoreBackupImpl>
    implements _$$FirestoreBackupImplCopyWith<$Res> {
  __$$FirestoreBackupImplCopyWithImpl(
      _$FirestoreBackupImpl _value, $Res Function(_$FirestoreBackupImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameList = null,
    Object? deckList = null,
    Object? tagList = null,
    Object? recordList = null,
    Object? lastBackup = freezed,
  }) {
    return _then(_$FirestoreBackupImpl(
      gameList: null == gameList
          ? _value._gameList
          : gameList // ignore: cast_nullable_to_non_nullable
              as List<Game>,
      deckList: null == deckList
          ? _value._deckList
          : deckList // ignore: cast_nullable_to_non_nullable
              as List<Deck>,
      tagList: null == tagList
          ? _value._tagList
          : tagList // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
      recordList: null == recordList
          ? _value._recordList
          : recordList // ignore: cast_nullable_to_non_nullable
              as List<Record>,
      lastBackup: freezed == lastBackup
          ? _value.lastBackup
          : lastBackup // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$FirestoreBackupImpl implements _FirestoreBackup {
  _$FirestoreBackupImpl(
      {final List<Game> gameList = const [],
      final List<Deck> deckList = const [],
      final List<Tag> tagList = const [],
      final List<Record> recordList = const [],
      this.lastBackup})
      : _gameList = gameList,
        _deckList = deckList,
        _tagList = tagList,
        _recordList = recordList;

  factory _$FirestoreBackupImpl.fromJson(Map<String, dynamic> json) =>
      _$$FirestoreBackupImplFromJson(json);

  final List<Game> _gameList;
  @override
  @JsonKey()
  List<Game> get gameList {
    if (_gameList is EqualUnmodifiableListView) return _gameList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_gameList);
  }

  final List<Deck> _deckList;
  @override
  @JsonKey()
  List<Deck> get deckList {
    if (_deckList is EqualUnmodifiableListView) return _deckList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deckList);
  }

  final List<Tag> _tagList;
  @override
  @JsonKey()
  List<Tag> get tagList {
    if (_tagList is EqualUnmodifiableListView) return _tagList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tagList);
  }

  final List<Record> _recordList;
  @override
  @JsonKey()
  List<Record> get recordList {
    if (_recordList is EqualUnmodifiableListView) return _recordList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recordList);
  }

  @override
  final DateTime? lastBackup;

  @override
  String toString() {
    return 'FirestoreBackup(gameList: $gameList, deckList: $deckList, tagList: $tagList, recordList: $recordList, lastBackup: $lastBackup)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FirestoreBackupImpl &&
            const DeepCollectionEquality().equals(other._gameList, _gameList) &&
            const DeepCollectionEquality().equals(other._deckList, _deckList) &&
            const DeepCollectionEquality().equals(other._tagList, _tagList) &&
            const DeepCollectionEquality()
                .equals(other._recordList, _recordList) &&
            (identical(other.lastBackup, lastBackup) ||
                other.lastBackup == lastBackup));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_gameList),
      const DeepCollectionEquality().hash(_deckList),
      const DeepCollectionEquality().hash(_tagList),
      const DeepCollectionEquality().hash(_recordList),
      lastBackup);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FirestoreBackupImplCopyWith<_$FirestoreBackupImpl> get copyWith =>
      __$$FirestoreBackupImplCopyWithImpl<_$FirestoreBackupImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FirestoreBackupImplToJson(
      this,
    );
  }
}

abstract class _FirestoreBackup implements FirestoreBackup {
  factory _FirestoreBackup(
      {final List<Game> gameList,
      final List<Deck> deckList,
      final List<Tag> tagList,
      final List<Record> recordList,
      final DateTime? lastBackup}) = _$FirestoreBackupImpl;

  factory _FirestoreBackup.fromJson(Map<String, dynamic> json) =
      _$FirestoreBackupImpl.fromJson;

  @override
  List<Game> get gameList;
  @override
  List<Deck> get deckList;
  @override
  List<Tag> get tagList;
  @override
  List<Record> get recordList;
  @override
  DateTime? get lastBackup;
  @override
  @JsonKey(ignore: true)
  _$$FirestoreBackupImplCopyWith<_$FirestoreBackupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
