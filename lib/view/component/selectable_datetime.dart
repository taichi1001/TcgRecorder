import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/view/component/cutom_date_time_picker.dart';

class SelectableDateTime extends StatelessWidget {
  const SelectableDateTime({
    required this.controller,
    required this.submiteAction,
    required this.nowAction,
    required this.datetime,
    super.key,
  });
  final CustomModalDateTimePickerController controller;
  final Function() submiteAction;
  final Function() nowAction;
  final DateTime datetime;
  @override
  Widget build(BuildContext context) {
    final outputFormat = DateFormat(S.of(context).dateFormatIncludeTime);
    return GestureDetector(
      onTap: () async {
        showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) {
            return CustomModalDateTimePicker(
              controller: controller,
              submitedAction: () {
                submiteAction();
                Navigator.pop(context);
              },
              nowAction: () {
                nowAction();
                Navigator.pop(context);
              },
            );
          },
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                outputFormat.format(datetime),
              ),
              const Icon(
                Icons.calendar_today_rounded,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
