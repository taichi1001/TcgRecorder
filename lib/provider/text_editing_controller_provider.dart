import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/provider/input_view_settings_provider.dart';
import 'package:tcg_manager/state/text_editing_controller_state.dart';

class TextEditingControllerNotifier extends StateNotifier<TextEditingControllerState> {
  TextEditingControllerNotifier(this.read)
      : super(TextEditingControllerState(
          useDeckController: TextEditingController(),
          opponentDeckController: TextEditingController(),
          tagController: TextEditingController(),
          memoController: TextEditingController(),
        ));

  final Reader read;

  void setUseDeckController(String value) {
    state = state.copyWith(useDeckController: TextEditingController(text: value));
  }

  void setOpponentDeckController(String value) {
    state = state.copyWith(opponentDeckController: TextEditingController(text: value));
  }

  void setTagController(String value) {
    state = state.copyWith(tagController: TextEditingController(text: value));
  }

  void setMemoController(String value) {
    state = state.copyWith(memoController: TextEditingController(text: value));
  }

  void resetInputViewController() {
    final fixUseDeck = read(inputViewSettingsNotifierProvider).fixUseDeck;
    final fixOpponentDeck = read(inputViewSettingsNotifierProvider).fixOpponentDeck;
    final fixTag = read(inputViewSettingsNotifierProvider).fixTag;
    state = state.copyWith(
      useDeckController: fixUseDeck ? state.useDeckController : TextEditingController(),
      opponentDeckController: fixOpponentDeck ? state.opponentDeckController : TextEditingController(),
      tagController: fixTag ? state.tagController : TextEditingController(),
      memoController: TextEditingController(),
    );
  }
}

final textEditingControllerNotifierProvider = StateNotifierProvider<TextEditingControllerNotifier, TextEditingControllerState>(
  (ref) => TextEditingControllerNotifier(ref.read),
);
