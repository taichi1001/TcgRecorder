import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/enum/access_roll.dart';
import 'package:tcg_manager/enum/bo.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/backup_provider.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/firestore_backup_controller_provider.dart';
import 'package:tcg_manager/provider/input_view_provider.dart';
import 'package:tcg_manager/provider/input_view_settings_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';
import 'package:tcg_manager/provider/reward_ad_state_provider.dart';
import 'package:tcg_manager/provider/select_game_access_roll.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/provider/user_activity_provider.dart';
import 'package:tcg_manager/view/component/loading_overlay.dart';
import 'package:tcg_manager/view/limit_modal.dart';
import 'package:tcg_manager/view/reveiw_modal.dart';

class SaveButton extends HookConsumerWidget {
  const SaveButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstMatchWinLoss = ref.watch(inputViewNotifierProvider.select((value) => value.firstMatchWinLoss));
    final secondMatchWinLoss = ref.watch(inputViewNotifierProvider.select((value) => value.secondMatchWinLoss));
    final thirdMatchWinLoss = ref.watch(inputViewNotifierProvider.select((value) => value.thirdMatchWinLoss));
    final firstMatchFirstSecond = ref.watch(inputViewNotifierProvider.select((value) => value.firstMatchFirstSecond));
    final secondMatchFirstSecond = ref.watch(inputViewNotifierProvider.select((value) => value.secondMatchFirstSecond));
    final thirdMatchFirstSecond = ref.watch(inputViewNotifierProvider.select((value) => value.thirdMatchFirstSecond));
    final useDeck = ref.watch(inputViewNotifierProvider.select((value) => value.useDeck));
    final opponentDeck = ref.watch(inputViewNotifierProvider.select((value) => value.opponentDeck));
    final isBO3 = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.bo3));

    final inputViewNotifier = ref.read(inputViewNotifierProvider.notifier);

    final isDisabled = useDeck == null ||
        opponentDeck == null ||
        (isBO3 && (firstMatchFirstSecond == null || firstMatchWinLoss == null)) ||
        (isBO3 && secondMatchFirstSecond != null && secondMatchWinLoss == null) ||
        (isBO3 && secondMatchFirstSecond == null && secondMatchWinLoss != null) ||
        (isBO3 && thirdMatchFirstSecond != null && thirdMatchWinLoss == null) ||
        (isBO3 && thirdMatchFirstSecond == null && thirdMatchWinLoss != null);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton(
              onPressed: isDisabled
                  ? null
                  : () async {
                      final accessRoll = await ref.watch(selectGameAccessRoll.future);
                      if (accessRoll == AccessRoll.reader && context.mounted) {
                        await showOkAlertDialog(
                          context: context,
                          title: '権限がありません。',
                          message: 'この操作をする権限がありません。ゲームの管理者にお問い合わせください。',
                        );
                      } else if (context.mounted) {
                        final okCancelResult = await showOkCancelAlertDialog(
                          context: context,
                          message: S.of(context).isSave,
                          isDestructiveAction: true,
                        );

                        if (okCancelResult == OkCancelResult.ok) {
                          // 条件にリワード広告が読み込まれているかどうかを含める
                          if (ref.read(userActivityLogNotifierProvider).canRecord ||
                              ref.read(revenueCatProvider)!.isPremium ||
                              ref.read(rewardAdStateNotifierProvider) == null) {
                            ref.read(loadingProvider.notifier).state = true;
                            if (isBO3) {
                              await inputViewNotifier.saveRecord(BO.bo3);
                            } else {
                              await inputViewNotifier.saveRecord(BO.bo1);
                            }
                            ref.invalidate(allDeckListProvider);
                            ref.invalidate(allTagListProvider);
                            ref.invalidate(allRecordListProvider);
                            ref.read(userActivityLogNotifierProvider.notifier).record();
                            if (ref.read(userActivityLogNotifierProvider.notifier).shouldShowReviewDialog()) {
                              if (context.mounted) await showReviewDialog(context);
                            }
                            if (ref.read(backupNotifierProvider)) {
                              ref.read(firestoreBackupControllerProvider).addRecord(ref.read(inputViewNotifierProvider).record!);
                            }
                            inputViewNotifier.resetView();
                            ref.read(loadingProvider.notifier).state = false;
                          } else {
                            if (context.mounted) await showLimitDialog(context);
                          }
                          if (context.mounted) {
                            FocusScope.of(context).unfocus();
                          }
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(S.of(context).save),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
