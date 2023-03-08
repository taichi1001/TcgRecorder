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
  $Res call({List<ShareUser> pendingUserList, List<ShareUser> shareUserList});
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
    Object? pendingUserList = null,
    Object? shareUserList = null,
  }) {
    return _then(_value.copyWith(
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
}

/// @nodoc
abstract class _$$_FirestoreShareCopyWith<$Res>
    implements $FirestoreShareCopyWith<$Res> {
  factory _$$_FirestoreShareCopyWith(
          _$_FirestoreShare value, $Res Function(_$_FirestoreShare) then) =
      __$$_FirestoreShareCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ShareUser> pendingUserList, List<ShareUser> shareUserList});
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
    Object? pendingUserList = null,
    Object? shareUserList = null,
  }) {
    return _then(_$_FirestoreShare(
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
      {final List<ShareUser> pendingUserList = const [],
      final List<ShareUser> shareUserList = const []})
      : _pendingUserList = pendingUserList,
        _shareUserList = shareUserList;

  factory _$_FirestoreShare.fromJson(Map<String, dynamic> json) =>
      _$$_FirestoreShareFromJson(json);

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
    return 'FirestoreShare(pendingUserList: $pendingUserList, shareUserList: $shareUserList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FirestoreShare &&
            const DeepCollectionEquality()
                .equals(other._pendingUserList, _pendingUserList) &&
            const DeepCollectionEquality()
                .equals(other._shareUserList, _shareUserList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
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
      {final List<ShareUser> pendingUserList,
      final List<ShareUser> shareUserList}) = _$_FirestoreShare;

  factory _FirestoreShare.fromJson(Map<String, dynamic> json) =
      _$_FirestoreShare.fromJson;

  @override
  List<ShareUser> get pendingUserList;
  @override
  List<ShareUser> get shareUserList;
  @override
  @JsonKey(ignore: true)
  _$$_FirestoreShareCopyWith<_$_FirestoreShare> get copyWith =>
      throw _privateConstructorUsedError;
}
