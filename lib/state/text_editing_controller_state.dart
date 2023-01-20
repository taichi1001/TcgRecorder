import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_editing_controller_state.freezed.dart';

@freezed
abstract class TextEditingControllerState with _$TextEditingControllerState {
  factory TextEditingControllerState({
    required TextEditingController useDeckController,
    required TextEditingController opponentDeckController,
    required List<TextEditingController> tagController,
    required TextEditingController memoController,
  }) = _TextEditingControllerState;
}
