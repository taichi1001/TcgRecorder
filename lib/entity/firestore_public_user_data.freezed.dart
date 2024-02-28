// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firestore_public_user_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FirestorePublicUserData _$FirestorePublicUserDataFromJson(
    Map<String, dynamic> json) {
  return _FirestorePublicUserData.fromJson(json);
}

/// @nodoc
mixin _$FirestorePublicUserData {
  String get uid => throw _privateConstructorUsedError;
  List<Game> get gameList => throw _privateConstructorUsedError;
  List<Deck> get deckList => throw _privateConstructorUsedError;
  List<Tag> get tagList => throw _privateConstructorUsedError;
  List<Record> get recordList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirestorePublicUserDataCopyWith<FirestorePublicUserData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirestorePublicUserDataCopyWith<$Res> {
  factory $FirestorePublicUserDataCopyWith(FirestorePublicUserData value,
          $Res Function(FirestorePublicUserData) then) =
      _$FirestorePublicUserDataCopyWithImpl<$Res, FirestorePublicUserData>;
  @useResult
  $Res call(
      {String uid,
      List<Game> gameList,
      List<Deck> deckList,
      List<Tag> tagList,
      List<Record> recordList});
}

/// @nodoc
class _$FirestorePublicUserDataCopyWithImpl<$Res,
        $Val extends FirestorePublicUserData>
    implements $FirestorePublicUserDataCopyWith<$Res> {
  _$FirestorePublicUserDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? gameList = null,
    Object? deckList = null,
    Object? tagList = null,
    Object? recordList = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FirestorePublicUserDataCopyWith<$Res>
    implements $FirestorePublicUserDataCopyWith<$Res> {
  factory _$$_FirestorePublicUserDataCopyWith(_$_FirestorePublicUserData value,
          $Res Function(_$_FirestorePublicUserData) then) =
      __$$_FirestorePublicUserDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      List<Game> gameList,
      List<Deck> deckList,
      List<Tag> tagList,
      List<Record> recordList});
}

/// @nodoc
class __$$_FirestorePublicUserDataCopyWithImpl<$Res>
    extends _$FirestorePublicUserDataCopyWithImpl<$Res,
        _$_FirestorePublicUserData>
    implements _$$_FirestorePublicUserDataCopyWith<$Res> {
  __$$_FirestorePublicUserDataCopyWithImpl(_$_FirestorePublicUserData _value,
      $Res Function(_$_FirestorePublicUserData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? gameList = null,
    Object? deckList = null,
    Object? tagList = null,
    Object? recordList = null,
  }) {
    return _then(_$_FirestorePublicUserData(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
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
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_FirestorePublicUserData implements _FirestorePublicUserData {
  _$_FirestorePublicUserData(
      {required this.uid,
      final List<Game> gameList = const [],
      final List<Deck> deckList = const [],
      final List<Tag> tagList = const [],
      final List<Record> recordList = const []})
      : _gameList = gameList,
        _deckList = deckList,
        _tagList = tagList,
        _recordList = recordList;

  factory _$_FirestorePublicUserData.fromJson(Map<String, dynamic> json) =>
      _$$_FirestorePublicUserDataFromJson(json);

  @override
  final String uid;
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
  String toString() {
    return 'FirestorePublicUserData(uid: $uid, gameList: $gameList, deckList: $deckList, tagList: $tagList, recordList: $recordList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FirestorePublicUserData &&
            (identical(other.uid, uid) || other.uid == uid) &&
            const DeepCollectionEquality().equals(other._gameList, _gameList) &&
            const DeepCollectionEquality().equals(other._deckList, _deckList) &&
            const DeepCollectionEquality().equals(other._tagList, _tagList) &&
            const DeepCollectionEquality()
                .equals(other._recordList, _recordList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      const DeepCollectionEquality().hash(_gameList),
      const DeepCollectionEquality().hash(_deckList),
      const DeepCollectionEquality().hash(_tagList),
      const DeepCollectionEquality().hash(_recordList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FirestorePublicUserDataCopyWith<_$_FirestorePublicUserData>
      get copyWith =>
          __$$_FirestorePublicUserDataCopyWithImpl<_$_FirestorePublicUserData>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FirestorePublicUserDataToJson(
      this,
    );
  }
}

abstract class _FirestorePublicUserData implements FirestorePublicUserData {
  factory _FirestorePublicUserData(
      {required final String uid,
      final List<Game> gameList,
      final List<Deck> deckList,
      final List<Tag> tagList,
      final List<Record> recordList}) = _$_FirestorePublicUserData;

  factory _FirestorePublicUserData.fromJson(Map<String, dynamic> json) =
      _$_FirestorePublicUserData.fromJson;

  @override
  String get uid;
  @override
  List<Game> get gameList;
  @override
  List<Deck> get deckList;
  @override
  List<Tag> get tagList;
  @override
  List<Record> get recordList;
  @override
  @JsonKey(ignore: true)
  _$$_FirestorePublicUserDataCopyWith<_$_FirestorePublicUserData>
      get copyWith => throw _privateConstructorUsedError;
}
