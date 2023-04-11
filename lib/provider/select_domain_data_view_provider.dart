// ignore_for_file: unused_result

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/domain_data.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/enum/sort.dart';
import 'package:tcg_manager/helper/db_helper.dart';
import 'package:tcg_manager/provider/backup_provider.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/provider/firestore_backup_controller_provider.dart';
import 'package:tcg_manager/repository/deck_repository.dart';
import 'package:tcg_manager/repository/firestore_share_data_repository.dart';
import 'package:tcg_manager/repository/game_repository.dart';
import 'package:tcg_manager/repository/tag_repository.dart';
import 'package:tcg_manager/selector/game_share_data_selector.dart';
import 'package:tcg_manager/state/select_domain_data_view_state.dart';

class SelectDomainDataViewNotifier extends StateNotifier<SelectDomainDataViewState> {
  SelectDomainDataViewNotifier(this.ref, this.dataType) : super(SelectDomainDataViewState());

  final Ref ref;
  final DomainDataType dataType;

  void changeSort() {
    const sortTypes = Sort.values;
    final oldIndex = state.sortType.index;
    if (oldIndex + 1 == sortTypes.length) {
      state = state.copyWith(sortType: sortTypes[0]);
    } else {
      state = state.copyWith(sortType: sortTypes[oldIndex + 1]);
    }
  }

  void setSearchText(String searchText) {
    state = state.copyWith(searchText: searchText);
  }

  Future saveDomainData(String name) async {
    final selectGame = ref.read(selectGameNotifierProvider).selectGame;
    if (dataType == DomainDataType.game) {
      final game = Game(name: name);
      ref.read(gameRepository).insert(game);
      ref.invalidate(allGameListProvider);
    } else if (dataType == DomainDataType.deck) {
      final deck = Deck(
        name: name,
        gameId: selectGame!.id,
      );
      if (ref.read(isShareGame)) {
        final share = await ref.read(gameFirestoreShareStreamProvider.future);
        ref.read(firestoreShareDataRepository).addDeck(deck, share!.docName);
      } else {
        ref.read(deckRepository).insert(deck);
        ref.refresh(allDeckListProvider);
      }
    } else if (dataType == DomainDataType.tag) {
      final tag = Tag(
        name: name,
        gameId: selectGame!.id,
      );
      if (ref.read(isShareGame)) {
        final share = await ref.read(gameFirestoreShareStreamProvider.future);
        ref.read(firestoreShareDataRepository).addTag(tag, share!.docName);
      } else {
        ref.read(tagRepository).insert(tag);
        ref.refresh(allTagListProvider);
      }
    }
    if (ref.read(backupNotifierProvider)) await ref.read(firestoreBackupControllerProvider).addAll();
  }

  Future toggleIsVisibleToPicker(DomainData data) async {
    if (dataType == DomainDataType.game) {
      await ref.read(dbHelper).toggleIsVisibleToPickerOfGame(data as Game);
    } else if (dataType == DomainDataType.deck) {
      await ref.read(dbHelper).toggleIsVisibleToPickerOfDeck(data as Deck);
    } else if (dataType == DomainDataType.tag) {
      await ref.read(dbHelper).toggleIsVisibleToPickerOfTag(data as Tag);
    }
  }
}

final selectDomainDataViewNotifierProvider =
    StateNotifierProvider.autoDispose.family<SelectDomainDataViewNotifier, SelectDomainDataViewState, DomainDataType>(
  (ref, dataType) => SelectDomainDataViewNotifier(ref, dataType),
);
