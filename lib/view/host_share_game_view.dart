import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tcg_manager/entity/firestore_share.dart';
import 'package:tcg_manager/entity/share_user.dart';
import 'package:tcg_manager/entity/user_data.dart';
import 'package:tcg_manager/enum/access_roll.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/provider/firestore_controller_provider.dart';
import 'package:tcg_manager/repository/dynamic_links_repository.dart';
import 'package:tcg_manager/repository/firestore_share_repository.dart';
import 'package:tcg_manager/repository/firestore_user_settings_repositroy.dart';
import 'package:tcg_manager/view/component/list_tile_ontap.dart';
import 'package:tcg_manager/view/component/sliver_header.dart';
import 'package:tcg_manager/view/share_view.dart';
import 'package:tcg_manager/view/shared_user_view.dart';

class HostShareGameView extends HookConsumerWidget {
  const HostShareGameView({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameName = ref.watch(currentShareProvider.select((value) => value.game.name));
    final currentShareDocName = ref.watch(currentShareDocNameProvider);
    final hostShareGameInfo = ref.watch(_sharedUserListProvider(currentShareDocName));
    return Scaffold(
      appBar: AppBar(
        title: Text(gameName),
      ),
      body: hostShareGameInfo.maybeWhen(
        data: (data) => const CustomScrollView(
          slivers: [
            _CreateShareLinkButton(),
            SliverHeader(title: '共有中ユーザー'),
            _SharedUserSliverList(),
            SliverHeader(title: '共有申請ユーザー'),
            _PendingUserSliverList(),
            _DeleteShareGameButton(),
          ],
        ),
        orElse: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

final currentShareUserProvider = StateProvider<ShareUser?>((ref) => null);
final currentSharedUser = Provider<SharedUser>((ref) => throw UnimplementedError);

final _sharedUserListProvider = FutureProvider.autoDispose.family<SharedUser?, String>((ref, String name) async {
  final hostShareList = await ref.watch(hostShareProvider.future);
  final share = hostShareList.firstWhereOrNull((element) => element.docName == name);
  if (share == null) return null;
  final userIdList = share.shareUserList.map((e) => e.id).toList();
  final userDataList = await ref.watch(userDataListProvider(userIdList).future);
  return SharedUser(userDataList: userDataList, share: share);
});

final _pendingUserListProvider = FutureProvider.autoDispose.family<SharedUser?, String>((ref, String name) async {
  final hostShareList = await ref.watch(hostShareProvider.future);
  final share = hostShareList.firstWhereOrNull((element) => element.docName == name);
  if (share == null) return null;
  final userIdList = share.pendingUserList.map((e) => e.id).toList();
  final userDataList = await ref.watch(userDataListProvider(userIdList).future);
  return SharedUser(userDataList: userDataList, share: share);
});

/// ホスト共有ゲーム画面での、ユーサーリストを管理するためのクラス
///
/// currentUserDataはユーザーのページに遷移時設定して使用する
class SharedUser {
  SharedUser({
    required this.userDataList,
    required this.share,
  });
  List<UserData> userDataList;
  UserData? currentUserData;
  FirestoreShare share;
}

class _SharedUserSliverList extends HookConsumerWidget {
  const _SharedUserSliverList();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentShareDocName = ref.watch(currentShareDocNameProvider);
    final userDataList = ref.watch(_sharedUserListProvider(currentShareDocName));
    return userDataList.maybeWhen(
      data: (data) {
        if (data == null) {
          return SliverToBoxAdapter(child: Container());
        }
        return SliverListEx.separated(
          itemCount: data.userDataList.length,
          separatorBuilder: (context, index) => const Divider(indent: 16, thickness: 1, height: 0),
          itemBuilder: (context, index) => ListTileOnTap(
            title: data.userDataList[index].name ?? data.userDataList[index].id,
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: Theme.of(context).colorScheme.primary,
              backgroundImage:
                  data.userDataList[index].iconPath == null ? null : CachedNetworkImageProvider(data.userDataList[index].iconPath!),
              child: data.userDataList[index].iconPath == null ? Text(data.userDataList[index].name![0]) : null,
            ),
            onTap: () {
              ref.read(currentShareUserProvider.notifier).state = data.share.shareUserList[index];
              return Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    data.currentUserData = data.userDataList[index];
                    return ProviderScope(
                      overrides: [
                        currentSharedUser.overrideWithValue(data),
                      ],
                      child: const SharedUserView(),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
      orElse: () => SliverToBoxAdapter(child: Container()),
    );
  }
}

class _PendingUserSliverList extends HookConsumerWidget {
  const _PendingUserSliverList();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentShareDocName = ref.watch(currentShareDocNameProvider);
    final userDataList = ref.watch(_pendingUserListProvider(currentShareDocName));

    return userDataList.maybeWhen(
      data: (data) {
        if (data == null) {
          return SliverToBoxAdapter(child: Container());
        }
        return SliverListEx.separated(
          itemCount: data.userDataList.length,
          itemBuilder: (context, index) => ListTileOnTap(
            title: data.userDataList[index].name ?? data.userDataList[index].id,
            trailing: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async =>
                      await ref.read(firestoreShareRepository).noallowSharing(data.share.pendingUserList[index], data.share.docName),
                  child: Icon(
                    Icons.remove_circle,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () async =>
                      await ref.read(firestoreShareRepository).allowSharing(data.share.pendingUserList[index], data.share.docName),
                  child: Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ),
          separatorBuilder: (context, index) => const Divider(indent: 16, thickness: 1, height: 0),
        );
      },
      orElse: () => SliverToBoxAdapter(child: Container()),
    );
  }
}

class _CreateShareLinkButton extends HookConsumerWidget {
  const _CreateShareLinkButton();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hostShareList = ref.watch(hostShareProvider);
    final currentShareDocName = ref.watch(currentShareDocNameProvider);

    return SliverToBoxAdapter(
      child: hostShareList.maybeWhen(
        data: (data) {
          final share = data.firstWhereOrNull((element) => element.docName == currentShareDocName);
          if (share == null) return Container();

          return ListTileOnTap(
            title: '共有用リンクを作成',
            onTap: () async {
              final link = await ref.read(dynamicLinksRepository).createInviteDynamicLink(
                    share.authorName,
                    share.game.name,
                    AccessRoll.reader,
                  );
              await Share.share(link.toString());
            },
          );
        },
        orElse: () => Container(),
      ),
    );
  }
}

class _DeleteShareGameButton extends HookConsumerWidget {
  const _DeleteShareGameButton();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hostShareList = ref.watch(hostShareProvider);
    final currentShareDocName = ref.watch(currentShareDocNameProvider);
    final myself = ref.watch(firebaseAuthNotifierProvider.select((value) => value.user));

    return SliverToBoxAdapter(
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        type: MaterialType.button,
        child: hostShareList.maybeWhen(
          data: (data) {
            final share = data.firstWhereOrNull((element) => element.docName == currentShareDocName);
            if (share == null) return Container();

            return InkWell(
              onTap: () async {
                final isAuthor = data.firstWhereOrNull((element) => element.authorName == myself?.uid) != null;
                if (isAuthor) {
                  final result = await showOkCancelAlertDialog(
                    context: context,
                    title: 'データを削除します',
                    message: 'このゲームを共有している全員のデータが削除されます。データの復元はできなくなりますがよろしいですか？',
                  );
                  if (result == OkCancelResult.ok) {
                    await ref.read(firestoreControllerProvider).deleteShareGame(share.docName);
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                } else {
                  await showOkAlertDialog(
                    context: context,
                    title: '権限がありません。',
                    message: 'データの削除はこのゲームの作成者のみ許可されています。削除したい場合はゲームの作成者に問い合わせてください。',
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'データを削除する',
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
