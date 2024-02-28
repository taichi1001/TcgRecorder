import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/helper/premium_plan_dialog.dart';
import 'package:tcg_manager/provider/record_edit_view_settings_provider.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';

class EditSettingModalBottomSheet extends HookConsumerWidget {
  const EditSettingModalBottomSheet({
    required this.record,
    key,
  }) : super(key: key);
  final MargedRecord record;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draw = ref.watch(recordEditViewSettingsNotifierProvider(record).select((value) => value.draw));
    final bo3 = ref.watch(recordEditViewSettingsNotifierProvider(record).select((value) => value.bo3));
    final inputiViewSettingsController = ref.watch(recordEditViewSettingsNotifierProvider(record).notifier);
    final isPremium = ref.watch(revenueCatProvider.select((value) => value?.isPremium));

    return Material(
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                child: Text(
                  '入力項目オプション',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SwitchListTile.adaptive(
                contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                title: Text(
                  '引き分け',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: draw,
                onChanged: (value) async {
                  if (isPremium!) {
                    inputiViewSettingsController.changeDraw(value);
                  } else {
                    await premiumPlanDialog(context);
                  }
                },
              ),
              SwitchListTile.adaptive(
                contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                title: Text(
                  'BO3',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: bo3,
                onChanged: (value) async {
                  if (isPremium!) {
                    inputiViewSettingsController.changeBO3(value);
                  } else {
                    await premiumPlanDialog(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
