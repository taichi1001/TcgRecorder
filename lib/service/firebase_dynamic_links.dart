import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

final firebaseDynamicLinksProvider = Provider<FirebaseDynamicLinks>((ref) => FirebaseDynamicLinks.instance);
