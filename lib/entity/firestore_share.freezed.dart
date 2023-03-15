// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firestore_share.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FirestoreShare _$FirestoreShareFromJson(Map<String, dynamic> json) {
  return _FirestoreShare.fromJson(json);
}

/// @nodoc
mixin _$FirestoreShare {
  Game get game => throw _privateConstructorUsedError;
  String get ownerName => throw _privateConstructorUsedError;
  String get docName => throw _privateConstructorUsedError;
  List<ShareUser> get pendingUserList => throw _privateConstructorUsedError;
  List<ShareUser> get shareUserList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirestoreShareCopyWith<FirestoreShare> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirestoreShareCopyWith<$Res> {
  factory $FirestoreShareCopyWith(
          FirestoreShare value, $Res Function(FirestoreShare) then) =
      _$FirestoreShareCopyWithImpl<$Res, FirestoreShare>;
  @useResult
  $Res call(
      {Game game,
      String ownerName,
      String docName,
      List<ShareUser> pendingUserList,
      List<ShareUser> shareUserList});

  $GameCopyWith<$Res> get game;
}

/// @nodoc
class _$FirestoreShareCopyWithImpl<$Res, $Val extends FirestoreShare>
    implements $FirestoreShareCopyWith<$Res> {
  _$FirestoreShareCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? game = null,
    Object? ownerName = null,
    Object? docName = null,
    Object? pendingUserList = null,
    Object? shareUserList = null,
  }) {
    return _then(_value.copyWith(
      game: null == game
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as Game,
      ownerName: null == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      docName: null == docName
          ? _value.docName
          : docName // ignore: cast_nullable_to_non_nullable
              as String,
      pendingUserList: null == pendingUserList
          ? _value.pendingUserList
          : pendingUserList // ignore: cast_nullable_to_non_nullable
              as List<ShareUser>,
      shareUserList: null == shareUserList
          ? _value.shareUserList
          : shareUserList // ignore: cast_nullable_to_non_nullable
              as List<ShareUser>,
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
abstract class _$$_FirestoreShareCopyWith<$Res>
    implements $FirestoreShareCopyWith<$Res> {
  factory _$$_FirestoreShareCopyWith(
          _$_FirestoreShare value, $Res Function(_$_FirestoreShare) then) =
      __$$_FirestoreShareCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Game game,
      String ownerName,
      String docName,
      List<ShareUser> pendingUserList,
      List<ShareUser> shareUserList});

  @override
  $GameCopyWith<$Res> get game;
}

/// @nodoc
class __$$_FirestoreShareCopyWithImpl<$Res>
    extends _$FirestoreShareCopyWithImpl<$Res, _$_FirestoreShare>
    implements _$$_FirestoreShareCopyWith<$Res> {
  __$$_FirestoreShareCopyWithImpl(
      _$_FirestoreShare _value, $Res Function(_$_FirestoreShare) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? game = null,
    Object? ownerName = null,
    Object? docName = null,
    Object? pendingUserList = null,
    Object? shareUserList = null,
  }) {
    return _then(_$_FirestoreShare(
      game: null == game
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as Game,
      ownerName: null == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      docName: null == docName
          ? _value.docName
          : docName // ignore: cast_nullable_to_non_nullable
              as String,
      pendingUserList: null == pendingUserList
          ? _value._pendingUserList
          : pendingUserList // ignore: cast_nullable_to_non_nullable
              as List<ShareUser>,
      shareUserList: null == shareUserList
          ? _value._shareUserList
          : shareUserList // ignore: cast_nullable_to_non_nullable
              as List<ShareUser>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_FirestoreShare implements _FirestoreShare {
  _$_FirestoreShare(
      {required this.game,
      required this.ownerName,
      required this.docName,
      final List<ShareUser> pendingUserList = const [],
      final List<ShareUser> shareUserList = const []})
      : _pendingUserList = pendingUserList,
        _shareUserList = shareUserList;

  factory _$_FirestoreShare.fromJson(Map<String, dynamic> json) =>
      _$$_FirestoreShareFromJson(json);

  @override
  final Game game;
  @override
  final String ownerName;
  @override
  final String docName;
  final List<ShareUser> _pendingUserList;
  @override
  @JsonKey()
  List<ShareUser> get pendingUserList {
    if (_pendingUserList is EqualUnmodifiableListView) return _pendingUserList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingUserList);
  }

  final List<ShareUser> _shareUserList;
  @override
  @JsonKey()
  List<ShareUser> get shareUserList {
    if (_shareUserList is EqualUnmodifiableListView) return _shareUserList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shareUserList);
  }

  @override
  String toString() {
    return 'FirestoreShare(game: $game, ownerName: $ownerName, docName: $docName, pendingUserList: $pendingUserList, shareUserList: $shareUserList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FirestoreShare &&
            (identical(other.game, game) || other.game == game) &&
            (identical(other.ownerName, ownerName) ||
                other.ownerName == ownerName) &&
            (identical(other.docName, docName) || other.docName == docName) &&
            const DeepCollectionEquality()
                .equals(other._pendingUserList, _pendingUserList) &&
            const DeepCollectionEquality()
                .equals(other._shareUserList, _shareUserList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      game,
      ownerName,
      docName,
      const DeepCollectionEquality().hash(_pendingUserList),
      const DeepCollectionEquality().hash(_shareUserList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FirestoreShareCopyWith<_$_FirestoreShare> get copyWith =>
      __$$_FirestoreShareCopyWithImpl<_$_FirestoreShare>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FirestoreShareToJson(
      this,
    );
  }
}

abstract class _FirestoreShare implements FirestoreShare {
  factory _FirestoreShare(
      {required final Game game,
      required final String ownerName,
      required final String docName,
      final List<ShareUser> pendingUserList,
      final List<ShareUser> shareUserList}) = _$_FirestoreShare;

  factory _FirestoreShare.fromJson(Map<String, dynamic> json) =
      _$_FirestoreShare.fromJson;

  @override
  Game get game;
  @override
  String get ownerName;
  @override
  String get docName;
  @override
  List<ShareUser> get pendingUserList;
  @override
  List<ShareUser> get shareUserList;
  @override
  @JsonKey(ignore: true)
  _$$_FirestoreShareCopyWith<_$_FirestoreShare> get copyWith =>
      throw _privateConstructorUsedError;
}