import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/record_detail_provider.dart';
import 'package:tcg_manager/provider/record_edit_view_settings_provider.dart';
import 'package:tcg_manager/view/edit_view/edit_setting_modal_bottom_sheet.dart';
import 'package:tcg_manager/view/edit_view/edit_view_add_photo.dart';
import 'package:tcg_manager/view/edit_view/edit_view_deck_and_tag.dart';
import 'package:tcg_manager/view/edit_view/edit_view_selectable_datetime.dart';
import 'package:tcg_manager/view/edit_view/edit_view_win_loss_first_second.dart';

final originalTagLength = StateProvider<int>((ref) => 1);
final originalTag = StateProvider<List<String>>((ref) => []);

final editViewTagTextController = StateProvider.autoDispose<List<TextEditingController>>((ref) {
  final List<TextEditingController> tagTextControllers = [];
  final tags = ref.watch(originalTag);
  if (tags.isEmpty) {
    tagTextControllers.add(TextEditingController());
  } else {
    for (final tag in tags) {
      tagTextControllers.add(TextEditingController(text: tag));
    }
  }
  return tagTextControllers;
});

final editViewFocusNodesPrivder = Provider.autoDispose<List<FocusNode>>((ref) {
  final tagTextController = ref.watch(editViewTagTextController);
  final List<FocusNode> tagFocusNodes = [];
  for (var i = 0; i < tagTextController.length; i++) {
    tagFocusNodes.add(FocusNode());
  }
  tagFocusNodes.insert(0, FocusNode()); // 使用デッキ用
  tagFocusNodes.insert(1, FocusNode()); // 対戦相手デッキ用
  tagFocusNodes.add(FocusNode()); //メモ用
  return tagFocusNodes;
});

class RecordEditView extends HookConsumerWidget {
  const RecordEditView({
    Key? key,
    required this.margedRecord,
  }) : super(key: key);

  final MargedRecord margedRecord;

  Future<bool> _handleWillPop(BuildContext context) async {
    final okCancelResult = await showOkCancelAlertDialog(
      context: context,
      message: S.of(context).recordEditDialogMessage,
      isDestructiveAction: true,
    );
    return okCancelResult == OkCancelResult.ok;
  }

  Future<void> _handleSaveButton(BuildContext context, WidgetRef ref) async {
    final isBO3 = ref.read(recordEditViewSettingsNotifierProvider(margedRecord).select((value) => value.bo3));
    await ref.read(recordEditViewNotifierProvider(margedRecord).notifier).saveEditRecord(isBO3: isBO3);
    if (context.mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () => _handleWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(S.of(context).editButton),
          actions: [
            IconButton(
              icon: const Icon(Icons.tune),
              onPressed: () {
                showCupertinoModalBottomSheet(
                  expand: false,
                  context: context,
                  builder: (context) => EditSettingModalBottomSheet(record: margedRecord),
                );
              },
            ),
            CupertinoButton(
              child: Text(
                S.of(context).save,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              onPressed: () => _handleSaveButton(context, ref),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: _EditView(margedRecord: margedRecord),
        ),
      ),
    );
  }
}

class _EditView extends HookConsumerWidget {
  const _EditView({
    Key? key,
    required this.margedRecord,
  }) : super(key: key);

  final MargedRecord margedRecord;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyboardActions = ref.watch(editViewFocusNodesPrivder).map((focusNode) => KeyboardActionsItem(focusNode: focusNode)).toList();

    return KeyboardActions(
      config: KeyboardActionsConfig(
        keyboardBarColor: Theme.of(context).canvasColor,
        keyboardSeparatorColor: Theme.of(context).dividerColor,
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        nextFocus: true,
        actions: keyboardActions,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            EditViewSelectableDateTime(margedRecord: margedRecord),
            EditViewWinLossFirstSecond(margedRecord: margedRecord),
            EditViewDeckAndTag(margedRecord: margedRecord),
            EditViewAddPhoto(margedRecord: margedRecord),
          ],
        ),
      ),
    );
  }
}
