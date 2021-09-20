import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../cubit/states.dart';
import '../data/app_database.dart';
import '../data/asset_database.dart';
import '../data/callbacks/callbacks.dart';
import '../data/models/models.dart';
import '../ui/home/search/search.dart';
import '../ui/home/trivia/trivia_tab.dart';
import '../ui/home/personal/personal.dart';
import '../utils/strings/strings.dart';

class KamusiCubit extends Cubit<AppStates> {
  KamusiCubit() : super(AppInitialState());

  static KamusiCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> tabScreens = [
    SearchTab(),
    TriviaTab(),
    PersonalTab(),
  ];

  AppDatabase appDB = AppDatabase();
  AssetDatabase assetDB = AssetDatabase();
  late Future<Database> dbAssets, dbFuture;

  List<Word> searchList = [], words = [], personals = [];
  List<Item> items = [];
  late String letterSearch;

  List searchToggles = List.generate(searchFilters.length, (index) => false);
  String activeSearchFilter = searchFilters[0],
      activeSearchTab = searchFiltersTable[0];

  void onSearchFilterFocus(bool focus, String filter) {
    searchToggles[searchFilters.indexOf(filter)] = focus;
  }

  List personalToggles =
      List.generate(personalFilters.length, (index) => false);
  String activePersonalFilter = personalFilters[0],
      activePersonalTab = personalFilters[0];

  void onPersonalFilterFocus(bool focus, String filter) {
    personalToggles[personalFilters.indexOf(filter)] = focus;
  }

  void changeBottom(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  Future<void> loadHomeWordList() async {
    emit(AppLoadingSearchDataState());
    dbFuture = appDB.initializeDatabase();

    dbFuture.then((database) {
      Future<List<Word>> wordsListFuture = appDB.getWordList();
      wordsListFuture.then((resultList) {
        words = resultList;
        emit(AppSuccessSearchDataState());
      });
    });
  }

  void loadSearchListView() {
    emit(AppLoadingSearchDataState());
    words.clear();
    items.clear();
    dbFuture = appDB.initializeDatabase();

    if (activeSearchTab == DbStrings.wordsTable) {
      dbFuture.then((database) {
        Future<List<Word>> wordsListFuture = appDB.getWordList();
        wordsListFuture.then((resultList) {
          if (searchList.isEmpty)
            searchList = words = resultList;
          else
            words = resultList;
          emit(AppSuccessSearchDataState());
        });
      });
    } else {
      dbFuture.then((database) {
        Future<List<Item>> itemListFuture = appDB.getItemList(activeSearchTab);
        itemListFuture.then((resultList) {
          items = resultList.cast<Item>();
          emit(AppSuccessSearchDataState());
        });
      });
    }
  }

  void setSearchingLetter(String letter) async {
    emit(AppLoadingSearchDataState());
    words.clear();
    items.clear();
    letterSearch = letter;
    dbFuture = appDB.initializeDatabase();

    if (activeSearchTab == DbStrings.wordsTable) {
      dbFuture.then((database) {
        Future<List<Word>> wordListFuture = appDB.getWordSearch(letter, true);
        wordListFuture.then((resultList) {
          words = resultList;
          emit(AppSuccessSearchDataState());
            
        });
      });
    } else {
      dbFuture.then((database) {
        Future<List<Item>> itemListFuture =
            appDB.getItemSearch(letter, activeSearchTab, true);
        itemListFuture.then((resultList) {
          items = resultList.cast<Item>();
          emit(AppSuccessSearchDataState());
            
        });
      });
    }
  }

  void loadPersonalListView() {
    emit(AppLoadingPersonalDataState());
    personals.clear();
    dbFuture = appDB.initializeDatabase();

    if (activePersonalTab == AppStrings.history) {
      dbFuture.then((database) {
        Future<List<Word>> personalListFuture = appDB.getHistories();
        personalListFuture.then((resultList) {
          personals = resultList;
          emit(AppSuccessPersonalDataState());
        });
      });
    } else if (activePersonalTab == AppStrings.favorites) {
      dbFuture.then((database) {
        Future<List<Word>> personalListFuture = appDB.getFavorites();
        personalListFuture.then((resultList) {
          personals = resultList;
          emit(AppSuccessPersonalDataState());
        });
      });
    } else if (activePersonalTab == AppStrings.searches) {
      dbFuture.then((database) {
        Future<List<Word>> personalListFuture = appDB.getSearches();
        personalListFuture.then((resultList) {
          personals = resultList;
          emit(AppSuccessPersonalDataState());
        });
      });
    }
  }

  Future<void> initialLoading(bool? isDataLoaded) async {
    if (isDataLoaded != null)
      emit(AppSuccessSearchDataState());
    else {
      emit(AppLoadingSearchDataState());
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
    loadSearchListView();
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
        loadSearchListView();
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
        loadSearchListView();
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
        loadSearchListView();
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
    emit(AppSuccessSearchDataState());
    loadSearchListView();
  }
}
