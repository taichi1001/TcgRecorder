import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tcg_manager/view/premium_plan_purchase_view.dart';

Future premiumPlanDialog(BuildContext context) async {
  final result = await showOkCancelAlertDialog(
    context: context,
    title: 'プレミアムプランの機能です',
    message: 'プレミアムプランを契約すると、この機能以外にも様々な機能が利用できるようになります。',
    okLabel: '詳細を見る',
  );
  if (result == OkCancelResult.ok) {
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => const PremiumPlanPurchaseView(),
        ),
      );
    }
  }
}
