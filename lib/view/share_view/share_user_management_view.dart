import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/view/component/list_tile_ontap.dart';
import 'package:tcg_manager/view/select_domain_data_bottom_sheet/domain_data_options.dart';

class ShareUserManagementView extends HookConsumerWidget {
  const ShareUserManagementView({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentShare = ref.watch(currentShareProvider);
    return currentShare.when(
      error: (error, stack) => Text('$error'),
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (data) {
        return Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          appBar: AppBar(
            title: Text(data.game.name),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.help),
              ),
            ],
          ),
          body: Column(
            children: [
              ListTileOnTap(
                leading: const Icon(Icons.link),
                title: '共有用リンクを作成',
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(_originalSnackBar(context)),
              ),
              // 作成者のプロフィールウィジェット
              // 共有申請ヘッダー
              // 共有申請中ユーザーのプロフィールウィジェットリスト
              // 共有中ヘッダー
              // 共有中ユーザーのプロフィールウィジェットリスト
            ],
          ),
        );
      },
    );
  }
}

SnackBar _originalSnackBar(BuildContext context) {
  return SnackBar(
    padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
    margin: const EdgeInsetsDirectional.all(16),
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            Icons.check,
            color: Theme.of(context).colorScheme.onTertiary,
          ),
          Text(
            'リンクをコピーしました。',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
            ),
          ),
        ],
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    behavior: SnackBarBehavior.floating,
    elevation: 4.0,
    backgroundColor: Theme.of(context).colorScheme.tertiary,
    showCloseIcon: true,
    clipBehavior: Clip.hardEdge,
    dismissDirection: DismissDirection.horizontal,
  );
}
