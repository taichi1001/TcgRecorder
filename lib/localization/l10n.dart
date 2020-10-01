import 'package:flutter/material.dart';
import 'package:tcg_recorder/localization/message.dart';

class L10n {
  L10n(Locale locale) : message = Message.of(locale);

  final Message message;

  static Message of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n).message;
  }
}
