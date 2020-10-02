import 'package:flutter/material.dart';
import 'package:tcg_recorder/localization/l10n.dart';

class SampleLocalizationsDelegate extends LocalizationsDelegate<L10n> {
  const SampleLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ja'].contains(locale.languageCode);

  @override
  Future<L10n> load(Locale locale) async => L10n(locale);

  @override
  bool shouldReload(SampleLocalizationsDelegate old) => false;
}
