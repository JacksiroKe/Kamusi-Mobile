import 'package:sqflite/sqflite.dart';

import '../data/app_database.dart';
import '../data/asset_database.dart';
import '../utils/strings/app_strings.dart';
import '../utils/strings/db_strings.dart';
import 'callbacks/ItemCallback.dart';
import 'callbacks/WordCallback.dart';
import 'models/item.dart';
import 'models/word.dart';

AppDatabase appDB = AppDatabase();
AssetDatabase assetDB = AssetDatabase();

List<WordCallback> words = [];
List<ItemCallback> idiomsList = [], sayingsList = [], proverbsList = [];

late Future<Database> dbAssets, dbFuture;

void requestAssetData() async {
  dbAssets = assetDB.initializeDatabase();
  dbAssets.then((database) {
    Future<List<WordCallback>> wordListAsset = assetDB.getWordList();
    wordListAsset.then((itemsList) {
      words = itemsList;
      requestIdiomsData();
    });
  });
}

void requestIdiomsData() async {
  dbAssets = assetDB.initializeDatabase();
  dbAssets.then((database) {
    Future<List<ItemCallback>> idiomsListAsset =
        assetDB.getItemList(DbStrings.idiomsTable);
    idiomsListAsset.then((itemsList) {
      idiomsList = itemsList;
      requestSayingsData();
    });
  });
}

void requestSayingsData() async {
  dbAssets = assetDB.initializeDatabase();
  dbAssets.then((database) {
    Future<List<ItemCallback>> sayingsListAsset =
        assetDB.getItemList(DbStrings.sayingsTable);
    sayingsListAsset.then((itemsList) {
      sayingsList = itemsList;
      requestProverbsData();
    });
  });
}

void requestProverbsData() async {
  dbAssets = assetDB.initializeDatabase();
  dbAssets.then((database) {
    Future<List<ItemCallback>> proverbsListAsset =
        assetDB.getItemList(DbStrings.proverbsTable);
    proverbsListAsset.then((itemsList) {
      proverbsList = itemsList;
      _goToNextScreen();
    });
  });
}

Future<void> saveWordsData() async {
  for (int i = 0; i < words.length; i++) {
    WordCallback? item = words[i];

    Word? word =
        new Word(item.title, item.meaning, item.synonyms, item.conjugation);

    await appDB.insertWord(word);
  }
}

Future<void> saveItemData(
    String type, String table, List<ItemCallback> itemlist) async {
  for (int i = 0; i < itemlist.length; i++) {
    ItemCallback itemCallBack = itemlist[i];

    Item item = new Item(
        itemCallBack.title, itemCallBack.meaning, itemCallBack.synonyms);

    await appDB.insertItem(table, item);
  }
}

Future<void> _goToNextScreen() async {
  await saveWordsData();
  await saveItemData(AppStrings.idioms, DbStrings.idiomsTable, idiomsList);
  await saveItemData(AppStrings.sayings, DbStrings.sayingsTable, sayingsList);
  await saveItemData(
      AppStrings.proverbs, DbStrings.proverbsTable, proverbsList);
}
