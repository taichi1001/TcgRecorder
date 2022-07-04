import 'package:flutter/cupertino.dart';
import 'package:tcg_manager/enum/sort.dart';
import 'package:tcg_manager/generated/l10n.dart';

class ConvertSortString {
  static String convert(BuildContext context, Sort sort) {
    if (sort == Sort.newest) {
      return S.of(context).newest;
    } else if (sort == Sort.oldest) {
      return S.of(context).oldest;
    } else if (sort == Sort.custom) {
      return 'カスタム順';
    } else {
      return 'エラー';
    }
  }
}
