import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/domain_data.dart';
import 'package:tcg_manager/entity/firestore_share.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/helper/db_helper.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/provider/firestore_controller_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/repository/firestore_share_data_repository.dart';
import 'package:tcg_manager/repository/firestore_share_repository.dart';
import 'package:tcg_manager/repository/firestore_user_settings_repositroy.dart';
import 'package:tcg_manager/repository/game_repository.dart';
import 'package:tcg_manager/selector/game_share_data_selector.dart';
import 'package:tcg_manager/view/share_view/share_user_management_view.dart';

final currentDomainDataProvider = StateProvider<DomainData>((ref) => Game(name: 'name'));
final currentDomainDataIsShareHostProvider = StateProvider<bool>((ref) => false);
final currentShareProvider = StreamProvider.autoDispose<FirestoreShare>((ref) async* {
  final isShareHost = ref.watch(currentDomainDataIsShareHostProvider);
  final game = ref.watch(currentDomainDataProvider);
  if (isShareHost) {
    final hostShare = await ref.watch(hostShareProvider.future);
    yield hostShare.firstWhere((element) => element.game == game);
  } else {
    final guestShare = await ref.watch(guestShareProvider.future);
    yield guestShare.firstWhere((element) => element.game == game);
  }
});

class DomainDataOptions extends HookConsumerWidget {
  const DomainDataOptions({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final domainData = ref.watch(currentDomainDataProvider);
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SelectableRow(text: domainData.name, icon: Icons.gamepad, width: 16),
          const Divider(),
          if (domainData is Game) const _ShareSelectableRow(),
          _SelectableRow(
            text: '名前を変更',
            icon: Icons.edit,
            onTap: () async {
              final newName = await showTextInputDialog(
                context: context,
                title: '名前を変更',
                textFields: [DialogTextField(initialText: domainData.name)],
              );
              if (newName != null) {
                try {
                  switch (domainData) {
                    case Game():
                      if (ref.read(isShareGame)) {
                        final share = await ref.read(currentShareProvider.future);
                        await ref.read(dbHelper).updateGameName(domainData, newName.first);
                        await ref
                            .read(firestoreShareRepository)
                            .updateShare(share.copyWith(game: domainData.copyWith(name: newName.first)));
                      } else {
                        await ref.read(dbHelper).updateGameName(domainData, newName.first);
                      }
                    case Deck():
                      if (ref.read(isShareGame)) {
                        final share = await ref.read(gameFirestoreShareStreamProvider.future);
                        await ref.read(firestoreShareDataRepository).updateDeck(domainData.copyWith(name: newName.first), share!.docName);
                      } else {
                        await ref.read(dbHelper).updateDeckName(domainData, newName.first);
                      }
                    case Tag():
                      if (ref.read(isShareGame)) {
                        final share = await ref.read(gameFirestoreShareStreamProvider.future);
                        await ref.read(firestoreShareDataRepository).updateTag(domainData.copyWith(name: newName.first), share!.docName);
                      } else {
                        await ref.read(dbHelper).updateTagName(domainData, newName.first);
                      }
                  }
                } on DatabaseException catch (e) {
                  if (e.isUniqueConstraintError() && context.mounted) {
                    await showOkAlertDialog(
                      context: context,
                      title: '既に登録されている名前です',
                      message: '「${newName.first}」は既に登録されているため名前を変更することはできませんでした。',
                    );
                  }
                }
              }
              if (context.mounted) Navigator.pop(context);
            },
          ),
          _SelectableRow(
            text: '削除',
            icon: Icons.delete,
            onTap: () async {
              final result = await showOkCancelAlertDialog(
                context: context,
                title: '${domainData.name}を削除しますか？',
                message: () {
                  switch (domainData) {
                    case Tag():
                      return '削除するとこれまでに保存した記録からも削除されます。';
                    default:
                      return '削除するとこれまでに保存していた記録も削除されます。';
                  }
                }(),
              );
              if (result == OkCancelResult.ok) {
                switch (domainData) {
                  case Game():
                    if (ref.read(isShareGame)) {
                      final share = await ref.read(currentShareProvider.future);
                      await ref.read(firestoreShareRepository).deleteShare(share.docName);
                      await ref.read(gameRepository).deleteById(domainData.id!);
                    } else {
                      await ref.read(dbHelper).deleteGame(domainData);
                    }
                  case Deck():
                    if (ref.read(isShareGame)) {
                      final share = await ref.read(gameFirestoreShareStreamProvider.future);
                      await ref.read(firestoreShareDataRepository).removeDeck(domainData, share!.docName);
                    } else {
                      await ref.read(dbHelper).deleteDeck(domainData);
                    }
                  case Tag():
                    if (ref.read(isShareGame)) {
                      final share = await ref.read(gameFirestoreShareStreamProvider.future);
                      await ref.read(firestoreShareDataRepository).removeTag(domainData, share!.docName);
                    } else {
                      await ref.read(dbHelper).deleteTag(domainData);
                    }
                }
              }
              if (context.mounted) Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class _ShareSelectableRow extends HookConsumerWidget {
  const _ShareSelectableRow({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final domainData = ref.watch(currentDomainDataProvider);
    return _SelectableRow(
      text: '共有',
      icon: Icons.person_add_alt,
      onTap: () async {
        final data = domainData as Game;
        if (data.isShare) {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => const ShareUserManagementView(),
            ),
          );
        } else {
          final result = await showOkCancelAlertDialog(
            context: context,
            title: '${domainData.name}を共有しますか？',
            message: '他のユーザーとこのゲームの記録を共有することができます。',
          );
          if (result == OkCancelResult.ok) {
            final uid = ref.read(firebaseAuthNotifierProvider).user?.uid;
            final myUserData = await ref.read(myUserDataProvider.future);
            if (myUserData == null && context.mounted) {
              await showOkAlertDialog(
                context: context,
                title: 'ユーザー名を設定してください。',
                message: 'この機能を使用するためにはプロフィール設定画面からユーザー名を設定する必要があります。',
              );
            } else {
              if (uid != null) {
                final gameData = domainData.copyWith(isShare: true);
                await ref.read(gameRepository).update(gameData);
                ref.read(currentDomainDataProvider.notifier).state = gameData;
                ref.invalidate(allGameListProvider);

                await ref.read(firestoreControllerProvider).initShareGame(gameData, uid);
                final selectGame = ref.read(selectGameNotifierProvider).selectGame;
                if (selectGame?.name == gameData.name) {
                  ref.read(selectGameNotifierProvider.notifier).setSelectGame(gameData);
                }
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => const ShareUserManagementView(),
                    ),
                  );
                }
              }
            }
          }
        }
      },
    );
  }
}

class _SelectableRow extends StatelessWidget {
  const _SelectableRow({
    required this.text,
    required this.icon,
    this.width = 32,
    this.onTap,
    key,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final Function()? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: width),
            Text(text),
          ],
        ),
      ),
    );
  }
}
