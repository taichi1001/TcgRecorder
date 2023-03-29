import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_info_settings_state.freezed.dart';

@freezed
abstract class UserInfoSettingsState with _$UserInfoSettingsState {
  factory UserInfoSettingsState({
    required final String id,
    final String? name,
    final String? iconPath,
    @Default(false) final bool isPhoneAuth,
    @Default(false) final bool isPremium,
  }) = _UserInfoSettingsState;
}
