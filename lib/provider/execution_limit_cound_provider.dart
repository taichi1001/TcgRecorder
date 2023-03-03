import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tcg_manager/main.dart';

final executionCountProvider = StateNotifierProvider.autoDispose<ExecutionCountNotifier, int>((ref) => ExecutionCountNotifier(ref));

final canExecuteProvider = Provider.autoDispose<bool>((ref) {
  final executionCount = ref.watch(executionCountProvider);
  if (executionCount < 3) {
    return true;
  } else {
    return false;
  }
});

class ExecutionCountNotifier extends StateNotifier<int> {
  ExecutionCountNotifier(this.ref) : super(0) {
    _loadState();
  }

  final Ref ref;
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  Future increment() async {
    state++;
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setInt('executionCount', state);
    await prefs.setString('lastExecutedAt', dateFormat.format(DateTime.now()).toString());
    _loadState();
  }

  void reset() {
    state = 0;
    final prefs = ref.read(sharedPreferencesProvider);
    prefs.setInt('executionCount', state);
  }

  void _loadState() {
    final prefs = ref.read(sharedPreferencesProvider);
    final count = prefs.getInt('executionCount');
    final lastExecutedAt = prefs.getString('lastExecutedAt');
    if (count != null) {
      state = count;
    }
    if (lastExecutedAt != null) {
      final lastExecutedDateTime = DateTime.parse(lastExecutedAt);
      final today = DateTime.parse(dateFormat.format(DateTime.now()));
      if (today.difference(lastExecutedDateTime).inDays > 0) {
        reset();
      }
    } else {
      reset();
    }
  }
}
