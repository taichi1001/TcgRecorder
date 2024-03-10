import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/state/reward_ad_state_provider.dart';
import 'package:tcg_manager/view/premium_plan_purchase_view.dart';

Future showLimitDialog(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const LimitModal();
    },
  );
}

class LimitModal extends HookConsumerWidget {
  const LimitModal({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      surfaceTintColor: Theme.of(context).canvasColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              const Text(
                '🥺',
                style: TextStyle(fontSize: 48),
              ),
              const SizedBox(height: 16),
              Text(
                '回数制限に到達',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  '動画広告を視聴することで、シミュレーションの回数が30回増加します。\nまた、「広告を削除する」からプレミアムプラン購入すると、広告が表示されなくなり、シミュレーション回数が無制限になります。',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      foregroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
                      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                    onPressed: () async {
                      if (context.mounted) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => const PremiumPlanPurchaseView(),
                          ),
                        );
                      }
                      if (context.mounted) Navigator.of(context).pop();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.block),
                        const SizedBox(width: 8),
                        Text(
                          '広告を削除',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () async {
                      await ref.read(rewardAdStateNotifierProvider.notifier).showLimitRewardAd();
                      if (context.mounted) Navigator.of(context).pop();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.play_circle_outlined),
                        const SizedBox(width: 8),
                        Text(
                          '広告を見る',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close)),
        ],
      ),
    );
  }
}
