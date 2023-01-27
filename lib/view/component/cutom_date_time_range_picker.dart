import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:tcg_manager/view/component/custom_modal_picker.dart';

class CustomModalDateTimeRangePicker extends HookConsumerWidget {
  const CustomModalDateTimeRangePicker({
    required this.controller,
    this.submitedAction,
    Key? key,
  }) : super(key: key);

  final CustomModalDateTimeRangePickerController controller;
  final void Function()? submitedAction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDateRange = useState(controller.selectedDateRange);
    final dateRange = selectedDateRange.value;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ModalButton(submitedAction: submitedAction),
        _RangeSlider(controller: controller),
        CustomModalPicker(
          height: MediaQuery.of(context).size.height / 3,
          shoModalButton: false,
          child: SfDateRangePicker(
            selectionMode: DateRangePickerSelectionMode.range,
            view: DateRangePickerView.month,
            showNavigationArrow: true,
            minDate: DateTime(2000, 01, 01),
            maxDate: DateTime.now(),
            initialSelectedRange: dateRange,
            toggleDaySelection: true,
            onSelectionChanged: (args) {
              if (args.value is PickerDateRange) {
                controller.setDateRange(args.value);
                selectedDateRange.value = controller.selectedDateRange;
              }
            },
          ),
        ),
      ],
    );
  }
}

class CustomModalDateTimeRangePickerController {
  CustomModalDateTimeRangePickerController({
    required this.initialDateRange,
    required this.initialTimeRange,
  }) {
    _selectedDateRange = initialDateRange;
    _selectedTimeRange = initialTimeRange;
  }

  final PickerDateRange initialDateRange;
  final SfRangeValues initialTimeRange;
  late PickerDateRange _selectedDateRange;
  late SfRangeValues _selectedTimeRange;

  PickerDateRange get selectedDateRange => _selectedDateRange;
  SfRangeValues get selectedTimeRange => _selectedTimeRange;

  void setDateRange(PickerDateRange range) {
    _selectedDateRange = range;
  }

  void setTimeRange(SfRangeValues range) {
    _selectedTimeRange = range;
  }
}

class _RangeSlider extends StatefulWidget {
  const _RangeSlider({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final CustomModalDateTimeRangePickerController controller;

  @override
  State<_RangeSlider> createState() => __RangeSliderState();
}

class __RangeSliderState extends State<_RangeSlider> {
  late SfRangeValues _rangeValue;
  void _changeSlider(SfRangeValues value) {
    setState(() {
      _rangeValue = value;
      widget.controller.setTimeRange(_rangeValue);
    });
  }

  @override
  void initState() {
    super.initState();
    _rangeValue = widget.controller.selectedTimeRange;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: SfRangeSliderTheme(
        data: SfRangeSelectorThemeData(
          activeLabelStyle: Theme.of(context).textTheme.bodySmall,
          inactiveLabelStyle: Theme.of(context).textTheme.bodySmall,
          tooltipTextStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSecondary),
          tooltipBackgroundColor: Theme.of(context).colorScheme.secondary,
          activeTrackHeight: 4,
          inactiveTrackHeight: 4,
        ),
        child: SfRangeSlider(
          min: DateTime(1994, 10, 1, 0, 0),
          max: DateTime(1994, 10, 1, 24, 00),
          interval: 4,
          stepDuration: const SliderStepDuration(hours: 1),
          dateFormat: DateFormat('HH'),
          minorTicksPerInterval: 3,
          showTicks: true,
          showLabels: true,
          enableTooltip: true,
          dateIntervalType: DateIntervalType.hours,
          tooltipTextFormatterCallback: (dynamic actualValue, _) => DateFormat('HH:mm').format(actualValue),
          values: _rangeValue,
          onChanged: _changeSlider,
        ),
      ),
    );
  }
}
