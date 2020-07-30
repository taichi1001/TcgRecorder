import 'package:flutter/material.dart';

class InputRecordContentsScreenValidator {
  void numericValuesValidator(List<TextEditingController> controllers) {
    for (final controller in controllers) {
      if (int.tryParse(controller.text) is! int) {
        throw Exception('数字以外の値が入力されています。');
      }
    }
  }
}
