import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tcg_manager/entity/domain_data.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/helper/premium_plan_dialog.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';
import 'package:tcg_manager/view/component/custom_textfield.dart';
import 'package:tcg_manager/view/component/premium_lock_icon.dart';
import 'package:tcg_manager/view/select_domain_data_bottom_sheet/select_domain_data_view.dart';

class InputTagList extends HookConsumerWidget {
  const InputTagList({
    this.addFunc,
    required this.controllers,
    required this.focusNodes,
    required this.inputTag,
    required this.selectTagFunc,
    super.key,
  });

  final Function(String, int) inputTag;
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final Function(DomainData, int) selectTagFunc;
  final void Function()? addFunc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPremium = ref.watch(revenueCatProvider.select((value) => value?.isPremium));
    return Column(
      children: controllers
          .mapIndexed(
            (index, controller) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    fit: StackFit.loose,
                    children: [
                      CustomTextField(
                        labelText: S.of(context).tag + (index + 1).toString(),
                        indexOnChanged: inputTag,
                        controller: controller,
                        focusNode: focusNodes[index],
                        index: index,
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_drop_down),
                        onPressed: () {
                          showCupertinoModalBottomSheet(
                            expand: true,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) => SelectDomainDataView(
                              dataType: DomainDataType.tag,
                              selectDomainDataFunc: selectTagFunc,
                              tagCount: index,
                              afterFunc: FocusScope.of(context).unfocus,
                              enableVisiblity: true,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                PremiumLockIcon(
                  isPremium: isPremium ?? false,
                  child: IconButton(
                    onPressed: () async {
                      if (addFunc != null && isPremium!) {
                        addFunc!();
                      } else if (!isPremium!) {
                        await premiumPlanDialog(context);
                      }
                    },
                    icon: const Icon(Icons.add_circle),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
