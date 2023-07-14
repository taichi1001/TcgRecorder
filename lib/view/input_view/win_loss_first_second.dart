import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';
import 'package:tcg_manager/provider/input_view_provider.dart';
import 'package:tcg_manager/provider/input_view_settings_provider.dart';
import 'package:tcg_manager/view/component/match_selection_row.dart';

class WinLossFirstSecond extends HookConsumerWidget {
  const WinLossFirstSecond({key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBO3 = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.bo3));
    final firstMatchWinLoss = ref.watch(inputViewNotifierProvider.select((value) => value.firstMatchWinLoss));
    final firstSecond = ref.watch(inputViewNotifierProvider.select((value) => value.firstSecond));
    final firstMatchFirstSecond = ref.watch(inputViewNotifierProvider.select((value) => value.firstMatchFirstSecond));
    final secondMatchFirstSecond = ref.watch(inputViewNotifierProvider.select((value) => value.secondMatchFirstSecond));
    final secondMatchWinLoss = ref.watch(inputViewNotifierProvider.select((value) => value.secondMatchWinLoss));
    final thirdMatchFirstSecond = ref.watch(inputViewNotifierProvider.select((value) => value.thirdMatchFirstSecond));
    final thirdMatchWinLoss = ref.watch(inputViewNotifierProvider.select((value) => value.thirdMatchWinLoss));
    final inputViewNotifier = ref.read(inputViewNotifierProvider.notifier);
    final winLoss = ref.watch(inputViewNotifierProvider.select((value) => value.winLoss));
    final isDraw = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.draw));
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
              inputViewNotifier.selectMatchFirstSecond(value, 1);
            } else {
              inputViewNotifier.selectFirstSecond(value);
            }
          },
          onWinLossChanged: (WinLoss? value) {
            if (isBO3) {
              inputViewNotifier.selectMatchWinLoss(value, 1);
            } else {
              inputViewNotifier.selectWinLoss(value);
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
              inputViewNotifier.selectMatchFirstSecond(value, 2);
            },
            onWinLossChanged: (WinLoss? value) {
              inputViewNotifier.selectMatchWinLoss(value, 2);
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
              inputViewNotifier.selectMatchFirstSecond(value, 3);
            },
            onWinLossChanged: (WinLoss? value) {
              inputViewNotifier.selectMatchWinLoss(value, 3);
            },
          ),
      ],
    );
  }
}
