import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/enum/access_roll.dart';

part 'share_user.freezed.dart';
part 'share_user.g.dart';

@freezed
class ShareUser with _$ShareUser {
  factory ShareUser({
    required String id,
    @Default(AccessRoll.reader) AccessRoll roll,
  }) = _ShareUser;
  factory ShareUser.fromJson(Map<String, dynamic> json) => _$ShareUserFromJson(json);
}
