import 'preferences.dart';
import 'app_utils.dart';

class AppCore {
  static DateTime _now() => DateTime.now();

  static Future<DateTime> getTriviaTrialDeadline() async {
    int deadline = await Preferences.getSharedPreferenceInt(SharedPreferenceKeys.triviaSubscriptionMode);    
    return DateTime.fromMillisecondsSinceEpoch(deadline ?? _now().millisecondsSinceEpoch);
  }
  
  static Future<void> saveTriviaTrialDeadline() async {
    int deadline = _now().millisecondsSinceEpoch;
    Preferences.setSharedPreferenceInt(SharedPreferenceKeys.triviaSubscriptionDeadline, deadline);
  }

  static Future<bool> isTriviaTrialDeadlineMet() async {
    DateTime deadline = await getTriviaTrialDeadline();
    return _now().isAfter(deadline);
  }

}