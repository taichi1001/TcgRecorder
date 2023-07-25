import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/helper/premium_plan_dialog.dart';
import 'package:tcg_manager/provider/input_view_settings_provider.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';

class SettingModalBottomSheet extends HookConsumerWidget {
  const SettingModalBottomSheet({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fixUseDeck = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.fixUseDeck));
    final fixOpponentDeck = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.fixOpponentDeck));
    final fixTag = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.fixTag));
    final draw = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.draw));
    final bo3 = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.bo3));
    final inputiViewSettingsController = ref.watch(inputViewSettingsNotifierProvider.notifier);
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
                  '入力固定オプション',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SwitchListTile.adaptive(
                contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                title: Text(
                  '使用デッキ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: fixUseDeck,
                onChanged: inputiViewSettingsController.changeFixUseDeck,
              ),
              SwitchListTile.adaptive(
                contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                title: Text(
                  '対戦相手デッキ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: fixOpponentDeck,
                onChanged: inputiViewSettingsController.changeFixOpponentDeck,
              ),
              SwitchListTile.adaptive(
                contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                title: Text(
                  'タグ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: fixTag,
                onChanged: inputiViewSettingsController.changeFixTag,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                child: Text(
                  '入力項目オプション',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                leading: isPremium!
                    ? null
                    : const Icon(
                        Icons.lock,
                        size: 16,
                      ),
                title: Text(
                  '引き分け',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing: Switch.adaptive(
                  value: draw,
                  onChanged: (value) async {
                    if (isPremium) {
                      inputiViewSettingsController.changeDraw(value);
                    } else {
                      await premiumPlanDialog(context);
                    }
                  },
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                leading: isPremium
                    ? null
                    : const Icon(
                        Icons.lock,
                        size: 16,
                      ),
                title: Text(
                  'BO3',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing: Switch.adaptive(
                  value: bo3,
                  onChanged: (value) async {
                    if (isPremium) {
                      inputiViewSettingsController.changeBO3(value);
                    } else {
                      await premiumPlanDialog(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
