import 'dart:math' as math;
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tcg_manager/entity/firestore_share.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/enum/access_roll.dart';
import 'package:tcg_manager/main.dart';
import 'package:tcg_manager/provider/adaptive_banner_ad_provider.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/provider/firestore_controller_provider.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';
import 'package:tcg_manager/provider/user_info_settings_provider.dart';
import 'package:tcg_manager/repository/dynamic_links_repository.dart';
import 'package:tcg_manager/repository/firestore_share_repository.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
import 'package:tcg_manager/view/component/list_tile_ontap.dart';
import 'package:tcg_manager/view/component/sliver_header.dart';
import 'package:tcg_manager/view/guest_share_game_view.dart';
import 'package:tcg_manager/view/host_share_game_view.dart';
import 'package:tcg_manager/view/premium_plan_purchase_view.dart';
import 'package:tcg_manager/view/user_info_settings_view.dart';

class ShareView extends HookConsumerWidget {
  const ShareView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoSettingsProvider);
    final adHeight = ref.watch(adaptiveBannerAdNotifierProvider).adSize?.height;
    final isPremium = ref.watch(revenueCatProvider.select((value) => value?.isPremium));
    return Scaffold(
      appBar: AppBar(title: const Text('ゲーム共有')),
      body: userInfo.name == null
          ? Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Center(
                        child: Text('ゲーム共有を利用するためにはプロフィールの設定が必要です。'),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserInfoSettingsView(),
                          ),
                        ),
                        child: const Text('プロフィールを設定する'),
                      ),
                    ],
                  ),
                ),
                const AdaptiveBannerAd(),
              ],
            )
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomScrollView(
                  slivers: [
                    if (!isPremium!) const SliverToBoxAdapter(child: LimitedAccessBanner()),
                    const SliverHeader(title: 'ホスト'),
                    const _HostShareGameListView(),
                    const SliverHeader(title: 'ゲスト'),
                    const _GuestShareGameListView(),
                    const SliverHeader(title: '申請中'),
                    const _GuestPendingShareGameListView(),
                    SliverToBoxAdapter(child: Container(height: adHeight?.toDouble())),
                  ],
                ),
                const AdaptiveBannerAd(),
              ],
            ),
      floatingActionButton: userInfo.name == null
          ? null
          : Padding(
              padding: EdgeInsets.only(bottom: adHeight!.toDouble()),
              child: const _AddShareGameButton(),
            ),
    );
  }
}

class LimitedAccessBanner extends StatelessWidget {
  const LimitedAccessBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodySmall;
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => const PremiumPlanPurchaseView(),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('プレミアムプランに未加入の方には以下の制限があります。', style: textStyle),
              Text('プレミアムプランにアップグレードすることで制限が解除されます。', style: textStyle),
              const SizedBox(height: 4),
              Text('・作成できるゲーム: 1つまで', style: textStyle),
              Text('・参加できるゲーム: 2つまで', style: textStyle),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddShareGameButton extends HookConsumerWidget {
  const _AddShareGameButton();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () async {
        final shareCount = ref.read(combinedShareCountProvider);
        final isPremium = ref.read(revenueCatProvider)?.isPremium;

        if (shareCount[0] > 0 && !isPremium!) {
          final result = await showOkCancelAlertDialog(
            context: context,
            title: '共有個数制限に達しました。',
            message: '作成できる共有ゲーム数は最大1つまでです。プレミアムプランに加入することでこの制限を解除することができます。',
            okLabel: 'OK',
            cancelLabel: 'プレミアムプラン詳細',
            isDestructiveAction: true,
          );
          if (result == OkCancelResult.cancel && context.mounted) {
            await Navigator.push(
              context,
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => const PremiumPlanPurchaseView(),
              ),
            );
          }
        } else {
          final inputText = await showTextInputDialog(
            context: context,
            title: '共有ゲーム作成',
            message: '共有用ゲーム名を入力してください。このゲームは個人保存ゲームとは別扱いとなります。',
            textFields: [const DialogTextField()],
          );
          if (inputText != null && inputText.first != '') {
            final uid = ref.read(firebaseAuthNotifierProvider).user?.uid;
            if (uid != null) {
              ref.read(firestoreControllerProvider).initShareGame(Game(name: inputText.first, isShare: true), uid);
              final link = await ref.read(dynamicLinksRepository).createInviteDynamicLink(uid, inputText.first, AccessRoll.writer);
              await Share.share(link.toString(), subject: '「${inputText.first}」共有用のリンク');
            }
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
    final hostGameList = ref.watch(hostShareProvider);
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
    final guestGameList = ref.watch(guestShareProvider);
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
    final guestGameList = ref.watch(guestPendingShareProvider);
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
