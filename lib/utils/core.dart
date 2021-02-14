import 'preferences.dart';
import 'app_utils.dart';

class AppCore {
  static DateTime _now() => DateTime.now();
  static int _deadLine() => _now().millisecondsSinceEpoch;

  static Future<DateTime> getTriviaTrialDeadline() async {
    int deadline = await Preferences.getSharedPreferenceInt(
        SharedPreferenceKeys.triviaSubscriptionDeadline);

    if (deadline == null) {
      await saveTriviaTrialDeadline();
      deadline = _deadLine();
    }
    return DateTime.fromMillisecondsSinceEpoch(deadline);
  }

  static Future<void> saveTriviaTrialDeadline() async {
    Preferences.setSharedPreferenceInt(
        SharedPreferenceKeys.triviaSubscriptionDeadline, _deadLine());
  }

  static Future<bool> isTriviaTrialDeadlineMet() async {
    DateTime deadline = await getTriviaTrialDeadline();
    return _now().isAfter(deadline);
  }
}
