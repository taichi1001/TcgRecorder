import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';
import 'package:tcg_manager/provider/record_detail_provider.dart';
import 'package:tcg_manager/provider/record_edit_view_settings_provider.dart';
import 'package:tcg_manager/view/component/match_selection_row.dart';

class EditViewWinLossFirstSecond extends HookConsumerWidget {
  const EditViewWinLossFirstSecond({
    required this.margedRecord,
    key,
  }) : super(key: key);
  final MargedRecord margedRecord;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordDetailNotifier = ref.watch(recordEditViewNotifierProvider(margedRecord).notifier);
    final recordDetailState = ref.watch(recordEditViewNotifierProvider(margedRecord));
    final firstSecond = recordDetailState.editMargedRecord.firstSecond;
    final firstMatchFirstSecond = recordDetailState.editMargedRecord.firstMatchFirstSecond;
    final secondMatchFirstSecond = recordDetailState.editMargedRecord.secondMatchFirstSecond;
    final thirdMatchFirstSecond = recordDetailState.editMargedRecord.thirdMatchFirstSecond;
    final winLoss = recordDetailState.editMargedRecord.winLoss;
    final firstMatchWinLoss = recordDetailState.editMargedRecord.firstMatchWinLoss;
    final secondMatchWinLoss = recordDetailState.editMargedRecord.secondMatchWinLoss;
    final thirdMatchWinLoss = recordDetailState.editMargedRecord.thirdMatchWinLoss;

    final isDraw = ref.watch(recordEditViewSettingsNotifierProvider(margedRecord).select((value) => value.draw));
    final isBO3 = ref.watch(recordEditViewSettingsNotifierProvider(margedRecord).select((value) => value.bo3));
    return Column(
      children: [
        MatchSelectionRow(
          isBO3: isBO3,
          matchFirstSecond: firstMatchFirstSecond,
          matchWinLoss: firstMatchWinLoss,
          firstSecond: firstSecond,
          winLoss: winLoss,
          isDraw: isDraw,
          matchNumber: 1,
          onFirstSecondChanged: (FirstSecond? value) {
            if (isBO3) {
              recordDetailNotifier.editFirstMatchFirstSecond(value);
            } else {
              recordDetailNotifier.editFirstSecond(value);
            }
          },
          onWinLossChanged: (WinLoss? value) {
            if (isBO3) {
              recordDetailNotifier.editFirstMatchWinLoss(value);
            } else {
              recordDetailNotifier.editWinLoss(value);
            }
          },
        ),
        if (isBO3)
          MatchSelectionRow(
            isBO3: isBO3,
            matchFirstSecond: secondMatchFirstSecond,
            matchWinLoss: secondMatchWinLoss,
            firstSecond: firstSecond,
            winLoss: winLoss,
            isDraw: isDraw,
            matchNumber: 2,
            onFirstSecondChanged: (FirstSecond? value) {
              recordDetailNotifier.editSecondMatchFirstSecond(value);
            },
            onWinLossChanged: (WinLoss? value) {
              recordDetailNotifier.editSecondMatchWinLoss(value);
            },
          ),
        if (isBO3)
          MatchSelectionRow(
            isBO3: isBO3,
            matchFirstSecond: thirdMatchFirstSecond,
            matchWinLoss: thirdMatchWinLoss,
            firstSecond: firstSecond,
            winLoss: winLoss,
            isDraw: isDraw,
            matchNumber: 3,
            onFirstSecondChanged: (FirstSecond? value) {
              recordDetailNotifier.editThirdMatchFirstSecond(value);
            },
            onWinLossChanged: (WinLoss? value) {
              recordDetailNotifier.editThirdMatchWinLoss(value);
            },
          ),
      ],
    );
  }
}
