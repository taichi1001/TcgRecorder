import 'dart:math' as math;

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/firestore_share.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/share_user.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/main.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/provider/firestore_controller_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';
import 'package:tcg_manager/provider/user_info_settings_provider.dart';
import 'package:tcg_manager/repository/firestore_invite_code_repository.dart';
import 'package:tcg_manager/repository/firestore_share_repository.dart';
import 'package:tcg_manager/repository/game_repository.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
import 'package:tcg_manager/view/component/list_tile_ontap.dart';
import 'package:tcg_manager/view/component/loading_overlay.dart';
import 'package:tcg_manager/view/component/sliver_header.dart';
import 'package:tcg_manager/view/premium_plan_purchase_view.dart';
import 'package:tcg_manager/view/select_domain_data_bottom_sheet/domain_data_options.dart';
import 'package:tcg_manager/view/select_domain_data_bottom_sheet/select_domain_data_view.dart';
import 'package:tcg_manager/view/share_view/guest_share_game_view.dart';
import 'package:tcg_manager/view/share_view/share_user_management_view.dart';
import 'package:tcg_manager/view/user_info_settings_view.dart';

class ShareView extends HookConsumerWidget {
  const ShareView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoSettingsProvider);
    final isPremium = ref.watch(revenueCatProvider.select((value) => value?.isPremium));
    return Scaffold(
      appBar: AppBar(
        title: const Text('ゲーム共有'),
        actions: [
          MenuAnchor(
            menuChildren: [
              MenuItemButton(
                child: const Row(
                  children: [
                    Icon(Icons.share),
                    SizedBox(width: 8),
                    Text('ゲームを共有する'),
                  ],
                ),
                onPressed: () async {
                  final shareCount = ref.read(combinedShareCountProvider);
                  final isPremium = ref.read(revenueCatProvider)?.isPremium;
                  if (shareCount[0] > 0 && !isPremium!) {
                    final result = await showOkCancelAlertDialog(
                      context: context,
                      title: '共有個数制限に達しました。',
                      message: 'ホストできる共有ゲーム数は最大1つです。プレミアムプランに加入することでこの制限を解除することができます。',
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
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SelectDomainDataView(
                            dataType: DomainDataType.game,
                            selectDomainDataFunc: (data, count) async {
                              data as Game;
                              if (data.isShare) return;
                              final uid = ref.read(firebaseAuthNotifierProvider).user?.uid;
                              ref.read(loadingProvider.notifier).state = true;
                              if (uid != null && context.mounted) {
                                final gameData = data.copyWith(isShare: true);
                                await ref.read(gameRepository).update(gameData);
                                ref.invalidate(allGameListProvider);
                                await ref.read(firestoreControllerProvider).initShareGame(gameData, uid);
                                ref.read(loadingProvider.notifier).state = false;
                              }
                            },
                            tagCount: 0,
                            enableVisiblity: true,
                            isShowMenu: false,
                            isShowGuestData: false,
                          );
                        },
                      ),
                    );
                    ref.invalidate(hostShareCountProvider);
                  }
                },
              ),
              MenuItemButton(
                child: const Row(
                  children: [
                    Icon(Icons.link),
                    SizedBox(width: 8),
                    Text('招待コード入力'),
                  ],
                ),
                onPressed: () async {
                  final shareCount = ref.read(combinedShareCountProvider);
                  final isPremium = ref.read(revenueCatProvider)?.isPremium;

                  if (shareCount[1] > 1 && !isPremium!) {
                    final result = await showOkCancelAlertDialog(
                      context: context,
                      title: '共有個数制限に達しました。',
                      message: '参加できる共有ゲーム数は最大2つです。プレミアムプランに加入することでこの制限を解除することができます。',
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
                      title: '招待コード入力',
                      message: '招待コードを入力してください。',
                      textFields: [const DialogTextField()],
                    );
                    if (inputText != null) {
                      final shareDocName = await ref.read(firestoreInviteCodeRepository).validateInviteCode(inputText.first);
                      if (shareDocName == null && context.mounted) {
                        await showOkAlertDialog(
                          context: context,
                          title: '無効な招待コード',
                          message: '無効な招待コードです。正しい招待コードを入力してください。',
                        );
                      } else {
                        final uid = ref.read(firebaseAuthNotifierProvider).user?.uid;
                        if (uid != null) {
                          try {
                            await ref.read(firestoreShareRepository).requestDataShare(shareDocName!, ShareUser(id: uid));
                          } catch (e) {
                            if (context.mounted) {
                              await showOkAlertDialog(
                                context: context,
                                title: '共有済み',
                                message: '既に共有中です。',
                              );
                            }
                          }
                        }
                      }
                    }
                  }
                },
              ),
            ],
            builder: (context, controller, child) {
              return IconButton(
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                icon: const Icon(Icons.add),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: const AdaptiveBannerAd(),
      body: userInfo.name == null
          ? Column(
              children: [
                Column(
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
              ],
            )
          : CustomScrollView(
              slivers: [
                if (!isPremium!) const SliverToBoxAdapter(child: LimitedAccessBanner()),
                const SliverHeader(title: 'ホスト'),
                const _HostShareGameListView(),
                const SliverHeader(title: 'ゲスト'),
                const _GuestShareGameListView(),
                const SliverHeader(title: '申請中'),
                const _GuestPendingShareGameListView(),
              ],
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
            isHost: true,
            onTap: () {
              ref.read(currentDomainDataIsShareHostProvider.notifier).state = true;
              ref.read(currentDomainDataProvider.notifier).state = data[index].game;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShareUserManagementView(),
                ),
              );
            },
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
            onTap: () {
              ref.read(currentDomainDataIsShareHostProvider.notifier).state = false;
              ref.read(currentDomainDataProvider.notifier).state = data[index].game;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShareUserManagementView(),
                ),
              );
            },
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
    this.isHost = false,
  });
  final Function()? onTap;
  final bool isHost;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final share = ref.watch(currentShareProvider);
    return ListTileOnTap(
      title: share.game.name,
      onTap: onTap,
      trailing: share.pendingUserList.isNotEmpty && isHost ? CircleNumberWidget(number: share.pendingUserList.length) : null,
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

class CircleNumberWidget extends StatelessWidget {
  const CircleNumberWidget({
    Key? key,
    required this.number,
    this.size = 24.0, // デフォルトサイズ
    this.backgroundColor, // デフォルト背景色
    this.textStyle, // デフォルトテキスト色
  }) : super(key: key);

  final int number;
  final double size;
  final Color? backgroundColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _backgroundColor = backgroundColor ?? Theme.of(context).colorScheme.primary;
    // ignore: no_leading_underscores_for_local_identifiers
    final _textStyle = textStyle ?? Theme.of(context).primaryTextTheme.bodyMedium;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text('$number', style: _textStyle),
      ),
    );
  }
}
