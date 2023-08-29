import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// loadingインジケーターを表示したいときに使用
final loadingProvider = StateProvider.autoDispose<bool>((ref) => false);

class LoadingOverlay extends HookConsumerWidget {
  const LoadingOverlay({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingProvider);
    return isLoading
        ? const Stack(
            children: [
              Opacity(
                opacity: 0.3,
                child: ModalBarrier(
                  dismissible: false,
                  color: Colors.grey,
                ),
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
