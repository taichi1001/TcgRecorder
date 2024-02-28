import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/provider/record_detail_provider.dart';
import 'package:tcg_manager/view/component/add_photo_widget.dart';

class EditViewAddPhoto extends HookConsumerWidget {
  const EditViewAddPhoto({
    required this.margedRecord,
    Key? key,
  }) : super(key: key);
  final MargedRecord margedRecord;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(recordEditViewNotifierProvider(margedRecord).select((value) => value.images));
    final editViewNotifier = ref.watch(recordEditViewNotifierProvider(margedRecord).notifier);

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Center(
            child: AddPhotoWidgets(
              images: images,
              selectImageFunc: () async {
                final picker = ImagePicker();
                final image = await picker.pickImage(source: ImageSource.gallery);
                if (image == null) return;
                editViewNotifier.inputImage(image);
              },
              deleteImageFunc: editViewNotifier.removeImage,
            ),
          ),
        ),
      ),
    );
  }
}
