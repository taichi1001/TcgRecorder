import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/state/text_editing_controller_state.dart';

class TextEditingControllerNotifier extends StateNotifier<TextEditingControllerState> {
  TextEditingControllerNotifier(this.read)
      : super(TextEditingControllerState(
          useDeckController: TextEditingController(),
          opponentDeckController: TextEditingController(),
          tagController: TextEditingController(),
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

  void resetInputViewController() {
    state = state.copyWith(
      useDeckController: TextEditingController(),
      opponentDeckController: TextEditingController(),
      tagController: TextEditingController(),
    );
  }
}

final textEditingControllerNotifierProvider =
    StateNotifierProvider<TextEditingControllerNotifier, TextEditingControllerState>(
  (ref) => TextEditingControllerNotifier(ref.read),
);
