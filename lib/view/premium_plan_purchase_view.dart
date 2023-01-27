import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';
import 'package:tcg_manager/view/component/web_view_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            title: Text(S.of(context).premiumPlan),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          S.of(context).premiumPlanCatchCopy,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 32),
                      _ContentsCard(
                        title: S.of(context).premiumPlanTagTitle,
                        description: S.of(context).premiumPlanTagDescription,
                        icon: FontAwesomeIcons.tags,
                        iconColor: Colors.purple,
                      ),
                      _ContentsCard(
                        title: S.of(context).premiumPlanDrawTitle,
                        description: S.of(context).premiumPlanDrawDescription,
                        icon: Icons.edit_note,
                        iconColor: Colors.orange,
                      ),
                      _ContentsCard(
                        title: S.of(context).premiumPlanImageTitle,
                        description: S.of(context).premiumPlanImageDescription,
                        icon: Icons.image,
                        iconColor: Colors.green,
                      ),
                      _ContentsCard(
                        title: S.of(context).premiumPlanExportTitle,
                        description: S.of(context).premiumPlanExportDescription,
                        icon: FontAwesomeIcons.fileCsv,
                        iconColor: Colors.lightBlue,
                      ),
                      _ContentsCard(
                        title: S.of(context).premiumPlanADBlockTitle,
                        description: S.of(context).premiumPlanADBlockDescription,
                        icon: Icons.block,
                        iconColor: Colors.red,
                      ),
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => selectPlan.value = Plan.yearly,
                            child: _YearlyPlanContainer(
                              yearPlanPrice: '$yearPlanPrice/${S.of(context).year}',
                              isSelect: selectPlan.value == Plan.yearly,
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () => selectPlan.value = Plan.monthly,
                            child: _BillingPlanContainer(
                              planPrice: '$monthlyPriceString/${S.of(context).month}',
                              planName: S.of(context).monthPlan,
                              isSelect: selectPlan.value == Plan.monthly,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 240,
                        child: ElevatedButton(
                          onPressed: () => selectPlan.value == Plan.yearly
                              ? revenuecatController.purchasePremiumYearly()
                              : revenuecatController.purchasePremiumMonthly(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  S.of(context).freePlanButton,
                                  style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.onPrimary,
                                      ),
                                ),
                                Text(
                                  selectPlan.value == Plan.yearly
                                      ? '${S.of(context).afterFree}$yearPlanPrice/${S.of(context).year}'
                                      : '${S.of(context).afterFree}$monthlyPriceString/${S.of(context).month}',
                                  style: Theme.of(context).primaryTextTheme.labelSmall?.copyWith(
                                        color: Theme.of(context).colorScheme.onPrimary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          revenuecatController.restorePremium();
                        },
                        child: Text(S.of(context).restoreButton),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WebViewScreen(
                                    url: 'https://phrygian-jellyfish-595.notion.site/067af33073004575b08a958497083e30',
                                  ),
                                ),
                              );
                            },
                            child: Text(S.of(context).termsOfUse),
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
                            child: Text(S.of(context).privacyPolicy),
                          ),
                        ],
                      ),
                      Text(
                        S.of(context).freePlanDescription,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        S.of(context).planUpdateDescription,
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
    this.iconColor,
    Key? key,
  }) : super(key: key);

  final String title;
  final String description;
  final IconData icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: Theme.of(context).hoverColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 32,
              color: iconColor,
            ),
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
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
          planName: S.of(context).yearPlan,
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
              S.of(context).value2Mont,
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
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isSelect ? Theme.of(context).textTheme.titleMedium?.color : Theme.of(context).disabledColor,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              planPrice,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isSelect ? Theme.of(context).textTheme.titleMedium?.color : Theme.of(context).disabledColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
