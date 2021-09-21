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
