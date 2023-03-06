import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/repository/firestore_config_repository.dart';

final requiredVersionProvider = FutureProvider<String>(
  (ref) async {
    final config = await ref.read(firestoreConfigRepository).getAll();
    return Platform.isIOS ? config.ios : config.android;
  },
);
