import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/input_view_provider.dart';
import 'package:tcg_manager/provider/text_editing_controller_provider.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
import 'package:tcg_manager/view/component/custom_scaffold.dart';
import 'package:tcg_manager/view/component/custom_textfield.dart';
import 'package:tcg_manager/view/component/cutom_date_time_picker.dart';
import 'package:tcg_manager/view/component/deck_input_row.dart';
import 'package:tcg_manager/view/input_view/add_photo_widget.dart';
import 'package:tcg_manager/view/input_view/input_tag_list.dart';
import 'package:tcg_manager/view/input_view/save_button.dart';
import 'package:tcg_manager/view/input_view/selectable_datetime.dart';
import 'package:tcg_manager/view/input_view/setting_modal_bottom_sheet.dart';
import 'package:tcg_manager/view/input_view/win_loss_first_second.dart';
import 'package:tcg_manager/view/select_domain_data_bottom_sheet/select_domain_data_view.dart';

final _focusNodesProvider = Provider.autoDispose<List<FocusNode>>((ref) {
  final tagTextController = ref.watch(textEditingControllerNotifierProvider.select((value) => value.tagController));
  final List<FocusNode> tagFocusNodes = [];
  for (var i = 0; i < tagTextController.length; i++) {
    tagFocusNodes.add(FocusNode());
  }
  tagFocusNodes.insert(0, FocusNode()); // 使用デッキ用
  tagFocusNodes.insert(1, FocusNode()); // 対戦相手デッキ用
  tagFocusNodes.add(FocusNode()); //メモ用
  return tagFocusNodes;
});

class InputView extends StatelessWidget {
  const InputView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: CustomScaffold(
            padding: EdgeInsets.only(right: 8, left: 8),
            leading: SettingIconButton(),
            body: InputViewBody(),
          ),
        ),
        AdaptiveBannerAd(),
      ],
    );
  }
}

class SettingIconButton extends HookConsumerWidget {
  const SettingIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.tune),
      onPressed: () async {
        showCupertinoModalBottomSheet(
          expand: false,
          context: context,
          builder: (context) => const SettingModalBottomSheet(),
        );
      },
    );
  }
}

class InputViewBody extends HookConsumerWidget {
  const InputViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyboardActions = ref.watch(_focusNodesProvider).map((focusNode) => KeyboardActionsItem(focusNode: focusNode)).toList();

    return KeyboardActions(
      config: KeyboardActionsConfig(
        keyboardBarColor: Theme.of(context).canvasColor,
        keyboardSeparatorColor: Theme.of(context).dividerColor,
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        nextFocus: true,
        actions: keyboardActions,
      ),
      child: ListView(
        children: const [
          SizedBox(height: 8),
          _InputViewSelectableDateTime(),
          WinLossFirstSecond(),
          InputViewDeckAndTag(),
          InputViewAddPhoto(),
          SizedBox(height: 16),
          SaveButton(),
        ],
      ),
    );
  }
}

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
    final focusNodes = ref.watch(_focusNodesProvider);

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

class InputViewAddPhoto extends HookConsumerWidget {
  const InputViewAddPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(inputViewNotifierProvider.select((value) => value.images));
    final inputViewNotifier = ref.read(inputViewNotifierProvider.notifier);

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Center(
            child: AddPhotoWidgets(
              images: images.map((e) => e.path).toList(),
              selectImageFunc: () async {
                final picker = ImagePicker();
                final image = await picker.pickImage(source: ImageSource.gallery);
                if (image == null) return;
                inputViewNotifier.inputImage(image);
              },
              deleteImageFunc: inputViewNotifier.removeImage,
            ),
          ),
        ),
      ),
    );
  }
}

class _InputViewSelectableDateTime extends HookConsumerWidget {
  const _InputViewSelectableDateTime();
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
