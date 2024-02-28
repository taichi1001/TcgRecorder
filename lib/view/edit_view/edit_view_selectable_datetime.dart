import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/provider/record_detail_provider.dart';
import 'package:tcg_manager/view/component/cutom_date_time_picker.dart';
import 'package:tcg_manager/view/component/selectable_datetime.dart';

class EditViewSelectableDateTime extends HookConsumerWidget {
  const EditViewSelectableDateTime({
    required this.margedRecord,
    key,
  }) : super(key: key);

  final MargedRecord margedRecord;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editMargedRecord = ref.watch(recordEditViewNotifierProvider(margedRecord).select((value) => value.editMargedRecord));
    final recordDetailNotifier = ref.watch(recordEditViewNotifierProvider(margedRecord).notifier);
    final dateTimeController = useState(CustomModalDateTimePickerController(initialDateTime: DateTime.now()));

    return SelectableDateTime(
      controller: dateTimeController.value,
      submiteAction: () {
        recordDetailNotifier.selectDateTime(dateTimeController.value.selectedDateTime);
      },
      nowAction: () async {
        dateTimeController.value.setDateTimeNow();
        recordDetailNotifier.selectDateTime(dateTimeController.value.selectedDateTime);
      },
      datetime: editMargedRecord.date,
    );
  }
}
