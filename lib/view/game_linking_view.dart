import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/public_game.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/repository/firestore_public_game_repository.dart';
import 'package:tcg_manager/repository/game_repository.dart';

class GameLinkingView extends HookConsumerWidget {
  const GameLinkingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameList = ref.watch(allGameListProvider);
    final publicGameList = ref.watch(publicGameListProvider);
    final linkedGames = useState<List<Game>>([]);

    useEffect(() {
      linkedGames.value = gameList.maybeWhen(
        data: (games) => games.where((game) => game.publicGameId != null).toList(),
        orElse: () => [],
      );
      return null;
    }, [gameList]);

    bool isAllGamesLinked = linkedGames.value.length ==
        gameList.maybeWhen(
          data: (games) => games.length,
          orElse: () => 0,
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('ゲームと紐づけ'),
        actions: [
          IconButton(
            icon: const Text('保存'),
            onPressed: isAllGamesLinked
                ? () async {
                    await ref.read(gameRepository).updateGameList(linkedGames.value);
                  }
                : null,
          ),
        ],
      ),
      body: gameList.when(
        data: (gameListData) => publicGameList.when(
          data: (publicGameListData) {
            final unlinkedGameList = gameListData.where((game) => game.publicGameId == null).toList();

            return ListView.builder(
              itemCount: unlinkedGameList.length,
              itemBuilder: (context, index) => GameTile(
                game: unlinkedGameList[index],
                publicGameList: publicGameListData,
                onLink: (Game updatedGame) {
                  final index = linkedGames.value.indexWhere((game) => game.id == updatedGame.id);
                  if (index != -1) {
                    linkedGames.value[index] = updatedGame;
                  } else {
                    linkedGames.value = List.from(linkedGames.value)..add(updatedGame);
                  }
                },
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text(error.toString())),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(error.toString())),
      ),
    );
  }
}

class GameTile extends HookWidget {
  final Game game;
  final List<PublicGame> publicGameList;
  final Function(Game) onLink;

  const GameTile({
    Key? key,
    required this.game,
    required this.publicGameList,
    required this.onLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameState = useState(game);

    return ListTile(
      title: Text(gameState.value.name),
      subtitle: gameState.value.publicGameId == null
          ? null
          : Text(publicGameList.where((element) => element.id == gameState.value.publicGameId).first.name),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return ListView.builder(
              itemCount: publicGameList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(publicGameList[index].name),
                  onTap: () async {
                    final updatedGame = gameState.value.copyWith(publicGameId: publicGameList[index].id);
                    gameState.value = updatedGame;
                    onLink(updatedGame);
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
