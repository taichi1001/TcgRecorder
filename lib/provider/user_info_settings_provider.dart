import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/user_data.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';
import 'package:tcg_manager/repository/firestore_user_settings_repositroy.dart';
import 'package:tcg_manager/state/user_info_settings_state.dart';

class UserInfoSettingsNotifier extends StateNotifier<UserInfoSettingsState> {
  UserInfoSettingsNotifier({
    required this.ref,
    required UserInfoSettingsState state,
  }) : super(state) {
    _init();
  }

  final Ref ref;

  Future _init() async {
    if (state.id == null) return;
    final userData = await ref.read(firestoreUserSettingsRepository).getAll(state.id!);
    state = state.copyWith(
      name: userData.name,
      iconPath: userData.iconPath,
    );
  }

  Future setImagePath(String path) async {
    if (state.id == null) return;
    final strageRef = FirebaseStorage.instance.ref().child('user_profile/${state.id}/icon');
    await strageRef.putFile(File(path));
    final newURL = await strageRef.getDownloadURL();
    final newUserData = UserData(id: state.id!, name: state.name, iconPath: newURL);
    await ref.read(firestoreUserSettingsRepository).setAll(newUserData);
    state = state.copyWith(iconPath: newURL);
  }

  Future setUserName(String name) async {
    if (state.id == null) return;
    final newUserData = UserData(id: state.id!, name: name, iconPath: state.iconPath);
    await ref.read(firestoreUserSettingsRepository).setAll(newUserData);
    state = state.copyWith(name: name);
  }
}

final userInfoSettingsProvider = StateNotifierProvider<UserInfoSettingsNotifier, UserInfoSettingsState>((ref) {
  final user = ref.watch(firebaseAuthNotifierProvider).user;
  final revenucat = ref.watch(revenueCatNotifierProvider);
  final uid = user?.uid;
  final isPhoneAuth = user?.phoneNumber != null;
  final isPremium = revenucat.isPremium;
  final state = UserInfoSettingsState(
    id: uid,
    isPhoneAuth: isPhoneAuth,
    isPremium: isPremium,
  );
  final userInfoSettingsNotifier = UserInfoSettingsNotifier(ref: ref, state: state);

  return userInfoSettingsNotifier;
});
