import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/repository/record_repository.dart';
import 'package:tcg_recorder2/state/record_list_state.dart';

class RecordListNotifier extends StateNotifier<RecordListState> {
  RecordListNotifier(this.read) : super(RecordListState());

  final Reader read;

  Future fetch() async {
    final recordList = await read(recordRepository).getAll();
    state = state.copyWith(allRecordList: recordList);
  }
}

final allRecordListNotifierProvider = StateNotifierProvider<RecordListNotifier, RecordListState>(
  (ref) => RecordListNotifier(ref.read),
);
