import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';
import 'package:tcg_manager/view/component/web_view_screen.dart';

class PremiumPlanPurchaseView extends HookConsumerWidget {
  const PremiumPlanPurchaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final revenuecat = ref.watch(revenueCatNotifierProvider);
    final revenuecatController = ref.watch(revenueCatNotifierProvider.notifier);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              S.of(context).premiumPlan,
              style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('特典1: 複数タグ記録機能'),
                    ),
                  ),
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('特典2: 画像を記録'),
                    ),
                  ),
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('特典3: 広告表示なし'),
                    ),
                  ),
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('特典4: BO3・引き分けを記録'),
                    ),
                  ),
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('特典5: CSV出力'),
                    ),
                  ),
                  const Divider(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => revenuecatController.purchasePremiumMonthly(),
                    child: Column(
                      children: [
                        const Text('購入'),
                        Text(revenuecat.offerings?.current?.monthly?.storeProduct.priceString ?? ''),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('購読を復元する'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('利用規約'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WebViewScreen(
                                url: 'https://phrygian-jellyfish-595.notion.site/Privacy-Policy-057b29da8fb74d76bccd700d80db53e1',
                              ),
                            ),
                          );
                        },
                        child: const Text('プライバシーポリシー'),
                      ),
                    ],
                  ),
                  Text(
                    '●プランの更新について\n利用を終了する場合は、購読期間終了の24時間前までに解約してください。',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (revenuecat.isLoading)
          const Opacity(
            opacity: 0.7,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.black,
            ),
          ),
        if (revenuecat.isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
