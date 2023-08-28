import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcg_manager/provider/input_view_provider.dart';
import 'package:tcg_manager/view/component/add_photo_widget.dart';

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
