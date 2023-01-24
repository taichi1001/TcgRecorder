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
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _ContentsCard(
                      title: '特典1: 複数タグ記録機能',
                      description: '様々なタグを組み合わせて記録できます',
                      image: Image.asset(
                        'assets/images/multiple_tag.png',
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    _ContentsCard(
                      title: '特典2: 画像を記録',
                      description: '画像も一緒に記録できるようになります',
                      image: Image.asset(
                        'assets/images/multiple_tag.png',
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    _ContentsCard(
                      title: '特典3: 広告表示なし',
                      description: 'アプリ内の広告が全て非表示になります',
                      image: Image.asset(
                        'assets/images/multiple_tag.png',
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    _ContentsCard(
                      title: '特典4: BO3・引き分けを記録',
                      description: 'これまでは記録が難しかった試合も記録できます',
                      image: Image.asset(
                        'assets/images/multiple_tag.png',
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    _ContentsCard(
                      title: '特典5: CSV出力',
                      description: 'アイデア次第で自由に分析できます',
                      image: Image.asset(
                        'assets/images/multiple_tag.png',
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    const Divider(height: 48),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => revenuecatController.purchasePremiumMonthly(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              '購入',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text('${revenuecat.offerings?.current?.monthly?.storeProduct.priceString}/月'),
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
                      '●プランの更新について\n利用を終了する場合は、購読期間終了の24時間前までに解約してください。',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
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
    required this.image,
    Key? key,
  }) : super(key: key);

  final String title;
  final String description;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Theme.of(context).hoverColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            image,
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
