import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tcg_manager/view/component/custom_modal_picker.dart';

class CustomModalDateTimePicker extends HookConsumerWidget {
  const CustomModalDateTimePicker({
    required this.controller,
    this.submitedAction,
    this.nowAction,
    Key? key,
  }) : super(key: key);

  final CustomModalDateTimePickerController controller;
  final void Function()? submitedAction;
  final void Function()? nowAction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDateTime = useState(controller.selectedDateTime);
    final dateTime = selectedDateTime.value;
    final isShowDate = useState(true);
    final dateFormat = DateFormat('yyyy/MM/dd');
    final timeFormat = DateFormat('HH:mm');
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ModalButton(
          submitedAction: submitedAction,
          actionButton: CupertinoButton(
            onPressed: nowAction,
            child: const Text('現在時刻'),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 16),
          color: Theme.of(context).canvasColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '日時',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      isShowDate.value = true;
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).hoverColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        dateFormat.format(dateTime),
                        style: isShowDate.value
                            ? Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).primaryColor)
                            : Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      isShowDate.value = false;
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).hoverColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        timeFormat.format(dateTime),
                        style: !isShowDate.value
                            ? Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).primaryColor)
                            : Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        CustomModalPicker(
          height: MediaQuery.of(context).size.height / 3,
          shoModalButton: false,
          child: isShowDate.value
              ? SfDateRangePicker(
                  selectionMode: DateRangePickerSelectionMode.single,
                  view: DateRangePickerView.month,
                  showNavigationArrow: true,
                  minDate: DateTime(2000, 01, 01),
                  maxDate: DateTime.now(),
                  initialSelectedDate: dateTime,
                  toggleDaySelection: true,
                  onSelectionChanged: (args) {
                    if (args.value is DateTime) {
                      controller.setDate(args.value);
                      selectedDateTime.value = controller.selectedDateTime;
                    }
                  },
                )
              : CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: true,
                  onDateTimeChanged: (time) {
                    controller.setTime(time);
                    selectedDateTime.value = controller.selectedDateTime;
                  },
                ),
        ),
      ],
    );
  }
}

class CustomModalDateTimePickerController {
  CustomModalDateTimePickerController({
    required this.initialDateTime,
  }) {
    _selectedDateTime = initialDateTime;
  }

  final DateTime initialDateTime;
  late DateTime _selectedDateTime;

  DateTime get selectedDateTime => _selectedDateTime;

  void setDateTimeNow() {
    _selectedDateTime = DateTime.now();
  }

  void setDate(DateTime date) {
    _selectedDateTime = DateTime(date.year, date.month, date.day, _selectedDateTime.hour, _selectedDateTime.minute);
  }

  void setTime(DateTime time) {
    _selectedDateTime = DateTime(_selectedDateTime.year, _selectedDateTime.month, selectedDateTime.day, time.hour, time.minute);
  }
}
