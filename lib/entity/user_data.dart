import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data.freezed.dart';
part 'user_data.g.dart';

@freezed
class UserData with _$UserData {
  factory UserData({
    required String id,
    String? name,
    String? iconPath,
  }) = _UserData;
  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
}
