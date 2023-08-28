import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/provider/input_view_provider.dart';
import 'package:tcg_manager/view/component/cutom_date_time_picker.dart';
import 'package:tcg_manager/view/input_view/selectable_datetime.dart';

class InputViewSelectableDateTime extends HookConsumerWidget {
  const InputViewSelectableDateTime({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateTimeController = useState(CustomModalDateTimePickerController(initialDateTime: DateTime.now()));
    final date = ref.watch(inputViewNotifierProvider.select((value) => value.date));
    final inputViewNotifier = ref.read(inputViewNotifierProvider.notifier);

    return SelectableDateTime(
      controller: dateTimeController.value,
      submiteAction: () => inputViewNotifier.selectDateTime(dateTimeController.value.selectedDateTime),
      nowAction: () {
        dateTimeController.value.setDateTimeNow();
        inputViewNotifier.selectDateTime(dateTimeController.value.selectedDateTime);
      },
      datetime: date,
    );
  }
}
