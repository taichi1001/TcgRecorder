import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/firestore_share.dart';
import 'package:tcg_manager/main.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/repository/firestore_share_repository.dart';
import 'package:tcg_manager/view/component/list_tile_ontap.dart';
import 'package:tcg_manager/view/premium_plan_purchase_view.dart';

class SelectSharedHostGameScreen extends HookConsumerWidget {
  const SelectSharedHostGameScreen({required this.mainInfo, super.key});
  final MainInfo mainInfo;

  Future _save(List<FirestoreShare> shareList, BuildContext context, WidgetRef ref) async {
    for (final share in shareList) {
      await ref.read(firestoreShareRepository).updateShare(share);
    }
    ref.invalidate(hostShareCountProvider);
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainAppHome(
            mainInfo: mainInfo,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hostShareList = ref.watch(hostShareProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('共有ゲームの個数制限に達しました')),
      body: hostShareList.maybeWhen(
        data: (data) {
          final shareCount = useState(data.where((element) => element.isShared).length);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'サブスク期間終了により共有ゲームの個数が上限に達しました。継続したいゲームを選択し、上限内(1つまで)に調整してください。プレミアムプランに再度入会することで全てのゲームが利用可能になります。',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '継続しないゲームは再度プレミアムプランに入会するまで閲覧不可能になりますのでご注意下さい。',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => const PremiumPlanPurchaseView(),
                          ),
                        );
                      },
                      child: Text(
                        'プレミアムプラン詳細はこちらをタップしてください。',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: data.length + 1,
                  itemBuilder: (context, index) {
                    if (index == data.length) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: ElevatedButton(
                          onPressed: shareCount.value > 1 ? null : () async => await _save(data, context, ref),
                          child: const Text('決定する'),
                        ),
                      );
                    }
                    return ListTileOnTap(
                      title: data[index].game.name,
                      textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                data[index].isShared ? Theme.of(context).textTheme.displayMedium?.color : Theme.of(context).disabledColor,
                          ),
                      leading: data[index].isShared ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
                      onTap: () {
                        data[index] = data[index].copyWith(isShared: !data[index].isShared);
                        shareCount.value = data.where((element) => element.isShared).length;
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(indent: 16, thickness: 1, height: 0),
                ),
              ),
            ],
          );
        },
        orElse: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class SelectSharedGuestGameScreen extends HookConsumerWidget {
  const SelectSharedGuestGameScreen({required this.mainInfo, super.key});
  final MainInfo mainInfo;

  Future _save(List<FirestoreShare> shareList, BuildContext context, WidgetRef ref) async {
    final myself = ref.read(firebaseAuthNotifierProvider).user;
    for (final share in shareList) {
      if (!share.isShared) {
        final shareUser = share.shareUserList.where((element) => element.id == myself?.uid).first;
        await ref.read(firestoreShareRepository).revokeUser(shareUser, share.docName);
      }
    }
    ref.invalidate(guestShareCountProvider);
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainAppHome(
            mainInfo: mainInfo,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guestShareList = ref.watch(guestShareProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('残すゲームを選択してください')),
      body: guestShareList.maybeWhen(
        data: (data) {
          final shareCount = useState(data.where((element) => element.isShared).length);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'サブスク期間終了により共有ゲームの個数が上限に達しました。継続したいゲームを選択し、上限内(2つまで)に調整してください。',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '継続しないゲームは共有解除されますのでご注意下さい。',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => const PremiumPlanPurchaseView(),
                          ),
                        );
                      },
                      child: Text(
                        'プレミアムプラン詳細はこちらをタップしてください。',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: data.length + 1,
                  itemBuilder: (context, index) {
                    if (index == data.length) {
                      return ElevatedButton(
                        onPressed: shareCount.value > 1 ? null : () async => await _save(data, context, ref),
                        child: const Text('決定する'),
                      );
                    }
                    return ListTileOnTap(
                      title: data[index].game.name,
                      textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                data[index].isShared ? Theme.of(context).textTheme.displayMedium?.color : Theme.of(context).disabledColor,
                          ),
                      leading: data[index].isShared ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
                      onTap: () {
                        data[index] = data[index].copyWith(isShared: !data[index].isShared);
                        shareCount.value = data.where((element) => element.isShared).length;
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(indent: 16, thickness: 1, height: 0),
                ),
              ),
            ],
          );
        },
        orElse: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
