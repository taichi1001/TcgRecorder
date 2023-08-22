import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/provider/input_view_provider.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/view/select_domain_data_bottom_sheet/select_domain_data_view.dart';

class CustomScaffold extends HookConsumerWidget {
  const CustomScaffold({
    required this.body,
    this.leading,
    this.rightButton,
    this.appBarBottom,
    this.padding,
    key,
  }) : super(key: key);
  final Widget body;
  final Widget? leading;
  final Widget? rightButton;
  final PreferredSizeWidget? appBarBottom;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectGame = ref.watch(selectGameNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Wrap(
          spacing: 8,
          children: [
            if (selectGame.selectGame!.isShare) const Icon(Icons.share),
            Text(
              selectGame.selectGame != null ? selectGame.selectGame!.name : '',
            ),
          ],
        ),
        leading: leading,
        actions: [
          const _GameListPickerButton(),
          if (rightButton != null) rightButton!,
        ],
        bottom: appBarBottom != null ? appBarBottom! : null,
      ),
      body: Padding(
        padding: padding != null ? padding! : const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
        child: body,
      ),
    );
  }
}

class _GameListPickerButton extends HookConsumerWidget {
  const _GameListPickerButton({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectGameNotifier = ref.read(selectGameNotifierProvider.notifier);
    final inputViewNotifier = ref.read(inputViewNotifierProvider.notifier);
    return IconButton(
      icon: const Icon(Icons.arrow_drop_down),
      onPressed: () {
        showCupertinoModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SelectDomainDataView(
              dataType: DomainDataType.game,
              selectDomainDataFunc: (data, count) {
                selectGameNotifier.selectGame(data as Game, count);
              },
              tagCount: 0,
              afterFunc: inputViewNotifier.resetViewAll,
              enableVisiblity: true,
            );
          },
        );
      },
    );
  }
}
