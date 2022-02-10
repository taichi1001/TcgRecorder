import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/state/record_sort_state.dart';

class RecordSortNotifier extends StateNotifier<RecordSortState> {
  RecordSortNotifier(this.read) : super(RecordSortState());

  final Reader read;

  changeSort(Sort sort) {
    state = state.copyWith(sort: sort);
  }

  changeOrder(Order order) {
    state = state.copyWith(order: order);
  }
}

final recordSortNotifierProvider = StateNotifierProvider<RecordSortNotifier, RecordSortState>(
  (ref) => RecordSortNotifier(ref.read),
);
