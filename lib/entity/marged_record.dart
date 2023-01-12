import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/enum/bo.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';

part 'marged_record.freezed.dart';

@freezed
class MargedRecord with _$MargedRecord {
  factory MargedRecord({
    required int recordId,
    required String game,
    @Default('分類無し') String? tag,
    required BO bo,
    required String useDeck,
    required String opponentDeck,
    required DateTime date,
    required FirstSecond firstSecond,
    FirstSecond? firstMatchFirstSecond,
    FirstSecond? secondMatchFirstSecond,
    FirstSecond? thirdMatchFirstSecond,
    required WinLoss winLoss,
    WinLoss? firstMatchWinLoss,
    WinLoss? secondMatchWinLoss,
    WinLoss? thirdMatchWinLoss,
    String? memo,
    List<String>? imagePaths,
  }) = _MargedRecord;
}
