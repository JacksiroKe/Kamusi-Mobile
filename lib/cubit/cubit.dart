import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovebeta/utils/strings/app_strings.dart';
import 'package:moovebeta/utils/strings/db_strings.dart';
import 'package:sqflite/sqflite.dart';

import '../cubit/states.dart';
import '../data/app_database.dart';
import '../data/asset_database.dart';
import '../data/callbacks/ItemCallback.dart';
import '../data/callbacks/WordCallback.dart';
import '../data/models/item.dart';
import '../data/models/word.dart';
import '../ui/home/search/search.dart';
import '../ui/home/trivia/trivia_tab.dart';
import '../ui/home/user/user_tab.dart';
import '../utils/app_variables.dart';

class KamusiCubit extends Cubit<AppStates> {
  KamusiCubit() : super(AppInitialState());

  static KamusiCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> tabScreens = [
    SearchTab(),
    TriviaTab(),
    UserTab(),
  ];

  AppDatabase appDB = AppDatabase();
  AssetDatabase assetDB = AssetDatabase();
  late Future<Database> dbAssets, dbFuture;

  List<Word> searchList = [], words = [];
  List<Item> items = [];
  late String letterSearch;

  List toggles = List.generate(filters.length, (index) => false);
  String activeFilter = filters[0], activeTable = filtersTable[0];

  void changeBottom(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  void onFilterFocus(bool focus, String filter) {
    toggles[filters.indexOf(filter)] = focus;
  }

  Future<void> loadHomeWordList() async {
    emit(AppLoadingHomeDataState());
    dbFuture = appDB.initializeDatabase();

    dbFuture.then((database) {
      Future<List<Word>> wordsListFuture = appDB.getWordList();
      wordsListFuture.then((resultList) {
        words = resultList;
        emit(AppSuccessHomeDataState());
      });
    });
  }

  void loadHomeListView() {
    emit(AppLoadingHomeDataState());
    words.clear();
    items.clear();
    dbFuture = appDB.initializeDatabase();

    if (activeTable == filtersTable[0]) {
      dbFuture.then((database) {
        Future<List<Word>> wordsListFuture = appDB.getWordList();
        wordsListFuture.then((resultList) {
          if (searchList.isEmpty)
            searchList = words = resultList;
          else
            words = resultList;
          emit(AppSuccessHomeDataState());
          if (words.length == 0) emit(AppErrorHomeDataState());
        });
      });
    } else {
      dbFuture.then((database) {
        Future<List<Item>> itemListFuture = appDB.getItemList(activeTable);
        itemListFuture.then((resultList) {
          items = resultList.cast<Item>();
          emit(AppSuccessHomeDataState());
        });
      });
    }
  }

  Future<void> initialLoading(bool? isDataLoaded) async {
    if (isDataLoaded != null)
      emit(AppSuccessHomeDataState());
    else {
      emit(AppLoadingHomeDataState());
      dbAssets = assetDB.initializeDatabase();
      dbAssets.then((database) {
        Future<List<WordCallback>> wordListAsset = assetDB.getWordList();
        wordListAsset.then((itemsList) {
          saveWordsData(itemsList);
        });
      });
    }
  }

  Future<void> saveWordsData(List<WordCallback> assetWords) async {
    for (int i = 0; i < assetWords.length; i++) {
      int progressValue = (i / assetWords.length * 100).toInt();

      if (progressValue == 1) await loadHomeWordList();

      WordCallback? item = assetWords[i];

      Word? word =
          new Word(item.title, item.meaning, item.synonyms, item.conjugation);

      await appDB.insertWord(word);
    }
    loadHomeListView();
    requestIdiomsData();
  }

  void requestIdiomsData() async {
    dbAssets = assetDB.initializeDatabase();
    dbAssets.then((database) {
      Future<List<ItemCallback>> idiomsListAsset =
          assetDB.getItemList(DbStrings.idiomsTable);
      idiomsListAsset.then((itemsList) {
        saveItemData(
          AppStrings.idioms,
          DbStrings.idiomsTable,
          itemsList,
        );
        loadHomeListView();
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
        saveItemData(
          AppStrings.sayings,
          DbStrings.sayingsTable,
          itemsList,
        );
        loadHomeListView();
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
        saveItemData(
          AppStrings.proverbs,
          DbStrings.proverbsTable,
          itemsList,
        );
        loadHomeListView();
        finishSavingData();
      });
    });
  }

  Future<void> saveItemData(
    String type,
    String table,
    List<ItemCallback> itemlist,
  ) async {
    for (int i = 0; i < itemlist.length; i++) {
      ItemCallback itemCallBack = itemlist[i];

      Item item = new Item(
          itemCallBack.title, itemCallBack.meaning, itemCallBack.synonyms);

      await appDB.insertItem(table, item);
    }
  }

  Future<void> finishSavingData() async {
    emit(AppSuccessHomeDataState());
    loadHomeListView();
  }
}
