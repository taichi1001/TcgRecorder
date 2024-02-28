import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tcg_manager/provider/input_view_provider.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
import 'package:tcg_manager/view/component/custom_scaffold.dart';
import 'package:tcg_manager/view/component/loading_overlay.dart';
import 'package:tcg_manager/view/input_view/input_view_add_photo.dart';
import 'package:tcg_manager/view/input_view/input_view_deck_and_tag.dart';
import 'package:tcg_manager/view/input_view/input_view_selectable_datetime.dart';
import 'package:tcg_manager/view/input_view/input_view_win_loss_first_second.dart';
import 'package:tcg_manager/view/input_view/save_button.dart';
import 'package:tcg_manager/view/input_view/setting_modal_bottom_sheet.dart';

final focusNodesProvider = Provider.autoDispose<List<FocusNode>>((ref) {
  final tagLength = ref.watch(inputViewNotifierProvider.select((value) => value.tag.length));
  final List<FocusNode> focusNodes = [];
  if (tagLength == 0) {
    focusNodes.add(FocusNode());
  } else {
    for (var i = 0; i < tagLength; i++) {
      focusNodes.add(FocusNode());
    }
  }

  focusNodes.insert(0, FocusNode()); // 使用デッキ用
  focusNodes.insert(1, FocusNode()); // 対戦相手デッキ用
  focusNodes.add(FocusNode()); //メモ用
  return focusNodes;
});

class InputView extends StatelessWidget {
  const InputView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: CustomScaffold(
                padding: EdgeInsets.only(right: 8, left: 8),
                leading: _SettingIconButton(),
                body: InputViewBody(),
              ),
            ),
            AdaptiveBannerAd(),
          ],
        ),
        LoadingOverlay(),
      ],
    );
  }
}

class _SettingIconButton extends StatelessWidget {
  const _SettingIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    final keyboardActions = ref.watch(focusNodesProvider).map((focusNode) => KeyboardActionsItem(focusNode: focusNode)).toList();

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
          InputViewSelectableDateTime(),
          InputViewWinLossFirstSecond(),
          InputViewDeckAndTag(),
          InputViewAddPhoto(),
          SizedBox(height: 16),
          SaveButton(),
        ],
      ),
    );
  }
}
