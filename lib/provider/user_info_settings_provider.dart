import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';
import 'package:tcg_manager/state/user_info_settings_state.dart';

class UserInfoSettingsNotifier extends StateNotifier<UserInfoSettingsState> {
  UserInfoSettingsNotifier({
    required this.ref,
    required UserInfoSettingsState state,
  }) : super(state) {
    _init();
  }

  final Ref ref;

  // TODO name,iconをfirestoreから取得する処理を記述
  Future _init() async {}
}

final userInfoSettingsProvider = StateNotifierProvider<UserInfoSettingsNotifier, UserInfoSettingsState>((ref) {
  final user = ref.watch(firebaseAuthNotifierProvider).user;
  final revenucat = ref.watch(revenueCatNotifierProvider);
  final uid = user?.uid;
  final isPhoneAuth = user?.phoneNumber != null;
  final isPremium = revenucat.isPremium;

  final state = UserInfoSettingsState(
    id: uid ?? '名前未設定',
    isPhoneAuth: isPhoneAuth,
    isPremium: isPremium,
  );

  final userInfoSettingsNotifier = UserInfoSettingsNotifier(ref: ref, state: state);

  return userInfoSettingsNotifier;
});
