// This file declares functions that manages the database that is created in the app
// when the app is installed for the first time

import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../data/models/models.dart';
import '../utils/strings/strings.dart';

class AppDatabase {
  static AppDatabase? sqliteHelper; // Singleton DatabaseHelper
  static Database? appDb; // Singleton Database

  AppDatabase._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory AppDatabase() {
    if (sqliteHelper == null) {
      sqliteHelper = AppDatabase
          ._createInstance(); // This is executed only once, singleton object
    }
    return sqliteHelper!;
  }

  Future<Database> get database async {
    if (appDb == null) {
      appDb = await initializeDatabase();
    }
    return appDb!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory docsDirectory = await getApplicationDocumentsDirectory();
    String path = join(docsDirectory.path, "KiswahiliKitukuzwe.db");

    // Open/create the database at a given path
    var vsbDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return vsbDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(DbQueries.createWordsHistoryTable);
    await db.execute(DbQueries.createIdiomsTable);
    await db.execute(DbQueries.createProverbsTable);
    await db.execute(DbQueries.createSayingsTable);
    await db.execute(DbQueries.createWordsSearchTable);
    await db.execute(DbQueries.createWordsTable);

    await db.execute(DbQueries.createTriviaTable);
    await db.execute(DbQueries.createTriviaAttemptTable);
  }

  Future<void> additionalTables() async {
    Database db = await this.database;
    await db.rawQuery(DbQueries.createTriviaTable);
    await db.rawQuery(DbQueries.createTriviaAttemptTable);
  }

  Future<int> insertWord(Word item) async {
    Database db = await this.database;
    item.isfav = item.views = 0;

    var result = await db.insert(DbStrings.wordsTable, item.toMap());
    return result;
  }

  Future<int> favouriteWord(Word item, bool isFavorited) async {
    var db = await this.database;
    if (isFavorited)
      item.isfav = 1;
    else
      item.isfav = 0;
    String sqlQuery = 'UPDATE ' + DbStrings.wordsTable + ' SET ';
    sqlQuery = sqlQuery + DbStrings.isfav + '="' + item.isfav.toString() + '"';
    sqlQuery = sqlQuery + ', ' + DbStrings.updated + '="' + datetimeNow() + '"';
    sqlQuery = sqlQuery + ' WHERE ' + DbStrings.id + '=' + item.id.toString();

    var result = await db.rawUpdate(sqlQuery);
    print(sqlQuery);
    print(result.toString());
    return result;
  }

  Future<int> getWordCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from ' + DbStrings.wordsTable);
    int? result = Sqflite.firstIntValue(x);
    return result!;
  }

  Future<List<Map<String, dynamic>>?> getItemMapList(String table) async {
    try {
      Database db = await this.database;
      List<Map<String, dynamic>> x =
          await db.rawQuery('SELECT COUNT (*) from ' + table);
      int? counts = Sqflite.firstIntValue(x);
      print("Counts: " + counts.toString());
      var result = db.query(table);
      return result;
    } catch (e) {
      print("Error: " + e.toString());
      return null;
    }
  }

  Future<int> insertItem(String table, Item item) async {
    Database db = await this.database;
    item.isfav = item.views = 0;

    var result = await db.insert(table, item.toMap());
    return result;
  }

  Future<List<Item>> getItemList(String table) async {
    var itemMapList = await getItemMapList(table);
    List<Item> itemList = [];
    for (int i = 0; i < itemMapList!.length; i++) {
      itemList.add(
        Item.fromMapObject(itemMapList[i]),
      );
    }
    return itemList;
  }

  Future<List<Map<String, dynamic>>> getItemSearchMapLists(
      String searchString, String table) async {
    Database db = await this.database;
    String sqlQuery = DbStrings.title + ' LIKE "$searchString%"';

    var result = db.query(table, where: sqlQuery);
    return result;
  }

  Future<List<Map<String, dynamic>>> getItemSearchMapList(
      String searchString, String table, bool searchByTitle) async {
    Database db = await this.database;
    String sqlQuery = DbStrings.title + " LIKE '$searchString%'";

    if (!searchByTitle)
      sqlQuery =
          sqlQuery + " OR " + DbStrings.meaning + " LIKE '$searchString%'";

    var result = db.query(table, where: sqlQuery);
    return result;
  }

  Future<List<Item>> getItemSearch(
      String searchString, String table, bool searchByTitle) async {
    var itemMapList =
        await getItemSearchMapList(searchString, table, searchByTitle);

    List<Item> itemList = [];

    for (int i = 0; i < itemMapList.length; i++) {
      itemList.add(
        Item.fromMapObject(itemMapList[i]),
      );
    }
    return itemList;
  }

  Future<List<Map<String, dynamic>>> getWordMapList() async {
    Database db = await this.database;
    var result = db.query(DbStrings.wordsTable);
    return result;
  }

  Future<List<Word>> getWordList() async {
    var itemMapList = await getWordMapList();
    List<Word> itemList = [];
    for (int i = 0; i < itemMapList.length; i++) {
      itemList.add(
        Word.fromMapObject(itemMapList[i]),
      );
    }
    return itemList;
  }

  Future<List<Map<String, dynamic>>> getSpecificWordMapList(
      String searchString) async {
    Database db = await this.database;
    var result = db.query(DbStrings.wordsTable,
        where: DbStrings.title + " = '$searchString'");
    return result;
  }

  Future<Word?> getSpecificWord(String searchString) async {
    var itemMapList = await getSpecificWordMapList(searchString);

    List<Word> itemList = [];

    for (int i = 0; i < itemMapList.length; i++) {
      itemList.add(
        Word.fromMapObject(itemMapList[i]),
      );
    }
    if (itemList.isNotEmpty)
      return itemList[0];
    else
      return null;
  }

  Future<List<Map<String, dynamic>>> getWordSearchMapList(
      String searchString, bool searchByTitle) async {
    Database db = await this.database;
    String sqlQuery = DbStrings.title + " LIKE '$searchString%'";

    if (!searchByTitle)
      sqlQuery =
          sqlQuery + " OR " + DbStrings.meaning + " LIKE '$searchString%'";

    var result = db.query(DbStrings.wordsTable, where: sqlQuery);
    return result;
  }

  Future<List<Word>> getWordSearch(
      String searchString, bool searchByTitle) async {
    var itemMapList = await getWordSearchMapList(searchString, searchByTitle);

    List<Word> itemList = [];

    for (int i = 0; i < itemMapList.length; i++) {
      itemList.add(
        Word.fromMapObject(itemMapList[i]),
      );
    }
    return itemList;
  }

  Future<List<Map<String, dynamic>>> getFavoritesList() async {
    Database db = await this.database;
    var result = db.query(DbStrings.wordsTable, where: DbStrings.isfav + "=1");
    return result;
  }

  Future<List<Word>> getFavorites() async {
    var itemMapList = await getFavoritesList();

    List<Word> itemList = [];
    for (int i = 0; i < itemMapList.length; i++) {
      itemList.add(
        Word.fromMapObject(itemMapList[i]),
      );
    }

    return itemList;
  }

  Future<List<Map<String, dynamic>>> getFavSearchMapList(
      String searchString) async {
    Database db = await this.database;
    String extraQuery = 'AND ' + DbStrings.isfav + "=1 ";
    String sqlQuery = DbStrings.title +
        ' LIKE "$searchString%" $extraQuery OR ' +
        DbStrings.meaning +
        ' LIKE "$searchString%" $extraQuery';

    var result = db.query(DbStrings.wordsTable, where: sqlQuery);
    return result;
  }

  Future<List<Word>> getFavSearch(String searchString) async {
    var itemMapList = await getFavSearchMapList(searchString);

    List<Word> itemList = [];

    for (int i = 0; i < itemMapList.length; i++) {
      itemList.add(
        Word.fromMapObject(itemMapList[i]),
      );
    }
    return itemList;
  }

  Future<int> insertWordHistory(int wordid) async {
    Database db = await this.database;

    WordHistory history = new WordHistory(wordid, datetimeNow());

    var result = await db.insert(DbStrings.wordsHistoryTable, history.toMap());
    return result;
  }

  Future<List<Map<String, dynamic>>> getHistoriesList() async {
    Database db = await this.database;
    var result = db.rawQuery(DbQueries.queryWordsHistory);
    return result;
  }

  Future<List<Word>> getHistories() async {
    var itemMapList = await getHistoriesList();

    List<Word> itemList = [];
    for (int i = 0; i < itemMapList.length; i++) {
      itemList.add(
        Word.fromMapObject(itemMapList[i]),
      );
    }

    return itemList;
  }

  Future<int> insertWordSearch(int wordid) async {
    Database db = await this.database;
    WordSearch search = new WordSearch(wordid, datetimeNow());

    var result = await db.insert(DbStrings.wordsSearchTable, search.toMap());
    return result;
  }

  Future<List<Map<String, dynamic>>> getSearchesList() async {
    Database db = await this.database;
    var result = db.rawQuery(DbQueries.queryWordsSearch);
    return result;
  }

  Future<List<Word>> getSearches() async {
    var itemMapList = await getSearchesList();

    List<Word> itemList = [];
    for (int i = 0; i < itemMapList.length; i++) {
      itemList.add(
        Word.fromMapObject(itemMapList[i]),
      );
    }

    return itemList;
  }

  Future<int> insertTrivia(Trivia trivia) async {
    Database db = await this.database;
    var result = await db.rawInsert('INSERT INTO ' +
        DbStrings.triviaTable +
        '(' +
        DbStrings.category +
        ', ' +
        DbStrings.description +
        ', ' +
        DbStrings.questions +
        ', ' +
        DbStrings.level +
        ') VALUES(' +
        trivia.category.toString() +
        ', "' +
        trivia.description +
        '", "' +
        trivia.questions.toString() +
        '", "' +
        trivia.level.toString() +
        '")');
    return result;
  }

  Future<List<Map<String, dynamic>>> getTriviaMapList() async {
    Database db = await this.database;
    var result = db.query(DbStrings.triviaTable);
    return result;
  }

  Future<List<Trivia>> getTriviaList() async {
    var itemMapList = await getTriviaMapList();
    List<Trivia> itemList = [];
    for (int i = 0; i < itemMapList.length; i++) {
      itemList.add(
        Trivia.fromMapObject(itemMapList[i]),
      );
    }
    return itemList;
  }

  Future<List<Map<String, dynamic>>> getTriviaByIdList(int itemID) async {
    Database db = await this.database;
    var result = db.query(DbStrings.triviaTable,
        where: DbStrings.id + '=' + itemID.toString());
    return result;
  }

  Future<Trivia> getTriviaById(int itemID) async {
    var itemMapList = await getTriviaByIdList(itemID);

    List<Trivia> itemList = [];
    for (int i = 0; i < itemMapList.length; i++) {
      itemList.add(
        Trivia.fromMapObject(itemMapList[i]),
      );
    }
    return itemList[0];
  }

  Future<List<Map<String, dynamic>>> getTriviaEntryMapList(
      String wordids) async {
    Database db = await this.database;
    String sqlQuery = DbStrings.id + " IN ($wordids)";

    var result = db.query(DbStrings.wordsTable, where: sqlQuery);
    return result;
  }

  Future<List<TriviaQuiz>> getTriviaEntries(
      String level, String wordids) async {
    var itemMapList = await getTriviaEntryMapList(wordids);

    List<TriviaQuiz> itemList = [];

    for (int i = 0; i < itemMapList.length; i++) {
      String correctAnswer = itemMapList[i]['title'];
      var fullQuestion = itemMapList[i]['meaning'].split("|");

      String defect = correctAnswer.substring(0, 2);
      List<Word> alternatives = await getWordSearch(defect, true);
      alternatives.toSet().toList();
      alternatives.shuffle();

      TriviaQuiz quiz = new TriviaQuiz();
      /*quiz.type =
          itemMapList[i]["type"] == "multiple" ? Type.multiple : Type.boolean;
      quiz.level = itemMapList[i]["level"] == "easy"
          ? Level.easy
          : itemMapList[i]["level"] == "medium"
              ? Level.medium
              : Level.hard;
      quiz.question = fullQuestion[0];*/
      quiz.answer = correctAnswer;
      quiz.options = [];

      quiz.options!.add(correctAnswer);

      quiz.options!.add(alternatives[0].title);

      if (alternatives.length > 2) {
        quiz.options!.add(alternatives[1].title);
      }

      if (alternatives.length > 3) {
        quiz.options!.add(alternatives[2].title);
      }

      quiz.options!.shuffle();

      itemList.add(quiz);
    }
    itemList.shuffle();
    return itemList;
  }
}
