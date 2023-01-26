import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';
import 'package:tcg_manager/view/component/web_view_screen.dart';

enum Plan {
  yearly,
  monthly,
}

class PremiumPlanPurchaseView extends HookConsumerWidget {
  const PremiumPlanPurchaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final revenuecat = ref.watch(revenueCatNotifierProvider);
    final revenuecatController = ref.watch(revenueCatNotifierProvider.notifier);

    final monthlyPriceString = revenuecat.offerings?.current?.monthly?.storeProduct.priceString;
    final yearPlanPrice = revenuecat.offerings?.current?.annual?.storeProduct.priceString;
    final selectPlan = useState(Plan.yearly);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              S.of(context).premiumPlan,
              style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'より詳細に記録・分析して試合に勝ちましょう',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const _ContentsCard(
                        title: '複数タグを記録',
                        description: '様々なタグを組み合わせて記録できます',
                        icon: Icons.tag,
                      ),
                      const _ContentsCard(
                        title: '画像を記録',
                        description: '画像も一緒に記録できるようになります',
                        icon: Icons.image,
                      ),
                      const _ContentsCard(
                        title: '広告表示なし',
                        description: 'アプリ内の広告が全て非表示になります',
                        icon: Icons.block,
                      ),
                      const _ContentsCard(
                        title: 'BO3・引き分けを記録',
                        description: 'これまでは記録が難しかった試合も記録できます',
                        icon: Icons.edit_note,
                      ),
                      const _ContentsCard(
                        title: 'CSV出力',
                        description: 'アイデア次第で自由に分析できます',
                        icon: Icons.note,
                      ),
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => selectPlan.value = Plan.yearly,
                            child: _YearlyPlanContainer(
                              yearPlanPrice: '$yearPlanPrice/年',
                              isSelect: selectPlan.value == Plan.yearly,
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () => selectPlan.value = Plan.monthly,
                            child: _BillingPlanContainer(
                              planPrice: '$monthlyPriceString/月',
                              planName: '月額プラン',
                              isSelect: selectPlan.value == Plan.monthly,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => selectPlan.value == Plan.yearly
                            ? revenuecatController.purchasePremiumYearly()
                            : revenuecatController.purchasePremiumMonthly(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                '無料でおためし',
                                style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(selectPlan.value == Plan.yearly ? '無料期間終了後から$yearPlanPrice/年' : '無料期間終了後から$monthlyPriceString/月'),
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          revenuecatController.restorePremium();
                        },
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
                        '●無料おためしについて\n無料お試しは初めてプレミアムプランに登録する方が対象です。\nお試し期間が終了する24時間前までにキャンセルしない場合、自動的に継続購入となり料金が請求されます。',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '●プランの更新について\n利用を終了する場合は、購読期間終了の24時間前までに解約してください。',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
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

class _ContentsCard extends StatelessWidget {
  const _ContentsCard({
    required this.title,
    required this.description,
    required this.icon,
    Key? key,
  }) : super(key: key);

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Theme.of(context).hoverColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 32),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _YearlyPlanContainer extends StatelessWidget {
  const _YearlyPlanContainer({
    required this.yearPlanPrice,
    this.isSelect = false,
  });

  final String yearPlanPrice;
  final bool isSelect;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        _BillingPlanContainer(
          planPrice: yearPlanPrice,
          planName: '年額プラン',
          isSelect: isSelect,
        ),
        Container(
          height: 20,
          width: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).primaryColor,
          ),
          child: Center(
            child: Text(
              '2ヶ月お得',
              style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BillingPlanContainer extends StatelessWidget {
  const _BillingPlanContainer({
    required this.planPrice,
    required this.planName,
    this.isSelect = false,
  });

  final String planPrice;
  final String planName;
  final bool isSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 2.5,
          color: isSelect ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              planName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              planPrice,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
