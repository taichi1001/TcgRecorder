import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/provider/input_view_provider.dart';
import 'package:tcg_manager/provider/input_view_settings_provider.dart';
import 'package:tcg_manager/state/text_editing_controller_state.dart';

class TextEditingControllerNotifier extends StateNotifier<TextEditingControllerState> {
  TextEditingControllerNotifier(this.ref)
      : super(TextEditingControllerState(
          useDeckController: TextEditingController(),
          opponentDeckController: TextEditingController(),
          tagController: [TextEditingController()],
          memoController: TextEditingController(),
        ));

  final Ref ref;

  void setUseDeckController(String value) {
    state = state.copyWith(useDeckController: TextEditingController(text: value));
  }

  void setOpponentDeckController(String value) {
    state = state.copyWith(opponentDeckController: TextEditingController(text: value));
  }

  void setTagController(String value, int index) {
    final newTagControllers = [...state.tagController];
    if (newTagControllers.length > index) {
      newTagControllers[index] = TextEditingController(text: value);
    } else {
      newTagControllers.add(TextEditingController(text: value));
    }
    state = state.copyWith(tagController: newTagControllers);
  }

  void addTagController() {
    final newTagControllers = [...state.tagController];
    newTagControllers.add(TextEditingController());
    state = state.copyWith(tagController: newTagControllers);
  }

  void setMemoController(String value) {
    state = state.copyWith(memoController: TextEditingController(text: value));
  }

  void resetInputViewController() {
    final fixUseDeck = ref.read(inputViewSettingsNotifierProvider).fixUseDeck;
    final fixOpponentDeck = ref.read(inputViewSettingsNotifierProvider).fixOpponentDeck;
    final fixTag = ref.read(inputViewSettingsNotifierProvider).fixTag;
    final inputViewState = ref.read(inputViewNotifierProvider);
    state = state.copyWith(
      useDeckController: fixUseDeck ? TextEditingController(text: inputViewState.useDeck?.name) : TextEditingController(),
      opponentDeckController: fixOpponentDeck ? TextEditingController(text: inputViewState.opponentDeck?.name) : TextEditingController(),
      tagController: fixTag ? inputViewState.tag.map((e) => TextEditingController(text: e.name)).toList() : [TextEditingController()],
      memoController: TextEditingController(),
    );
  }
}

final textEditingControllerNotifierProvider = StateNotifierProvider<TextEditingControllerNotifier, TextEditingControllerState>(
  (ref) => TextEditingControllerNotifier(ref),
);
