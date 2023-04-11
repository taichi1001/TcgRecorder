import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/enum/access_roll.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/repository/firestore_share_repository.dart';

final selectGameAccessRoll = FutureProvider.autoDispose<AccessRoll?>((ref) async {
  final selectGame = ref.watch(selectGameNotifierProvider).selectGame;
  final myself = ref.watch(firebaseAuthNotifierProvider).user;
  if (selectGame == null) return null;
  if (!selectGame.isShare) return null;
  if (myself == null) return null;
  final hostShareList = await ref.watch(hostShareProvider.future);
  final guestShareList = await ref.watch(guestShareProvider.future);
  final shareList = [...hostShareList, ...guestShareList];
  final selectShare = shareList.firstWhere((element) => element.game == selectGame);
  final shareUser = selectShare.shareUserList.firstWhere((element) => element.id == myself.uid);
  return shareUser.roll;
});
