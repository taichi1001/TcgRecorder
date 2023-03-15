import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tcg_manager/entity/firestore_share.dart';
import 'package:tcg_manager/entity/share_user.dart';
import 'package:tcg_manager/enum/access_roll.dart';
import 'package:tcg_manager/repository/dynamic_links_repository.dart';
import 'package:tcg_manager/repository/firestore_share_repository.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(gameName),
      ),
      body: const CustomScrollView(
        slivers: [
          _CreateShareLinkButton(),
          SliverHeader(title: '共有中ユーザー'),
          _SharedUserSliverList(),
          SliverHeader(title: '共有申請ユーザー'),
          _PendingUserSliverList(),
          _DeleteShareGameButton(),
        ],
      ),
    );
  }
}

final currentShareUserProvider = Provider<ShareUser>((ref) => throw UnimplementedError);
final currentShare = Provider<FirestoreShare>((ref) => throw UnimplementedError);

class _SharedUserSliverList extends HookConsumerWidget {
  const _SharedUserSliverList();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hostShareList = ref.watch(hostShareDataProvider);
    final currentShareDocName = ref.watch(currentShareDocNameProvider);
    return hostShareList.maybeWhen(
      data: (data) {
        final share = data.firstWhereOrNull((element) => element.docName == currentShareDocName);
        if (share == null) return SliverToBoxAdapter(child: Container());

        return SliverListEx.separated(
          itemCount: share.shareUserList.length,
          itemBuilder: (context, index) => ListTileOnTap(
            title: share.shareUserList[index].id,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProviderScope(
                  overrides: [
                    currentShareUserProvider.overrideWithValue(share.shareUserList[index]),
                    currentShare.overrideWithValue(share),
                  ],
                  child: const SharedUserView(),
                ),
              ),
            ),
          ),
          separatorBuilder: (context, index) => const Divider(indent: 16, thickness: 1, height: 0),
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
    final hostShareList = ref.watch(hostShareDataProvider);
    final currentShareDocName = ref.watch(currentShareDocNameProvider);

    return hostShareList.maybeWhen(
      data: (data) {
        final share = data.firstWhereOrNull((element) => element.docName == currentShareDocName);
        if (share == null) return SliverToBoxAdapter(child: Container());

        return SliverListEx.separated(
          itemCount: share.pendingUserList.length,
          itemBuilder: (context, index) => ListTileOnTap(
            title: share.pendingUserList[index].id,
            trailing: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async => await ref.read(firestoreShareRepository).noallowSharing(share.pendingUserList[index], share.docName),
                  child: Icon(
                    Icons.remove_circle,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () async => await ref.read(firestoreShareRepository).allowSharing(share.pendingUserList[index], share.docName),
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
    final hostShareList = ref.watch(hostShareDataProvider);
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
                    share.ownerName,
                    share.game.name,
                    AccessRoll.writer,
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
    final hostShareList = ref.watch(hostShareDataProvider);
    final currentShareDocName = ref.watch(currentShareDocNameProvider);

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
                final result = await showOkCancelAlertDialog(
                  context: context,
                  title: 'データを削除します',
                  message: 'このゲームを共有している全員のデータが削除されます。データの復元はできなくなりますがよろしいですか？',
                );
                if (result == OkCancelResult.ok) {
                  await ref.read(firestoreShareRepository).deleteShare(share.docName);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
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
