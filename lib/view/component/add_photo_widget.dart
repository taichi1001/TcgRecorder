import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/helper/premium_plan_dialog.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';
import 'package:tcg_manager/view/component/premium_lock_icon.dart';

class AddPhotoWidgets extends StatelessWidget {
  final List<String> images;
  final Function() selectImageFunc;
  final Function(int) deleteImageFunc;

  const AddPhotoWidgets({
    required this.images,
    required this.selectImageFunc,
    required this.deleteImageFunc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return _AddPhotoWidget(selectImageFunc: selectImageFunc, deleteImageFunc: deleteImageFunc);
    }

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length + 1, // Add one for the extra add button
        itemBuilder: (context, index) {
          if (index == images.length) {
            // The last item is the add button
            return _AddPhotoWidget(selectImageFunc: selectImageFunc, deleteImageFunc: deleteImageFunc);
          } else {
            // Display the image
            return _AddPhotoWidget(
              filePath: images[index],
              index: index,
              selectImageFunc: selectImageFunc,
              deleteImageFunc: deleteImageFunc,
            );
          }
        },
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
    final isPremium = ref.watch(revenueCatProvider.select((value) => value?.isPremium));
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: filePath == null
            ? PremiumLockIcon(
                isPremium: isPremium!,
                child: GestureDetector(
                  onTap: () async {
                    if (isPremium) {
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
