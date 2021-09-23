import 'package:intl/intl.dart';

import 'app_strings.dart';
import 'db_strings.dart';

String datetimeReadable() {
  DateTime now = DateTime.now();
  return DateFormat('y-M-d kk:mm:ss').format(now);
}

String datetimeNow() {
  var datetimenow = DateTime.now().millisecondsSinceEpoch;
  return datetimenow.toString();
}

String timeAgo(int input) {
  var date = DateTime.fromMillisecondsSinceEpoch(input);
  Duration diff = DateTime.now().difference(date);

  if (diff.inDays >= 1) {
    if (diff.inDays <= 2) {
      return 'Jana\n' + DateFormat('kk:mm').format(date);
    } else
      return DateFormat('MMM d\ny').format(date);
  } else {
    if (diff.inHours >= 1) {
      return 'Saa\n${diff.inHours}';
    } else if (diff.inMinutes >= 1) {
      return 'Dakika\n${diff.inMinutes}';
    } else if (diff.inSeconds >= 1) {
      return 'Sekunde\n${diff.inSeconds}';
    } else {
      return 'Hivi\nsasa';
    }
  }
}

final searchFilters = [
  AppStrings.words,
  AppStrings.idioms,
  AppStrings.sayings,
  AppStrings.proverbs
];
final searchFiltersTable = [
  DbStrings.wordsTable,
  DbStrings.idiomsTable,
  DbStrings.sayingsTable,
  DbStrings.proverbsTable
];

final personalFilters = [
  AppStrings.history,
  AppStrings.favorites,
  AppStrings.searches
];

final triviaFilters = [
  AppStrings.categories,
  AppStrings.leaderboard,
  AppStrings.settings
];

final List<String> letters = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'Y',
  'Z'
];
