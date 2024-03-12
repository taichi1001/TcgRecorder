import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/helper/initial_data_controller.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/repository/firestore_public_game_repository.dart';
import 'package:tcg_manager/repository/game_repository.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';

class InitialGameRegistrationView extends HookConsumerWidget {
  const InitialGameRegistrationView({Key? key}) : super(key: key);

  Future _save(WidgetRef ref, Game game) async {
    final id = await ref.read(gameRepository).insert(game);
    ref.read(initialDataControllerProvider).saveGame(game.copyWith(id: id));
    ref.invalidate(allGameListProvider);
    ref.read(selectGameNotifierProvider.notifier).startupGame();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final publicGameList = ref.watch(publicGameListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('ゲーム一覧')),
      bottomNavigationBar: const AdaptiveBannerAd(),
      // TODO 説明文を追加
      body: publicGameList.when(
        data: (publicGameListData) => ListView.separated(
          itemCount: publicGameListData.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              tileColor: Theme.of(context).colorScheme.surface,
              selectedColor: Theme.of(context).hoverColor,
              titleTextStyle: Theme.of(context).textTheme.bodyMedium,
              subtitleTextStyle: Theme.of(context).textTheme.labelSmall,
              title: Text(publicGameListData[index].name),
              onTap: () async {
                final result = await showTextInputDialog(
                  context: context,
                  title: 'ゲーム名を入力',
                  textFields: [
                    DialogTextField(initialText: publicGameListData[index].name),
                  ],
                );
                if (result != null) {
                  _save(ref, Game(name: result.first, publicGameId: publicGameListData[index].id));
                }
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(
            indent: 16,
            thickness: 1,
            height: 0,
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(error.toString())),
      ),
    );
  }
}
