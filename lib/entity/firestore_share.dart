import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/entity/share_user.dart';

part 'firestore_share.freezed.dart';
part 'firestore_share.g.dart';

@freezed
class FirestoreShare with _$FirestoreShare {
  @JsonSerializable(explicitToJson: true)
  factory FirestoreShare({
    @Default([]) List<ShareUser> pendingUserList,
    @Default([]) List<ShareUser> shareUserList,
  }) = _FirestoreShare;

  factory FirestoreShare.fromJson(Map<String, dynamic> json) => _$FirestoreShareFromJson(json);
}
