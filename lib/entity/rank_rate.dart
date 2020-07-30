import 'package:flutter/material.dart';

class RankRate with ChangeNotifier {
  int rankRateId;
  int recordId;
  int rank;
  int rate;

  RankRate({this.rankRateId, this.recordId, this.rank, this.rate = 1});

  factory RankRate.fromDatabaseJson(Map<String, dynamic> data) => RankRate(
        rankRateId: data['rank_rate_id'],
        recordId: data['record_id'],
        rank: data['rank'],
        rate: data['rate'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        'rank_rate_id': rankRateId,
        'record_id': recordId,
        'rank': rank,
        'rate': rate,
      };
}
