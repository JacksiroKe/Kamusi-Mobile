/// General database strings
class DbStrings {
  static const String wordsTable = 'words';
  static const String idiomsTable = 'idioms';
  static const String sayingsTable = 'sayings';
  static const String proverbsTable = 'proverbs';
  static const String searchesTable = 'searches';
  static const String historyTable = 'history';
  static const String triviaTable = 'my_trivia';
  static const String attemptsTable = 'my_attempts';

  static const String id = 'id';
  static const String trivia = 'trivia';
  static const String wordid = 'wordid';
  static const String wordids = 'wordids';
  static const String triviaid = 'triviaid';
  static const String categoryid = 'categoryid';
  static const String created = 'created';
  static const String title = 'title';
  static const String meaning = 'meaning';
  static const String synonyms = 'synonyms';
  static const String conjugation = 'conjugation';
  static const String description = 'description';
  static const String isfav = 'isfav';
  static const String views = 'views';
  static const String notes = 'notes';

  static const String progress = 'progress';
  static const String time = 'time';
  static const String category = 'category';
  static const String level = 'level';
  static const String questions = 'questions';
  static const String score = 'score';
}

/// Strings used in the database queries
class Queries {
  /// Query string for creating the searches table
  static const String createHistoryTable = 'CREATE TABLE IF NOT EXISTS ' +
      DbStrings.historyTable +
      '(' +
      DbStrings.id +
      ' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ' +
      DbStrings.wordid +
      ' INTEGER NOT NULL DEFAULT 0, ' +
      DbStrings.created +
      ' VARCHAR(20) NOT NULL DEFAULT ""' +
      ');';

  /// Query string for creating the idioms table
  static const String createIdiomsTable = 'CREATE TABLE IF NOT EXISTS ' +
      DbStrings.idiomsTable +
      '(' +
      DbStrings.id +
      ' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ' +
      DbStrings.title +
      ' VARCHAR(100) NOT NULL DEFAULT "", ' +
      DbStrings.meaning +
      ' VARCHAR(500) NOT NULL DEFAULT "", ' +
      DbStrings.synonyms +
      ' VARCHAR(500) NOT NULL DEFAULT "", ' +
      DbStrings.notes +
      ' VARCHAR(500) NOT NULL DEFAULT "", ' +
      DbStrings.isfav +
      ' INTEGER NOT NULL DEFAULT 0, ' +
      DbStrings.views +
      ' INTEGER NOT NULL DEFAULT 0' +
      ');';

  /// Query string for creating the proverbs table
  static const String createProverbsTable = 'CREATE TABLE IF NOT EXISTS ' +
      DbStrings.proverbsTable +
      '(' +
      DbStrings.id +
      ' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ' +
      DbStrings.title +
      ' VARCHAR(100) NOT NULL DEFAULT "", ' +
      DbStrings.meaning +
      ' VARCHAR(500) NOT NULL DEFAULT "", ' +
      DbStrings.synonyms +
      ' VARCHAR(500) NOT NULL DEFAULT "", ' +
      DbStrings.notes +
      ' VARCHAR(500) NOT NULL DEFAULT "", ' +
      DbStrings.isfav +
      ' INTEGER NOT NULL DEFAULT 0, ' +
      DbStrings.views +
      ' INTEGER NOT NULL DEFAULT 0' +
      ');';

  /// Query string for creating the sayings table
  static const String createSayingsTable = 'CREATE TABLE IF NOT EXISTS ' +
      DbStrings.sayingsTable +
      '(' +
      DbStrings.id +
      ' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ' +
      DbStrings.title +
      ' VARCHAR(100) NOT NULL DEFAULT "", ' +
      DbStrings.meaning +
      ' VARCHAR(500) NOT NULL DEFAULT "", ' +
      DbStrings.synonyms +
      ' VARCHAR(500) NOT NULL DEFAULT "", ' +
      DbStrings.notes +
      ' VARCHAR(500) NOT NULL DEFAULT "", ' +
      DbStrings.isfav +
      ' INTEGER NOT NULL DEFAULT 0, ' +
      DbStrings.views +
      ' INTEGER NOT NULL DEFAULT 0' +
      ');';

  /// Query string for creating the searches table
  static const String createSearchesTable = 'CREATE TABLE IF NOT EXISTS ' +
      DbStrings.searchesTable +
      '(' +
      DbStrings.id +
      ' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ' +
      DbStrings.wordid +
      ' INTEGER NOT NULL DEFAULT 0, ' +
      DbStrings.created +
      ' VARCHAR(20) NOT NULL DEFAULT ""' +
      ');';

  /// Query string for creating the words table
  static const String createWordsTable = 'CREATE TABLE IF NOT EXISTS ' +
      DbStrings.wordsTable +
      '(' +
      DbStrings.id +
      ' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ' +
      DbStrings.title +
      ' VARCHAR(100) NOT NULL DEFAULT "", ' +
      DbStrings.meaning +
      ' VARCHAR(300) NOT NULL DEFAULT "", ' +
      DbStrings.synonyms +
      ' VARCHAR(100) NOT NULL DEFAULT "", ' +
      DbStrings.conjugation +
      ' VARCHAR(100) NOT NULL DEFAULT "",' +
      DbStrings.notes +
      ' VARCHAR(500) NOT NULL DEFAULT "", ' +
      DbStrings.isfav +
      ' INTEGER NOT NULL DEFAULT 0, ' +
      DbStrings.views +
      ' INTEGER NOT NULL DEFAULT 0' +
      ');';

  /// Query string for creating the trivia table
  static const String createTriviaTable = 'CREATE TABLE IF NOT EXISTS ' +
      DbStrings.triviaTable +
      '(' +
      DbStrings.id +
      ' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ' +
      DbStrings.triviaid +
      ' INTEGER NOT NULL DEFAULT 0, ' +
      DbStrings.category +
      ' INTEGER NOT NULL DEFAULT 0, ' +
      DbStrings.description +
      ' VARCHAR(100) NOT NULL DEFAULT "", ' +
      DbStrings.questions +
      ' VARCHAR(1000) NOT NULL DEFAULT "", ' +
      DbStrings.level +
      ' VARCHAR(20) NOT NULL DEFAULT "", ' +
      DbStrings.score +
      ' INTEGER NOT NULL DEFAULT 0, ' +
      DbStrings.time +
      ' VARCHAR(20) NOT NULL DEFAULT "", ' +
      DbStrings.created +
      ' VARCHAR(20) NOT NULL DEFAULT ""' +
      ');';

  /// Query string for creating the trivia table
  static const String createTriviaAttemptTable = 'CREATE TABLE IF NOT EXISTS ' +
      DbStrings.attemptsTable +
      '(' +
      DbStrings.id +
      ' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ' +
      DbStrings.trivia +
      ' INTEGER NOT NULL DEFAULT 0, ' +
      DbStrings.progress +
      ' INTEGER NOT NULL DEFAULT 0, ' +
      DbStrings.time +
      ' VARCHAR(20) NOT NULL DEFAULT "", ' +
      DbStrings.created +
      ' VARCHAR(20) NOT NULL DEFAULT ""' +
      ');';
}
