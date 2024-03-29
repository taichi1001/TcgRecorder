import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/user_data.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/provider/firestore_controller_provider.dart';
import 'package:tcg_manager/repository/firestore_invite_code_repository.dart';
import 'package:tcg_manager/repository/firestore_share_repository.dart';
import 'package:tcg_manager/repository/firestore_user_settings_repositroy.dart';
import 'package:tcg_manager/view/component/list_tile_ontap.dart';
import 'package:tcg_manager/view/component/loading_overlay.dart';
import 'package:tcg_manager/view/select_domain_data_bottom_sheet/domain_data_options.dart';
import 'package:tcg_manager/view/share_view/invite_code_modal.dart';
import 'package:tcg_manager/view/share_view/shared_user_view.dart';

final currentShareUserListProvider = StreamProvider.autoDispose<List<UserData>?>((ref) async* {
  final currentShare = await ref.watch(currentShareProvider.future);
  if (currentShare == null) {
    yield null;
  } else {
    final currentShareUserList = await ref.watch(userDataListProvider(currentShare.shareUserList.map((e) => e.id).toList()).future);
    yield currentShareUserList;
  }
});

final currentPendingUserListProvider = StreamProvider.autoDispose<List<UserData>?>((ref) async* {
  final currentShare = await ref.watch(currentShareProvider.future);
  if (currentShare == null) {
    yield null;
  } else {
    final currentPendingUserList = await ref.watch(userDataListProvider(currentShare.pendingUserList.map((e) => e.id).toList()).future);
    yield currentPendingUserList;
  }
});

final currentDataProvider = StreamProvider.autoDispose((ref) async* {
  final currentShare = await ref.watch(currentShareProvider.future);
  final currentShareUserDataList = await ref.watch(currentShareUserListProvider.future);
  final currentPendingUserDataList = await ref.watch(currentPendingUserListProvider.future);
  yield (
    currentShare: currentShare,
    currentShareUserDataList: currentShareUserDataList,
    currentPendingUserDataList: currentPendingUserDataList,
  );
});

class ShareUserManagementView extends HookConsumerWidget {
  const ShareUserManagementView({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myId = ref.watch(firebaseAuthNotifierProvider).user?.uid;
    final currentDataAsyncValue = ref.watch(currentDataProvider);
    return currentDataAsyncValue.when(
      error: (error, stack) => Text('$error'),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      data: (currentData) {
        final (:currentPendingUserDataList, :currentShare, :currentShareUserDataList) = currentData;
        if (currentShare == null) return Container();
        final ownerUserData = currentShareUserDataList!.firstWhere((element) => element.id == currentShare.authorName);
        final shareUserDataWithOwnerRemoved = currentShareUserDataList.where((element) => element != ownerUserData).toList();
        final isOwner = currentShare.authorName == myId;
        return Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          appBar: AppBar(
            title: Text(currentShare.game.name),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.help),
              ),
            ],
          ),
          body: Stack(
            children: [
              CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: ListTileOnTap(
                      leading: const Icon(Icons.link),
                      title: '招待コードを表示',
                      onTap: () async {
                        final inviteCode = await ref.read(firestoreInviteCodeRepository).createInviteCode(currentShare.docName);
                        if (context.mounted) {
                          await inviteCodeDialog(context, inviteCode);
                        }
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text('オーナー', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ListTileOnTap(
                      title: ownerUserData.name ?? ownerUserData.id,
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        backgroundImage: ownerUserData.iconPath == null ? null : CachedNetworkImageProvider(ownerUserData.iconPath!),
                        child: ownerUserData.iconPath == null ? Text(ownerUserData.name![0]) : null,
                      ),
                      onTap: () {},
                    ),
                  ),
                  if (isOwner)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Text('共有申請中', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  if (isOwner)
                    _UserDataSliverList(
                      userDataList: currentPendingUserDataList!,
                      trailing: (index) => Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () async => await ref
                                .read(firestoreShareRepository)
                                .noallowSharing(currentShare.pendingUserList[index], currentShare.docName),
                            child: Icon(
                              Icons.remove_circle,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () async => await ref
                                .read(firestoreShareRepository)
                                .allowSharing(currentShare.pendingUserList[index], currentShare.docName),
                            child: Icon(
                              Icons.check_circle,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text('アクセス管理', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  _UserDataSliverList(
                    userDataList: shareUserDataWithOwnerRemoved,
                    onTap: (index) {
                      final tmp = [...currentShare.shareUserList];
                      tmp.removeAt(0); // ownerを削除
                      ref.read(currentSharedUserViewDataProvider.notifier).state = (
                        shareUserDataWithOwnerRemoved[index],
                        tmp[index],
                        currentShare,
                      );
                      return Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SharedUserView(),
                        ),
                      );
                    },
                  ),
                  const _RevokeShareGameButton(),
                ],
              ),
              const LoadingOverlay(),
            ],
          ),
        );
      },
    );
  }
}

class _UserDataSliverList extends StatelessWidget {
  const _UserDataSliverList({
    required this.userDataList,
    this.onTap,
    this.trailing,
    key,
  }) : super(key: key);
  final List<UserData> userDataList;
  final Function(int index)? onTap;
  final Widget? Function(int index)? trailing;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: userDataList.length,
      itemBuilder: (context, index) {
        return ListTileOnTap(
          title: userDataList[index].name ?? userDataList[index].id,
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Theme.of(context).colorScheme.primary,
            backgroundImage: userDataList[index].iconPath == null ? null : CachedNetworkImageProvider(userDataList[index].iconPath!),
            child: userDataList[index].iconPath == null ? Text(userDataList[index].name![0]) : null,
          ),
          trailing: trailing != null ? trailing!(index) : null,
          onTap: onTap != null
              ? () {
                  onTap!(index);
                }
              : null,
        );
      },
    );
  }
}

class _RevokeShareGameButton extends HookConsumerWidget {
  const _RevokeShareGameButton();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myself = ref.watch(firebaseAuthNotifierProvider.select((value) => value.user));
    final currentDataAsyncValue = ref.watch(currentDataProvider);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 48),
        child: currentDataAsyncValue.maybeWhen(
          data: (data) {
            return InkWell(
              onTap: () async {
                if (data.currentShare!.authorName == myself?.uid) {
                  final result = await showOkCancelAlertDialog(
                    context: context,
                    title: '共有を解除します',
                    message: '共有が解除されると他のユーザーはデータが閲覧できなくなります。あなたは引き続き全てのデータを閲覧可能です。',
                  );
                  if (result == OkCancelResult.ok) {
                    ref.read(loadingProvider.notifier).state = true;
                    await ref.read(firestoreControllerProvider).revokeGameSharing(data.currentShare!);
                    ref.read(loadingProvider.notifier).state = false;
                    ref.invalidate(hostShareCountProvider);
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                    await ref.read(firestoreControllerProvider).deleteShareGame(data.currentShare!.docName);
                  }
                } else {
                  await showOkAlertDialog(
                    context: context,
                    title: '権限がありません。',
                    message: 'データの削除はこのゲームの作成者のみ許可されています。',
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    '共有を解除',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ),
            );
          },
          orElse: () => Container(),
        ),
      ),
    );
  }
}
