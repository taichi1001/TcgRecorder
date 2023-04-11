import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/enum/bo.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';

part 'record_old.freezed.dart';
part 'record_old.g.dart';

/// データベースVer3からVer4へのアップデート時にタグIDをintからStringに変更するために必要なエンティティ
@freezed
class RecordOld with _$RecordOld {
  factory RecordOld({
    int? recordId,
    int? gameId,
    int? tagId,
    int? useDeckId,
    int? opponentDeckId,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) DateTime? date,
    @Default(BO.bo1) @JsonKey(fromJson: _boFromJson, toJson: _boToJson) BO bo,
    @Default(FirstSecond.first) @JsonKey(fromJson: _firstSecondFromJson, toJson: _firstSecondToJson) FirstSecond firstSecond,
    @JsonKey(fromJson: _nullableFirstSecondFromJson, toJson: _nullableFirstSecondToJson) FirstSecond? firstMatchFirstSecond,
    @JsonKey(fromJson: _nullableFirstSecondFromJson, toJson: _nullableFirstSecondToJson) FirstSecond? secondMatchFirstSecond,
    @JsonKey(fromJson: _nullableFirstSecondFromJson, toJson: _nullableFirstSecondToJson) FirstSecond? thiredMatchFirstSecond,
    @Default(WinLoss.win) @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson) WinLoss winLoss,
    @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson) WinLoss? firstMatchWinLoss,
    @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson) WinLoss? secondMatchWinLoss,
    @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson) WinLoss? thirdMatchWinLoss,
    String? memo,
    @JsonKey(fromJson: _stringListFromJson, toJson: _stringListToJson) List<String>? imagePath,
  }) = _RecordOld;
  factory RecordOld.fromJson(Map<String, dynamic> json) => _$RecordOldFromJson(json);
}

FirstSecond _firstSecondFromJson(int value) {
  return value == 1 ? FirstSecond.first : FirstSecond.second;
}

int _firstSecondToJson(FirstSecond value) {
  return value == FirstSecond.first ? 1 : 0;
}

FirstSecond? _nullableFirstSecondFromJson(int? value) {
  if (value == null) return null;
  return value == 1 ? FirstSecond.first : FirstSecond.second;
}

int? _nullableFirstSecondToJson(FirstSecond? value) {
  if (value == null) return null;
  return value == FirstSecond.first ? 1 : 0;
}

WinLoss _winLossFromJson(int value) {
  switch (value) {
    case 0:
      return WinLoss.loss;
    case 1:
      return WinLoss.win;
    case 2:
      return WinLoss.draw;
    default:
      throw Exception();
  }
}

int _winLossToJson(WinLoss value) {
  switch (value) {
    case WinLoss.loss:
      return 0;
    case WinLoss.win:
      return 1;
    case WinLoss.draw:
      return 2;

    default:
      throw Exception();
  }
}

WinLoss? _nullableWinLossFromJson(int? value) {
  switch (value) {
    case 0:
      return WinLoss.loss;
    case 1:
      return WinLoss.win;
    case 2:
      return WinLoss.draw;
    default:
      return null;
  }
}

int? _nullableWinLossToJson(WinLoss? value) {
  switch (value) {
    case WinLoss.loss:
      return 0;
    case WinLoss.win:
      return 1;
    case WinLoss.draw:
      return 2;
    default:
      return null;
  }
}

BO _boFromJson(int value) {
  switch (value) {
    case 0:
      return BO.bo1;
    case 1:
      return BO.bo3;
    default:
      throw Exception();
  }
}

int _boToJson(BO value) {
  switch (value) {
    case BO.bo1:
      return 0;
    case BO.bo3:
      return 1;
    default:
      throw Exception();
  }
}

DateTime _dateTimeFromJson(String value) {
  return DateTime.parse(value).toLocal();
}

String _dateTimeToJson(DateTime? value) {
  if (value == null) {
    return DateTime.now().toUtc().toIso8601String();
  }
  return value.toUtc().toIso8601String();
}

List<String>? _stringListFromJson(String? value) {
  if (value == null) return null;
  return value.split(',');
}

String? _stringListToJson(List<String>? values) {
  if (values == null || values.isEmpty) return null;
  var result = '';
  var count = 0;
  for (final value in values) {
    if (count == 0) {
      // ignore: unnecessary_string_interpolations
      result = value;
    } else {
      result = '$result,$value';
    }
    count++;
  }
  return result;
}
