import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/input_view_provider.dart';
import 'package:tcg_manager/provider/text_editing_controller_provider.dart';
import 'package:tcg_manager/view/component/custom_textfield.dart';
import 'package:tcg_manager/view/component/deck_input_row.dart';
import 'package:tcg_manager/view/component/input_tag_list.dart';
import 'package:tcg_manager/view/input_view/input_view.dart';
import 'package:tcg_manager/view/select_domain_data_bottom_sheet/select_domain_data_view.dart';

class InputViewDeckAndTag extends HookConsumerWidget {
  const InputViewDeckAndTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputViewNotifier = ref.read(inputViewNotifierProvider.notifier);
    final textEditingControllerNotifier = ref.read(textEditingControllerNotifierProvider.notifier);
    final useDeckTextController = ref.watch(textEditingControllerNotifierProvider.select((value) => value.useDeckController));
    final opponentDeckTextController = ref.watch(textEditingControllerNotifierProvider.select((value) => value.opponentDeckController));
    final tagTextController = ref.watch(textEditingControllerNotifierProvider.select((value) => value.tagController));
    final memoTextController = ref.watch(textEditingControllerNotifierProvider.select((value) => value.memoController));
    final focusNodes = ref.watch(focusNodesProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DeckInputRow(
              labelText: S.of(context).useDeck,
              onChanged: (name) => inputViewNotifier.inputDeck(name, true),
              controller: useDeckTextController,
              focusNode: focusNodes[0],
              isUserDeck: true,
              onPressed: showDeckSelectionModal(context, inputViewNotifier, true),
            ),
            const SizedBox(height: 8),
            DeckInputRow(
              labelText: S.of(context).opponentDeck,
              onChanged: (name) => inputViewNotifier.inputDeck(name, false),
              controller: opponentDeckTextController,
              focusNode: focusNodes[1],
              isUserDeck: false,
              onPressed: showDeckSelectionModal(context, inputViewNotifier, false),
            ),
            const SizedBox(height: 8),
            InputTagList(
              inputTag: inputViewNotifier.inputTag,
              controllers: tagTextController,
              focusNodes: focusNodes.sublist(2, focusNodes.length - 1),
              selectTagFunc: inputViewNotifier.selectTag,
              addFunc: textEditingControllerNotifier.addTagController,
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: memoTextController,
              focusNode: focusNodes.last,
              onChanged: inputViewNotifier.inputMemo,
              labelText: S.of(context).memoTag,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ],
        ),
      ),
    );
  }

  VoidCallback showDeckSelectionModal(BuildContext context, InputViewNotifier inputViewNotifier, bool isUserDeck) {
    return () {
      showCupertinoModalBottomSheet(
        expand: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) => SelectDomainDataView(
          dataType: DomainDataType.deck,
          selectDomainDataFunc: (domainData, index) => inputViewNotifier.selectDeck(domainData, index, isUserDeck),
          tagCount: 0,
          afterFunc: FocusScope.of(context).unfocus,
          enableVisiblity: true,
        ),
      );
    };
  }
}
