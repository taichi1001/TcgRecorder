import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/helper/review_helper.dart';
import 'package:tcg_manager/provider/user_activity_provider.dart';
import 'package:tcg_manager/view/support_modal.dart';

Future showReviewDialog(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const ReviewModal();
    },
  );
}

class ReviewModal extends HookConsumerWidget {
  const ReviewModal({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      surfaceTintColor: Theme.of(context).canvasColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          const Text(
            '🤔',
            style: TextStyle(fontSize: 48),
          ),
          const SizedBox(height: 16),
          Text(
            '使い心地はいかがですか？',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () async {
                  Navigator.of(context).pop();
                  ref.read(userActivityLogNotifierProvider.notifier).choseDissatisfaction();
                  await showSupportDialog(context);
                },
                child: Container(
                  width: 125,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).hoverColor,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.heart_broken,
                          color: Colors.grey,
                          size: 36,
                        ),
                        Text(
                          '不満',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  ReviewHelper.launchStoreReview(context);
                  ref.read(userActivityLogNotifierProvider.notifier).choseReview();
                  Navigator.pop(context);
                },
                child: Container(
                  width: 125,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).hoverColor,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.favorite,
                          color: Colors.redAccent,
                          size: 36,
                        ),
                        Text(
                          '満足',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              ref.read(userActivityLogNotifierProvider.notifier).choseAnswerLater();
              Navigator.of(context).pop();
            },
            child: Text(
              'あとで回答する',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
