import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/record_detail_provider.dart';
import 'package:tcg_manager/view/component/custom_textfield.dart';
import 'package:tcg_manager/view/component/deck_input_row.dart';
import 'package:tcg_manager/view/component/input_tag_list.dart';
import 'package:tcg_manager/view/edit_view/record_edit_view.dart';
import 'package:tcg_manager/view/select_domain_data_bottom_sheet/select_domain_data_view.dart';

class EditViewDeckAndTag extends HookConsumerWidget {
  const EditViewDeckAndTag({
    required this.margedRecord,
    Key? key,
  }) : super(key: key);
  final MargedRecord margedRecord;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editViewNotifier = ref.watch(recordEditViewNotifierProvider(margedRecord).notifier);

    final editMargedRecord = ref.watch(recordEditViewNotifierProvider(margedRecord).select((value) => value.editMargedRecord));
    final useDeckTextController = useTextEditingController(text: editMargedRecord.useDeck);
    final opponentDeckTextController = useTextEditingController(text: editMargedRecord.opponentDeck);

    final tagTextControllers = ref.watch(editViewTagTextController);
    final memoTextController = useTextEditingController(text: editMargedRecord.memo);
    final focusNodes = ref.watch(editViewFocusNodesPrivder);

    final isSelectPicker = useState(false);

    if (isSelectPicker.value) {
      useDeckTextController.text = editMargedRecord.useDeck;
      opponentDeckTextController.text = editMargedRecord.opponentDeck;
      editMargedRecord.tag.asMap().forEach((index, value) {
        tagTextControllers[index].text = value;
      });
      memoTextController.text = editMargedRecord.memo ?? '';
      isSelectPicker.value = false;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DeckInputRow(
              labelText: S.of(context).useDeck,
              onChanged: (name) => editViewNotifier.editUseDeck(name),
              controller: useDeckTextController,
              focusNode: focusNodes[0],
              isUserDeck: true,
              onPressed: () async {
                await showDeckSelectionModal(context, editViewNotifier, true);
                isSelectPicker.value = true;
              },
            ),
            const SizedBox(height: 8),
            DeckInputRow(
              labelText: S.of(context).opponentDeck,
              onChanged: (name) => editViewNotifier.editOpponentDeck(name),
              controller: opponentDeckTextController,
              focusNode: focusNodes[1],
              isUserDeck: false,
              onPressed: () async {
                await showDeckSelectionModal(context, editViewNotifier, false);
                isSelectPicker.value = true;
              },
            ),
            const SizedBox(height: 8),
            InputTagList(
              inputTag: editViewNotifier.editTag,
              controllers: tagTextControllers,
              focusNodes: focusNodes.sublist(2, focusNodes.length - 1),
              selectTagFunc: (data, index) {
                editViewNotifier.selectTag(data, index);
                isSelectPicker.value = true;
              },
              addFunc: () {
                ref.read(editViewTagTextController.notifier).state = [...tagTextControllers, TextEditingController()];
                ref.read(originalTagLength.notifier).state = ref.read(editViewTagTextController).length;
              },
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: memoTextController,
              focusNode: focusNodes.last,
              onChanged: editViewNotifier.editMemo,
              labelText: S.of(context).memoTag,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ],
        ),
      ),
    );
  }

  Future showDeckSelectionModal(BuildContext context, RecordEditViewNotifier editViewNotifier, bool isUserDeck) async {
    await showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => SelectDomainDataView(
        dataType: DomainDataType.deck,
        selectDomainDataFunc: (domainData, index) {
          if (isUserDeck) {
            editViewNotifier.selectUseDeck(domainData, index);
          } else {
            editViewNotifier.selectOpponentDeck(domainData, index);
          }
        },
        tagCount: 0,
        afterFunc: FocusScope.of(context).unfocus,
        enableVisiblity: true,
      ),
    );
  }
}
