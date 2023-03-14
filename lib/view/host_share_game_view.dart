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
    final currentIndex = ref.watch(currentShareIndexProvider);
    return hostShareList.maybeWhen(
      data: (data) => SliverListEx.separated(
        itemCount: data[currentIndex].shareUserList.length,
        itemBuilder: (context, index) => ListTileOnTap(
          title: data[currentIndex].shareUserList[index].id,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProviderScope(
                overrides: [
                  currentShareUserProvider.overrideWithValue(data[currentIndex].shareUserList[index]),
                  currentShare.overrideWithValue(data[currentIndex]),
                ],
                child: const SharedUserView(),
              ),
            ),
          ),
        ),
        separatorBuilder: (context, index) => const Divider(indent: 16, thickness: 1, height: 0),
      ),
      orElse: () => SliverToBoxAdapter(child: Container()),
    );
  }
}

class _PendingUserSliverList extends HookConsumerWidget {
  const _PendingUserSliverList();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hostShareList = ref.watch(hostShareDataProvider);
    final currentIndex = ref.watch(currentShareIndexProvider);
    return hostShareList.maybeWhen(
      data: (data) => SliverListEx.separated(
        itemCount: data[currentIndex].pendingUserList.length,
        itemBuilder: (context, index) => ListTileOnTap(
          title: data[currentIndex].pendingUserList[index].id,
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () async => await ref.read(firestoreShareRepository).noallowSharing(
                    data[currentIndex].pendingUserList[index], '${data[currentIndex].ownerName}-${data[currentIndex].game.name}'),
                child: Icon(
                  Icons.remove_circle,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () async => await ref.read(firestoreShareRepository).allowSharing(
                    data[currentIndex].pendingUserList[index], '${data[currentIndex].ownerName}-${data[currentIndex].game.name}'),
                child: Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ],
          ),
        ),
        separatorBuilder: (context, index) => const Divider(indent: 16, thickness: 1, height: 0),
      ),
      orElse: () => SliverToBoxAdapter(child: Container()),
    );
  }
}

class _CreateShareLinkButton extends HookConsumerWidget {
  const _CreateShareLinkButton();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hostShareList = ref.watch(hostShareDataProvider);
    final currentIndex = ref.watch(currentShareIndexProvider);
    return SliverToBoxAdapter(
      child: hostShareList.maybeWhen(
        data: (data) => ListTileOnTap(
          title: '共有用リンクを作成',
          onTap: () async {
            final link = await ref.read(dynamicLinksRepository).createInviteDynamicLink(
                  data[currentIndex].ownerName,
                  data[currentIndex].game.name,
                  AccessRoll.writer,
                );
            await Share.share(link.toString());
          },
        ),
        orElse: () => Container(),
      ),
    );
  }
}
