import 'package:tcg_manager/entity/marged_record.dart';
import 'package:csv/csv.dart';

class ListToCSV {
  static String margeRecordListToCSV(List<MargedRecord> list) {
    List<List<dynamic>> rows = [];
    List<dynamic> row = [];
    row.add('ゲーム');
    row.add('タグ');
    row.add('BO');
    row.add('使用デッキ');
    row.add('対戦相手デッキ');
    row.add('日付');
    row.add('先攻・後攻');
    row.add('1試合目 先攻・後攻');
    row.add('2試合目 先攻・後攻');
    row.add('3試合目 先攻・後攻');
    row.add('勝敗');
    row.add('1試合目 勝敗');
    row.add('2試合目 勝敗');
    row.add('3試合目 勝敗');
    row.add('メモ');
    rows.add(row);
    for (final margedRecord in list) {
      row = [];
      row.add(margedRecord.game);
      row.add(_stringListToJson(margedRecord.tag));
      row.add(margedRecord.bo.name);
      row.add(margedRecord.useDeck);
      row.add(margedRecord.opponentDeck);
      row.add(margedRecord.date);
      row.add(margedRecord.firstSecond.name);
      row.add(margedRecord.firstMatchFirstSecond?.name);
      row.add(margedRecord.secondMatchFirstSecond?.name);
      row.add(margedRecord.thirdMatchFirstSecond?.name);
      row.add(margedRecord.winLoss.name);
      row.add(margedRecord.firstMatchWinLoss?.name);
      row.add(margedRecord.secondMatchWinLoss?.name);
      row.add(margedRecord.thirdMatchWinLoss?.name);
      row.add(margedRecord.memo);
      rows.add(row);
    }
    return const ListToCsvConverter().convert(rows);
  }
}

String? _stringListToJson(List<String> values) {
  if (values.isEmpty) return null;
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
