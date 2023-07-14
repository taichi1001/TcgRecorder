import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';
import 'package:tcg_manager/generated/l10n.dart';

class MatchSelectionRow extends StatelessWidget {
  final bool isBO3;
  final FirstSecond? matchFirstSecond;
  final WinLoss? matchWinLoss;
  final FirstSecond? firstSecond;
  final WinLoss? winLoss;
  final bool isDraw;
  final int matchNumber;
  final void Function(FirstSecond?) onFirstSecondChanged;
  final void Function(WinLoss?) onWinLossChanged;

  const MatchSelectionRow({
    Key? key,
    required this.isBO3,
    required this.matchFirstSecond,
    required this.matchWinLoss,
    required this.firstSecond,
    required this.winLoss,
    required this.isDraw,
    required this.matchNumber,
    required this.onFirstSecondChanged,
    required this.onWinLossChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSizedBox(
          context,
          items: [
            _buildRadioTile<FirstSecond>(
              title: S.of(context).first,
              value: FirstSecond.first,
              groupValue: isBO3 ? matchFirstSecond : firstSecond,
              onChanged: onFirstSecondChanged,
            ),
            _buildRadioTile<FirstSecond>(
              title: S.of(context).second,
              value: FirstSecond.second,
              groupValue: isBO3 ? matchFirstSecond : firstSecond,
              onChanged: onFirstSecondChanged,
            ),
          ],
        ),
        _buildSizedBox(
          context,
          items: [
            _buildRadioTile<WinLoss>(
              title: S.of(context).win,
              value: WinLoss.win,
              groupValue: isBO3 ? matchWinLoss : winLoss,
              onChanged: onWinLossChanged,
            ),
            _buildRadioTile<WinLoss>(
              title: S.of(context).loss,
              value: WinLoss.loss,
              groupValue: isBO3 ? matchWinLoss : winLoss,
              onChanged: onWinLossChanged,
            ),
            if (isDraw)
              _buildRadioTile<WinLoss>(
                title: S.of(context).draw,
                value: WinLoss.draw,
                groupValue: isBO3 ? matchWinLoss : winLoss,
                onChanged: onWinLossChanged,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildSizedBox(BuildContext context, {required List<Widget> items}) {
    return SizedBox(
      width: 204.w,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: items,
          ),
        ),
      ),
    );
  }

  Widget _buildRadioTile<T>({
    required String title,
    required T value,
    required T? groupValue,
    required Function(T?) onChanged,
  }) {
    return RadioListTile(
      title: Text(title),
      toggleable: true,
      value: value,
      groupValue: groupValue,
      onChanged: (val) => onChanged(val),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      dense: true,
    );
  }
}
