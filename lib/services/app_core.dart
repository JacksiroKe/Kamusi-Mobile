import 'package:kamusi/utils/strings/strings.dart';

import 'cache_helper.dart';

class AppCore {
  static DateTime _now() => DateTime.now();
  static int _deadLine() => _now().millisecondsSinceEpoch;

  static Future<DateTime> getTriviaTrialDeadline() async {
    int? deadline =
        await CacheHelper.getPrefInt(SharedPrefKeys.triviaSubscriptionDeadline);

    if (deadline == null) {
      await saveTriviaTrialDeadline();
      deadline = _deadLine();
    }
    return DateTime.fromMillisecondsSinceEpoch(deadline);
  }

  static Future<void> saveTriviaTrialDeadline() async {
    await CacheHelper.setPrefInt(SharedPrefKeys.triviaSubscriptionDeadline, _deadLine());
  }

  static Future<bool> isTriviaTrialDeadlineMet() async {
    DateTime deadline = await getTriviaTrialDeadline();
    return _now().isAfter(deadline);
  }
}
