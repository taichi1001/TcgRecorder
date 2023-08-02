import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/view/component/list_tile_ontap.dart';
import 'package:tcg_manager/view/select_domain_data_bottom_sheet/domain_data_options.dart';

class ShareUserManagementView extends HookConsumerWidget {
  const ShareUserManagementView({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentShareAsyncValue = ref.watch(currentShareProvider);
    final currentShareUserListAsyncValue = ref.watch(currentShareUserListProvider);
    final currentPendingUserListAsyncValue = ref.watch(currentPendingUserListProvider);
    final myId = ref.watch(firebaseAuthNotifierProvider).user?.uid;
    return currentShareAsyncValue.when(
      error: (error, stack) => Text('$error'),
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (currentShare) {
        return currentShareUserListAsyncValue.when(
          error: (error, stack) => Text('$error'),
          loading: () => const Center(child: CircularProgressIndicator()),
          data: (shareUserDataList) {
            return currentPendingUserListAsyncValue.when(
              error: (error, stack) => Text('$error'),
              loading: () => const Center(child: CircularProgressIndicator()),
              data: (pendingUserDataList) {
                final ownerUserData = shareUserDataList.firstWhere((element) => element.id == currentShare.authorName);
                final shareUserDataWithOwnerRemoved = shareUserDataList.where((element) => element != ownerUserData);
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
                  body: CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: ListTileOnTap(
                          leading: const Icon(Icons.link),
                          title: '共有用リンクを作成',
                          onTap: () => ScaffoldMessenger.of(context).showSnackBar(_originalSnackBar(context)),
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
                        SliverList.builder(
                          itemCount: pendingUserDataList.length,
                          itemBuilder: ((context, index) {
                            return ListTileOnTap(
                              title: pendingUserDataList[index].name ?? pendingUserDataList[index].id,
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                backgroundImage: pendingUserDataList[index].iconPath == null
                                    ? null
                                    : CachedNetworkImageProvider(pendingUserDataList[index].iconPath!),
                                child: pendingUserDataList[index].iconPath == null ? Text(pendingUserDataList[index].name![0]) : null,
                              ),
                              onTap: () {},
                            );
                          }),
                        ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Text('アクセス管理', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SliverList.builder(
                        itemCount: shareUserDataWithOwnerRemoved.length,
                        itemBuilder: ((context, index) {
                          return ListTileOnTap(
                            title: shareUserDataList[index].name ?? shareUserDataList[index].id,
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              backgroundImage: shareUserDataList[index].iconPath == null
                                  ? null
                                  : CachedNetworkImageProvider(shareUserDataList[index].iconPath!),
                              child: shareUserDataList[index].iconPath == null ? Text(shareUserDataList[index].name![0]) : null,
                            ),
                            onTap: () {},
                          );
                        }),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

SnackBar _originalSnackBar(BuildContext context) {
  return SnackBar(
    padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
    margin: const EdgeInsetsDirectional.all(16),
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            Icons.check,
            color: Theme.of(context).colorScheme.onTertiary,
          ),
          Text(
            'リンクをコピーしました。',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
            ),
          ),
        ],
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    behavior: SnackBarBehavior.floating,
    elevation: 4.0,
    backgroundColor: Theme.of(context).colorScheme.tertiary,
    showCloseIcon: true,
    clipBehavior: Clip.hardEdge,
    dismissDirection: DismissDirection.horizontal,
  );
}
