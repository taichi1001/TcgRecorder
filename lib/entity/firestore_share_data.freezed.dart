// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firestore_share_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FirestoreShareData _$FirestoreShareDataFromJson(Map<String, dynamic> json) {
  return _FirestoreShareData.fromJson(json);
}

/// @nodoc
mixin _$FirestoreShareData {
  Game get game => throw _privateConstructorUsedError;
  List<Deck> get deckList => throw _privateConstructorUsedError;
  List<Tag> get tagList => throw _privateConstructorUsedError;
  List<Record> get recordList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirestoreShareDataCopyWith<FirestoreShareData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirestoreShareDataCopyWith<$Res> {
  factory $FirestoreShareDataCopyWith(
          FirestoreShareData value, $Res Function(FirestoreShareData) then) =
      _$FirestoreShareDataCopyWithImpl<$Res, FirestoreShareData>;
  @useResult
  $Res call(
      {Game game,
      List<Deck> deckList,
      List<Tag> tagList,
      List<Record> recordList});

  $GameCopyWith<$Res> get game;
}

/// @nodoc
class _$FirestoreShareDataCopyWithImpl<$Res, $Val extends FirestoreShareData>
    implements $FirestoreShareDataCopyWith<$Res> {
  _$FirestoreShareDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? game = null,
    Object? deckList = null,
    Object? tagList = null,
    Object? recordList = null,
  }) {
    return _then(_value.copyWith(
      game: null == game
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as Game,
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

  @override
  @pragma('vm:prefer-inline')
  $GameCopyWith<$Res> get game {
    return $GameCopyWith<$Res>(_value.game, (value) {
      return _then(_value.copyWith(game: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_FirestoreShareDataCopyWith<$Res>
    implements $FirestoreShareDataCopyWith<$Res> {
  factory _$$_FirestoreShareDataCopyWith(_$_FirestoreShareData value,
          $Res Function(_$_FirestoreShareData) then) =
      __$$_FirestoreShareDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Game game,
      List<Deck> deckList,
      List<Tag> tagList,
      List<Record> recordList});

  @override
  $GameCopyWith<$Res> get game;
}

/// @nodoc
class __$$_FirestoreShareDataCopyWithImpl<$Res>
    extends _$FirestoreShareDataCopyWithImpl<$Res, _$_FirestoreShareData>
    implements _$$_FirestoreShareDataCopyWith<$Res> {
  __$$_FirestoreShareDataCopyWithImpl(
      _$_FirestoreShareData _value, $Res Function(_$_FirestoreShareData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? game = null,
    Object? deckList = null,
    Object? tagList = null,
    Object? recordList = null,
  }) {
    return _then(_$_FirestoreShareData(
      game: null == game
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as Game,
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
class _$_FirestoreShareData implements _FirestoreShareData {
  _$_FirestoreShareData(
      {required this.game,
      final List<Deck> deckList = const [],
      final List<Tag> tagList = const [],
      final List<Record> recordList = const []})
      : _deckList = deckList,
        _tagList = tagList,
        _recordList = recordList;

  factory _$_FirestoreShareData.fromJson(Map<String, dynamic> json) =>
      _$$_FirestoreShareDataFromJson(json);

  @override
  final Game game;
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
    return 'FirestoreShareData(game: $game, deckList: $deckList, tagList: $tagList, recordList: $recordList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FirestoreShareData &&
            (identical(other.game, game) || other.game == game) &&
            const DeepCollectionEquality().equals(other._deckList, _deckList) &&
            const DeepCollectionEquality().equals(other._tagList, _tagList) &&
            const DeepCollectionEquality()
                .equals(other._recordList, _recordList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      game,
      const DeepCollectionEquality().hash(_deckList),
      const DeepCollectionEquality().hash(_tagList),
      const DeepCollectionEquality().hash(_recordList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FirestoreShareDataCopyWith<_$_FirestoreShareData> get copyWith =>
      __$$_FirestoreShareDataCopyWithImpl<_$_FirestoreShareData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FirestoreShareDataToJson(
      this,
    );
  }
}

abstract class _FirestoreShareData implements FirestoreShareData {
  factory _FirestoreShareData(
      {required final Game game,
      final List<Deck> deckList,
      final List<Tag> tagList,
      final List<Record> recordList}) = _$_FirestoreShareData;

  factory _FirestoreShareData.fromJson(Map<String, dynamic> json) =
      _$_FirestoreShareData.fromJson;

  @override
  Game get game;
  @override
  List<Deck> get deckList;
  @override
  List<Tag> get tagList;
  @override
  List<Record> get recordList;
  @override
  @JsonKey(ignore: true)
  _$$_FirestoreShareDataCopyWith<_$_FirestoreShareData> get copyWith =>
      throw _privateConstructorUsedError;
}
