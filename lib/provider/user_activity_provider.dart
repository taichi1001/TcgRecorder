import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tcg_manager/service/isar.dart';

part 'user_activity_provider.g.dart';

@collection
class UserActivityLog {
  @Id()
  int id = 1;
  late int totalRecordCount;
  late DateTime installDate;
  late DateTime lastLogin;
  late int totalLoginDays;
  DateTime? reviewdAt;
  DateTime? dissatisfactionChosenAt;
  DateTime? answerLaterChosenAt;
  DateTime? showPremiumFeaturesAdAt;
}

@Riverpod(keepAlive: true)
class UserActivityLogNotifier extends _$UserActivityLogNotifier {
  @override
  UserActivityLog build() {
    final isar = ref.watch(isarProvider);

    //　変更を監視
    isar.userActivityLogs.where().watch().listen((event) {
      final count = event.first;
      state = count;
    });

    final log = isar.userActivityLogs.where().findFirst();
    if (log != null) {
      return log;
    } else {
      return UserActivityLog()
        ..totalRecordCount = 0
        ..installDate = DateTime.now()
        ..lastLogin = DateTime.now()
        ..totalLoginDays = 1;
    }
  }

  bool _isDifferentDate(DateTime pastDate) {
    DateTime now = DateTime.now();

    // 日付が変わる時刻を午前5時に設定するため、現在の時間が午前5時未満の場合、日付を1日減らす
    if (now.hour < 5) {
      now = now.subtract(const Duration(days: 1));
    }

    // 過去の日付も同様に処理
    if (pastDate.hour < 5) {
      pastDate = pastDate.subtract(const Duration(days: 1));
    }

    // 年、月、日が同じかどうかを比較
    return now.year != pastDate.year || now.month != pastDate.month || now.day != pastDate.day;
  }

  bool _isNDaysPassed(DateTime? pastDateTime, int N) {
    if (pastDateTime == null) return true;
    DateTime now = DateTime.now();
    DateTime nDaysAgo = now.subtract(Duration(days: N));

    // 指定された日時がN日前の日時よりも前であれば、N日経過していると判定
    return pastDateTime.isBefore(nDaysAgo);
  }

  void login() {
    final isar = ref.read(isarProvider);
    isar.write(
      (isar) => isar.userActivityLogs.put(
        state
          ..totalLoginDays = _isDifferentDate(state.lastLogin) ? state.totalLoginDays + 1 : state.totalLoginDays
          ..lastLogin = DateTime.now(),
      ),
    );
  }

  void record() {
    final isar = ref.read(isarProvider);
    isar.write(
      (isar) => isar.userActivityLogs.put(
        state..totalRecordCount = state.totalRecordCount + 1,
      ),
    );
  }

  /// レビューするを選んだ時
  void choseReview() {
    final isar = ref.read(isarProvider);
    isar.write((isar) => isar.userActivityLogs.put(state..reviewdAt = DateTime.now()));
  }

  /// 後で回答するを選んだ時
  void choseAnswerLater() {
    final isar = ref.read(isarProvider);
    isar.write((isar) => isar.userActivityLogs.put(state..answerLaterChosenAt = DateTime.now()));
  }

  /// 不満があるを選んだ時
  void choseDissatisfaction() {
    final isar = ref.read(isarProvider);
    isar.write((isar) => isar.userActivityLogs.put(state..dissatisfactionChosenAt = DateTime.now()));
  }

  /// プレミアムプランを広告で解放したとき
  void showPremiumFeaturesAd() {
    final isar = ref.read(isarProvider);
    isar.write((isar) => isar.userActivityLogs.put(state..showPremiumFeaturesAdAt = DateTime.now()));
  }

  /// プレミアムプランへアクセスできるかどうかの判定
  bool canAccessPremiumFeatures() {
    if (state.showPremiumFeaturesAdAt == null) return false;
    final difference = state.showPremiumFeaturesAdAt!.difference(DateTime.now()).abs();
    return difference.inMinutes <= 60;
  }

  /// レビュー催促ダイアログの表示判定
  bool shouldShowReviewDialog() {
    if (state.totalLoginDays >= 5 &&
        state.totalRecordCount > 30 &&
        _isNDaysPassed(state.answerLaterChosenAt, 7) &&
        _isNDaysPassed(state.dissatisfactionChosenAt, 180) &&
        _isNDaysPassed(state.reviewdAt, 365)) return true;
    return false;
  }
}
