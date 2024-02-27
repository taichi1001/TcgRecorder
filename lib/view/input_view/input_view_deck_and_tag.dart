import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/input_view_provider.dart';
import 'package:tcg_manager/view/component/custom_textfield.dart';
import 'package:tcg_manager/view/component/deck_input_row.dart';
import 'package:tcg_manager/view/component/input_tag_list.dart';
import 'package:tcg_manager/view/input_view/input_view.dart';
import 'package:tcg_manager/view/select_domain_data_bottom_sheet/select_domain_data_view.dart';

class InputViewDeckAndTag extends HookConsumerWidget {
  const InputViewDeckAndTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputViewNotifier = ref.watch(inputViewNotifierProvider.notifier);
    final useDeck = ref.watch(inputViewNotifierProvider.select((value) => value.useDeck));
    final opponentDeck = ref.watch(inputViewNotifierProvider.select((value) => value.opponentDeck));
    final tag = ref.watch(inputViewNotifierProvider.select((value) => value.tag));
    final memo = ref.watch(inputViewNotifierProvider.select((value) => value.memo));
    final focusNodes = ref.watch(focusNodesProvider);

    final useDeckTextController = useTextEditingController(text: useDeck?.name ?? '');
    final opponentDeckTextController = useTextEditingController(text: opponentDeck?.name ?? '');
    final memoTextController = useTextEditingController(text: memo ?? '');
    final tagTextController =
        useState(tag.isNotEmpty ? tag.map((e) => TextEditingController(text: e.name)).toList() : [TextEditingController()]);

    useEffect(() {
      useDeckTextController.text = useDeck?.name ?? '';
      return null;
    }, [useDeck?.name]);

    useEffect(() {
      opponentDeckTextController.text = opponentDeck?.name ?? '';
      return null;
    }, [opponentDeck?.name]);

    useEffect(() {
      memoTextController.text = memo ?? '';
      return null;
    }, [memo]);

    useEffect(() {
      // タグの数が0でもコントローラが少なくとも1つ存在することを保証
      final int desiredControllerCount = max(1, tag.length);

      if (desiredControllerCount > tagTextController.value.length) {
        // 足りない分のコントローラを追加
        tagTextController.value.addAll(
          List.generate(desiredControllerCount - tagTextController.value.length, (_) => TextEditingController()),
        );
      } else if (desiredControllerCount < tagTextController.value.length) {
        // 余分なコントローラを破棄し削除
        tagTextController.value
            .getRange(desiredControllerCount, tagTextController.value.length)
            .forEach((controller) => controller.dispose());
        tagTextController.value = tagTextController.value.sublist(0, desiredControllerCount);
      }

      // タグが存在する場合、それに応じてコントローラのテキストを更新
      for (int i = 0; i < tag.length; i++) {
        tagTextController.value[i].text = tag[i].name;
      }

      // useEffectのクリーンアップ関数では破棄を行わない
      // コンポーネントがアンマウントされるタイミングでのみ破棄する
      return null; // クリーンアップ関数での破棄処理を削除
    }, [tag.length, ...tag.map((e) => e.name)]);

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
              controllers: tagTextController.value,
              focusNodes: focusNodes.sublist(2, focusNodes.length - 1),
              selectTagFunc: inputViewNotifier.selectTag,
              addFunc: inputViewNotifier.addTag,
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
