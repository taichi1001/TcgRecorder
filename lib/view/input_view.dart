// ignore_for_file: unused_result

import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tcg_manager/entity/domain_data.dart';
import 'package:tcg_manager/enum/access_roll.dart';
import 'package:tcg_manager/enum/bo.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/helper/premium_plan_dialog.dart';
import 'package:tcg_manager/provider/backup_provider.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/input_view_provider.dart';
import 'package:tcg_manager/provider/input_view_settings_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';
import 'package:tcg_manager/provider/select_game_access_roll.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/provider/text_editing_controller_provider.dart';
import 'package:tcg_manager/provider/firestore_backup_controller_provider.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
import 'package:tcg_manager/view/component/custom_scaffold.dart';
import 'package:tcg_manager/view/component/custom_textfield.dart';
import 'package:tcg_manager/view/component/cutom_date_time_picker.dart';
import 'package:tcg_manager/view/select_domain_data_view.dart';

final _tagFocusNodesProvider = Provider.autoDispose<List<FocusNode>>((ref) {
  final tagTextController = ref.watch(textEditingControllerNotifierProvider.select((value) => value.tagController));
  final List<FocusNode> tagFocusNodes = [];
  for (var i = 0; i < tagTextController.length; i++) {
    tagFocusNodes.add(FocusNode());
  }
  return tagFocusNodes;
});

class SelectableDateTime extends StatelessWidget {
  const SelectableDateTime({
    required this.controller,
    required this.submiteAction,
    required this.nowAction,
    required this.datetime,
    super.key,
  });
  final CustomModalDateTimePickerController controller;
  final Function() submiteAction;
  final Function() nowAction;
  final DateTime datetime;
  @override
  Widget build(BuildContext context) {
    final outputFormat = DateFormat(S.of(context).dateFormatIncludeTime);

    return GestureDetector(
      onTap: () async {
        showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) {
            return CustomModalDateTimePicker(
              controller: controller,
              submitedAction: () {
                submiteAction();
                Navigator.pop(context);
              },
              nowAction: () {
                nowAction();
                Navigator.pop(context);
              },
            );
          },
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                outputFormat.format(datetime),
              ),
              const Icon(
                Icons.calendar_today_rounded,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
    final isPremium = ref.watch(revenueCatNotifierProvider.select((value) => value.isPremium));
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
                IconButton(
                  onPressed: () async {
                    if (addFunc != null && isPremium) {
                      addFunc!();
                    } else if (!isPremium) {
                      await premiumPlanDialog(context);
                    }
                  },
                  icon: const Icon(Icons.add_circle),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

class InputView extends HookConsumerWidget {
  const InputView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final winLoss = ref.watch(inputViewNotifierProvider.select((value) => value.winLoss));
    final firstMatchWinLoss = ref.watch(inputViewNotifierProvider.select((value) => value.firstMatchWinLoss));
    final secondMatchWinLoss = ref.watch(inputViewNotifierProvider.select((value) => value.secondMatchWinLoss));
    final thirdMatchWinLoss = ref.watch(inputViewNotifierProvider.select((value) => value.thirdMatchWinLoss));
    final firstSecond = ref.watch(inputViewNotifierProvider.select((value) => value.firstSecond));
    final firstMatchFirstSecond = ref.watch(inputViewNotifierProvider.select((value) => value.firstMatchFirstSecond));
    final secondMatchFirstSecond = ref.watch(inputViewNotifierProvider.select((value) => value.secondMatchFirstSecond));
    final thirdMatchFirstSecond = ref.watch(inputViewNotifierProvider.select((value) => value.thirdMatchFirstSecond));
    final useDeck = ref.watch(inputViewNotifierProvider.select((value) => value.useDeck));
    final opponentDeck = ref.watch(inputViewNotifierProvider.select((value) => value.opponentDeck));
    final images = ref.watch(inputViewNotifierProvider.select((value) => value.images));
    final inputViewNotifier = ref.read(inputViewNotifierProvider.notifier);
    final textEditingControllerNotifier = ref.read(textEditingControllerNotifierProvider.notifier);
    final useDeckTextController = ref.watch(textEditingControllerNotifierProvider.select((value) => value.useDeckController));
    final opponentDeckTextController = ref.watch(textEditingControllerNotifierProvider.select((value) => value.opponentDeckController));
    final tagTextController = ref.watch(textEditingControllerNotifierProvider.select((value) => value.tagController));
    final memoTextController = ref.watch(textEditingControllerNotifierProvider.select((value) => value.memoController));
    final isDraw = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.draw));
    final isBO3 = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.bo3));

    final useDeckFocusnode = useFocusNode();
    final opponentDeckFocusnode = useFocusNode();
    final tagFocusNodes = ref.watch(_tagFocusNodesProvider);
    final memoFocusnode = useFocusNode();
    return Column(
      children: [
        Expanded(
          child: CustomScaffold(
            padding: const EdgeInsets.only(right: 8, left: 8),
            leading: IconButton(
              icon: const Icon(Icons.tune),
              onPressed: () async {
                showCupertinoModalBottomSheet(
                  expand: false,
                  context: context,
                  builder: (context) => const _SettingModalBottomSheet(),
                );
              },
            ),
            body: KeyboardActions(
              config: KeyboardActionsConfig(
                keyboardBarColor: Theme.of(context).canvasColor,
                keyboardSeparatorColor: Theme.of(context).dividerColor,
                keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
                nextFocus: true,
                actions: [
                  KeyboardActionsItem(focusNode: useDeckFocusnode),
                  KeyboardActionsItem(focusNode: opponentDeckFocusnode),
                  for (final tagFocusNode in tagFocusNodes) KeyboardActionsItem(focusNode: tagFocusNode),
                  KeyboardActionsItem(focusNode: memoFocusnode),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    const _InputViewSelectableDateTime(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 204.w,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  RadioListTile(
                                    title: Text(S.of(context).first),
                                    toggleable: true,
                                    value: FirstSecond.first,
                                    groupValue: isBO3 ? firstMatchFirstSecond : firstSecond,
                                    onChanged: (FirstSecond? value) {
                                      if (isBO3) {
                                        inputViewNotifier.selectMatchFirstSecond(value, 1);
                                      } else {
                                        inputViewNotifier.selectFirstSecond(value);
                                      }
                                    },
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                    dense: true,
                                  ),
                                  RadioListTile(
                                    title: Text(S.of(context).second),
                                    toggleable: true,
                                    value: FirstSecond.second,
                                    groupValue: isBO3 ? firstMatchFirstSecond : firstSecond,
                                    onChanged: (FirstSecond? value) {
                                      if (isBO3) {
                                        inputViewNotifier.selectMatchFirstSecond(value, 1);
                                      } else {
                                        inputViewNotifier.selectFirstSecond(value);
                                      }
                                    },
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                    dense: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 204.w,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  RadioListTile(
                                    title: Text(S.of(context).win),
                                    toggleable: true,
                                    value: WinLoss.win,
                                    groupValue: isBO3 ? firstMatchWinLoss : winLoss,
                                    onChanged: (WinLoss? value) {
                                      if (isBO3) {
                                        inputViewNotifier.selectMatchWinLoss(value, 1);
                                      } else {
                                        inputViewNotifier.selectWinLoss(value);
                                      }
                                    },
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                    dense: true,
                                  ),
                                  RadioListTile(
                                    title: Text(S.of(context).loss),
                                    toggleable: true,
                                    value: WinLoss.loss,
                                    groupValue: isBO3 ? firstMatchWinLoss : winLoss,
                                    onChanged: (WinLoss? value) {
                                      if (isBO3) {
                                        inputViewNotifier.selectMatchWinLoss(value, 1);
                                      } else {
                                        inputViewNotifier.selectWinLoss(value);
                                      }
                                    },
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                    dense: true,
                                  ),
                                  if (isDraw)
                                    RadioListTile(
                                      title: Text(S.of(context).draw),
                                      value: WinLoss.draw,
                                      toggleable: true,
                                      groupValue: isBO3 ? firstMatchWinLoss : winLoss,
                                      onChanged: (WinLoss? value) {
                                        if (isBO3) {
                                          inputViewNotifier.selectMatchWinLoss(value, 1);
                                        } else {
                                          inputViewNotifier.selectWinLoss(value);
                                        }
                                      },
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                      dense: true,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (isBO3)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 204.w,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    RadioListTile(
                                      title: Text(S.of(context).first),
                                      value: FirstSecond.first,
                                      toggleable: true,
                                      groupValue: secondMatchFirstSecond,
                                      onChanged: (FirstSecond? value) {
                                        inputViewNotifier.selectMatchFirstSecond(value, 2);
                                      },
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                      dense: true,
                                    ),
                                    RadioListTile(
                                      title: Text(S.of(context).second),
                                      value: FirstSecond.second,
                                      toggleable: true,
                                      groupValue: secondMatchFirstSecond,
                                      onChanged: (FirstSecond? value) {
                                        inputViewNotifier.selectMatchFirstSecond(value, 2);
                                      },
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                      dense: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 204.w,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    RadioListTile(
                                      title: Text(S.of(context).win),
                                      value: WinLoss.win,
                                      toggleable: true,
                                      groupValue: secondMatchWinLoss,
                                      onChanged: (WinLoss? value) {
                                        inputViewNotifier.selectMatchWinLoss(value, 2);
                                      },
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                      dense: true,
                                    ),
                                    RadioListTile(
                                      title: Text(S.of(context).loss),
                                      value: WinLoss.loss,
                                      toggleable: true,
                                      groupValue: secondMatchWinLoss,
                                      onChanged: (WinLoss? value) {
                                        inputViewNotifier.selectMatchWinLoss(value, 2);
                                      },
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                      dense: true,
                                    ),
                                    if (isDraw)
                                      RadioListTile(
                                        title: Text(S.of(context).draw),
                                        value: WinLoss.draw,
                                        toggleable: true,
                                        groupValue: secondMatchWinLoss,
                                        onChanged: (WinLoss? value) {
                                          inputViewNotifier.selectMatchWinLoss(value, 2);
                                        },
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                        dense: true,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (isBO3)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 204.w,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    RadioListTile(
                                      title: Text(S.of(context).first),
                                      toggleable: true,
                                      value: FirstSecond.first,
                                      groupValue: thirdMatchFirstSecond,
                                      onChanged: (FirstSecond? value) {
                                        inputViewNotifier.selectMatchFirstSecond(value, 3);
                                      },
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                      dense: true,
                                    ),
                                    RadioListTile(
                                      title: Text(S.of(context).second),
                                      value: FirstSecond.second,
                                      toggleable: true,
                                      groupValue: thirdMatchFirstSecond,
                                      onChanged: (FirstSecond? value) {
                                        inputViewNotifier.selectMatchFirstSecond(value, 3);
                                      },
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                      dense: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 204.w,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    RadioListTile(
                                      title: Text(S.of(context).win),
                                      value: WinLoss.win,
                                      toggleable: true,
                                      groupValue: thirdMatchWinLoss,
                                      onChanged: (WinLoss? value) {
                                        inputViewNotifier.selectMatchWinLoss(value, 3);
                                      },
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                      dense: true,
                                    ),
                                    RadioListTile(
                                      title: Text(S.of(context).loss),
                                      value: WinLoss.loss,
                                      toggleable: true,
                                      groupValue: thirdMatchWinLoss,
                                      onChanged: (WinLoss? value) {
                                        inputViewNotifier.selectMatchWinLoss(value, 3);
                                      },
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                      dense: true,
                                    ),
                                    if (isDraw)
                                      RadioListTile(
                                        title: Text(S.of(context).draw),
                                        value: WinLoss.draw,
                                        toggleable: true,
                                        groupValue: thirdMatchWinLoss,
                                        onChanged: (WinLoss? value) {
                                          inputViewNotifier.selectMatchWinLoss(value, 3);
                                        },
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                        dense: true,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                CustomTextField(
                                  labelText: S.of(context).useDeck,
                                  onChanged: (name) => inputViewNotifier.inputDeck(name, true),
                                  controller: useDeckTextController,
                                  focusNode: useDeckFocusnode,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.arrow_drop_down),
                                  onPressed: () {
                                    showCupertinoModalBottomSheet(
                                      expand: true,
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      builder: (BuildContext context) => SelectDomainDataView(
                                        dataType: DomainDataType.deck,
                                        selectDomainDataFunc: (domainData, index) => inputViewNotifier.selectDeck(domainData, index, true),
                                        tagCount: 0,
                                        afterFunc: FocusScope.of(context).unfocus,
                                        enableVisiblity: true,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                CustomTextField(
                                  labelText: S.of(context).opponentDeck,
                                  onChanged: (name) => inputViewNotifier.inputDeck(name, false),
                                  controller: opponentDeckTextController,
                                  focusNode: opponentDeckFocusnode,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.arrow_drop_down),
                                  onPressed: () {
                                    showCupertinoModalBottomSheet(
                                      expand: true,
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      builder: (BuildContext context) => SelectDomainDataView(
                                        dataType: DomainDataType.deck,
                                        selectDomainDataFunc: (domainData, index) => inputViewNotifier.selectDeck(domainData, index, false),
                                        tagCount: 0,
                                        afterFunc: FocusScope.of(context).unfocus,
                                        enableVisiblity: true,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            InputTagList(
                              inputTag: inputViewNotifier.inputTag,
                              controllers: tagTextController,
                              focusNodes: tagFocusNodes,
                              selectTagFunc: inputViewNotifier.selectTag,
                              addFunc: () {
                                textEditingControllerNotifier.addTagController();
                              },
                            ),
                            const SizedBox(height: 8),
                            CustomTextField(
                              controller: memoTextController,
                              focusNode: memoFocusnode,
                              onChanged: inputViewNotifier.inputMemo,
                              labelText: S.of(context).memoTag,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Center(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: addPhotoWidgets(
                                  images: images.map((e) => e.path).toList(),
                                  selectImageFunc: () async {
                                    final picker = ImagePicker();
                                    final image = await picker.pickImage(source: ImageSource.gallery);
                                    if (image == null) return;
                                    inputViewNotifier.inputImage(image);
                                  },
                                  deleteImageFunc: (value) {
                                    inputViewNotifier.removeImage(value);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 300,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: useDeck == null ||
                                      opponentDeck == null ||
                                      (isBO3 && (firstMatchFirstSecond == null || firstMatchWinLoss == null)) ||
                                      (isBO3 && secondMatchFirstSecond != null && secondMatchWinLoss == null) ||
                                      (isBO3 && secondMatchFirstSecond == null && secondMatchWinLoss != null) ||
                                      (isBO3 && thirdMatchFirstSecond != null && thirdMatchWinLoss == null) ||
                                      (isBO3 && thirdMatchFirstSecond == null && thirdMatchWinLoss != null)
                                  ? null
                                  : () async {
                                      final accessRoll = await ref.watch(selectGameAccessRoll.future);
                                      if (accessRoll == AccessRoll.reader && context.mounted) {
                                        await showOkAlertDialog(
                                          context: context,
                                          title: '権限がありません。',
                                          message: 'この操作をする権限がありません。ゲームの管理者にお問い合わせください。',
                                        );
                                      } else if (context.mounted) {
                                        final okCancelResult = await showOkCancelAlertDialog(
                                          context: context,
                                          message: S.of(context).isSave,
                                          isDestructiveAction: true,
                                        );

                                        if (okCancelResult == OkCancelResult.ok) {
                                          SmartDialog.showLoading();
                                          if (isBO3) {
                                            await inputViewNotifier.saveRecord(BO.bo3);
                                          } else {
                                            await inputViewNotifier.saveRecord(BO.bo1);
                                          }
                                          ref.invalidate(allDeckListProvider);
                                          ref.invalidate(allTagListProvider);
                                          ref.invalidate(allRecordListProvider);
                                          // レビュー催促ダイアログ条件検討中
                                          // if (recordCount % 200 == 0) {
                                          //   final inAppReview = InAppReview.instance;
                                          //   if (await inAppReview.isAvailable()) {
                                          //     inAppReview.requestReview();
                                          //   }
                                          // }
                                          if (ref.read(backupNotifierProvider)) {
                                            ref
                                                .read(firestoreBackupControllerProvider)
                                                .addRecord(ref.read(inputViewNotifierProvider).record!);
                                          }
                                          inputViewNotifier.resetView();
                                          SmartDialog.dismiss();
                                        }
                                        if (context.mounted) {
                                          FocusScope.of(context).unfocus();
                                        }
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(S.of(context).save),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const AdaptiveBannerAd(),
      ],
    );
  }
}

List<Widget> addPhotoWidgets({
  required List<String> images,
  required Function() selectImageFunc,
  required Function(int) deleteImageFunc,
}) {
  if (images.isEmpty) return [_AddPhotoWidget(selectImageFunc: selectImageFunc, deleteImageFunc: deleteImageFunc)];
  final List<Widget> result = images
      .mapIndexed(
        (index, image) => _AddPhotoWidget(
          filePath: image,
          index: index,
          selectImageFunc: selectImageFunc,
          deleteImageFunc: deleteImageFunc,
        ),
      )
      .toList();
  result.add(_AddPhotoWidget(selectImageFunc: selectImageFunc, deleteImageFunc: deleteImageFunc));
  return result;
}

class _SettingModalBottomSheet extends HookConsumerWidget {
  const _SettingModalBottomSheet({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fixUseDeck = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.fixUseDeck));
    final fixOpponentDeck = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.fixOpponentDeck));
    final fixTag = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.fixTag));
    final draw = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.draw));
    final bo3 = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.bo3));
    final inputiViewSettingsController = ref.watch(inputViewSettingsNotifierProvider.notifier);
    final isPremium = ref.watch(revenueCatNotifierProvider.select((value) => value.isPremium));

    return Material(
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                child: Text(
                  '入力固定オプション',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SwitchListTile.adaptive(
                contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                title: Text(
                  '使用デッキ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: fixUseDeck,
                onChanged: inputiViewSettingsController.changeFixUseDeck,
              ),
              SwitchListTile.adaptive(
                contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                title: Text(
                  '対戦相手デッキ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: fixOpponentDeck,
                onChanged: inputiViewSettingsController.changeFixOpponentDeck,
              ),
              SwitchListTile.adaptive(
                contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                title: Text(
                  'タグ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: fixTag,
                onChanged: inputiViewSettingsController.changeFixTag,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                child: Text(
                  '入力項目オプション',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SwitchListTile.adaptive(
                contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                title: Text(
                  '引き分け',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: draw,
                onChanged: (value) async {
                  if (isPremium) {
                    inputiViewSettingsController.changeDraw(value);
                  } else {
                    await premiumPlanDialog(context);
                  }
                },
              ),
              SwitchListTile.adaptive(
                contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                title: Text(
                  'BO3',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: bo3,
                onChanged: (value) async {
                  if (isPremium) {
                    inputiViewSettingsController.changeBO3(value);
                  } else {
                    await premiumPlanDialog(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddPhotoWidget extends HookConsumerWidget {
  const _AddPhotoWidget({
    required this.selectImageFunc,
    required this.deleteImageFunc,
    this.filePath,
    this.index,
    key,
  }) : super(key: key);

  final Function() selectImageFunc;
  final Function(int) deleteImageFunc;
  final String? filePath;
  final int? index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPremium = ref.watch(revenueCatNotifierProvider.select((value) => value.isPremium));

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: filePath == null
            ? GestureDetector(
                onTap: () async {
                  if (!isPremium) {
                    selectImageFunc();
                  } else {
                    await premiumPlanDialog(context);
                  }
                },
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    DottedBorder(
                      color: Theme.of(context).dividerColor,
                      dashPattern: const [10, 2],
                      child: const SizedBox(
                        width: 80,
                        height: 80,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.add_a_photo_outlined),
                    ),
                  ],
                ),
              )
            : GestureDetector(
                onTap: () {
                  deleteImageFunc(index!);
                },
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: filePath!.startsWith('https')
                          ? CachedNetworkImage(
                              imageUrl: filePath!,
                              fit: BoxFit.contain,
                            )
                          : Image.file(
                              File(filePath!),
                              fit: BoxFit.contain,
                            ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.cancel),
                    ),
                  ],
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
