import 'dart:math' as math;
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tcg_manager/entity/firestore_share.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/enum/access_roll.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/repository/dynamic_links_repository.dart';
import 'package:tcg_manager/repository/firestore_share_repository.dart';
import 'package:tcg_manager/view/component/list_tile_ontap.dart';
import 'package:tcg_manager/view/component/sliver_header.dart';
import 'package:tcg_manager/view/guest_share_game_view.dart';
import 'package:tcg_manager/view/host_share_game_view.dart';

class ShareView extends HookConsumerWidget {
  const ShareView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('ゲーム共有')),
      body: const CustomScrollView(
        slivers: [
          SliverHeader(title: 'ホスト'),
          _HostShareGameListView(),
          SliverHeader(title: 'ゲスト'),
          _GuestShareGameListView(),
          SliverHeader(title: '申請中'),
          _GuestPendingShareGameListView(),
        ],
      ),
      floatingActionButton: const _AddShareGameButton(),
    );
  }
}

class _AddShareGameButton extends HookConsumerWidget {
  const _AddShareGameButton();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () async {
        final inputText = await showTextInputDialog(
          context: context,
          title: '共有ゲーム作成',
          message: '共有用ゲーム名を入力してください。このゲームは個人保存ゲームとは別扱いとなります。',
          textFields: [const DialogTextField()],
        );
        if (inputText != null && inputText.first != '') {
          final uid = ref.read(firebaseAuthNotifierProvider).user?.uid;
          if (uid != null) {
            ref.read(firestoreShareRepository).initGame(Game(name: inputText.first), uid);
            final link = await ref.read(dynamicLinksRepository).createInviteDynamicLink(uid, inputText.first, AccessRoll.writer);
            await Share.share(link.toString(), subject: '「${inputText.first}」共有用のリンク');
          }
        }
      },
      child: const Icon(Icons.add),
    );
  }
}

final currentShareProvider = Provider<FirestoreShare>((ref) => throw UnimplementedError);
final currentShareDocNameProvider = Provider<String>((ref) => throw UnimplementedError);
final currentGameProvider = Provider<Game>((ref) => throw UnimplementedError);

class _HostShareGameListView extends HookConsumerWidget {
  const _HostShareGameListView();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hostGameList = ref.watch(hostShareDataProvider);
    return hostGameList.maybeWhen(
      data: (data) => SliverListEx.separated(
        itemCount: data.length,
        itemBuilder: (context, index) => ProviderScope(
          overrides: [
            currentShareProvider.overrideWithValue(data[index]),
          ],
          child: _ShareListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProviderScope(
                  overrides: [
                    currentShareDocNameProvider.overrideWithValue(data[index].docName),
                    currentShareProvider.overrideWithValue(data[index]),
                  ],
                  child: const HostShareGameView(),
                ),
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

class _GuestShareGameListView extends HookConsumerWidget {
  const _GuestShareGameListView();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guestGameList = ref.watch(guestShareDataProvider);
    return guestGameList.maybeWhen(
      data: (data) => SliverListEx.separated(
        itemCount: data.length,
        itemBuilder: (context, index) => ProviderScope(
          overrides: [
            currentShareProvider.overrideWithValue(data[index]),
          ],
          child: _ShareListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProviderScope(
                  overrides: [
                    currentShareProvider.overrideWithValue(data[index]),
                  ],
                  child: const GuestShareGameView(),
                ),
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

class _GuestPendingShareGameListView extends HookConsumerWidget {
  const _GuestPendingShareGameListView();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guestGameList = ref.watch(guestPendingShareDataProvider);
    return guestGameList.maybeWhen(
      data: (data) => SliverListEx.separated(
        itemCount: data.length,
        itemBuilder: (context, index) => ProviderScope(
          overrides: [
            currentShareProvider.overrideWithValue(data[index]),
          ],
          child: _ShareListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProviderScope(
                  overrides: [
                    currentShareProvider.overrideWithValue(data[index]),
                  ],
                  child: const GuestShareGameView(),
                ),
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

class _ShareListTile extends HookConsumerWidget {
  const _ShareListTile({
    this.onTap,
  });
  final Function()? onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTileOnTap(
      title: ref.watch(currentShareProvider.select((value) => value.game.name)),
      onTap: onTap,
    );
  }
}

extension SliverListEx on SliverList {
  static SliverList separated({
    required int itemCount,
    required NullableIndexedWidgetBuilder itemBuilder,
    required NullableIndexedWidgetBuilder separatorBuilder,
  }) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final itemIndex = index ~/ 2;
          return index.isEven ? itemBuilder(context, itemIndex) : separatorBuilder(context, itemIndex);
        },
        childCount: math.max(0, itemCount * 2 - 1),
      ),
    );
  }
}
