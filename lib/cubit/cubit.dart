import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../cubit/states.dart';
import '../data/app_database.dart';
import '../data/asset_database.dart';
import '../data/base/event_object.dart';
import '../data/callbacks/callbacks.dart';
import '../data/models/models.dart';
import '../services/futures.dart';
import '../ui/personal/personal.dart';
import '../ui/search/search.dart';
import '../ui/trivia/trivia_tab.dart';
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
  List<Word> histories = [], favorites = [];
  List<TriviaCat> categories = [];
  List<Item> items = [];
  late String letterSearch;

  int? triviaLevel = 1, triviaLimit = 30;

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

  List triviaToggles = List.generate(triviaFilters.length, (index) => false);
  String activeTriviaFilter = triviaFilters[0],
      activeTriviaTab = triviaFilters[0];

  void onTriviaFilterFocus(bool focus, String filter) {
    triviaToggles[triviaFilters.indexOf(filter)] = focus;
  }

  void onTriviaSetLimit(int limit) {
    triviaLimit = limit;
  }

  void onTriviaSetLevel(int level) {
    triviaLevel = level;
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

  void loadSearchListView() async {
    emit(AppLoadingSearchDataState());
    words.clear();
    items.clear();
    dbFuture = appDB.initializeDatabase();

    if (activeSearchTab == DbStrings.wordsTable) {
      dbFuture.then((database) {
        Future<List<Word>> listFuture = appDB.getWordList();
        listFuture.then((resultList) {
          if (searchList.isEmpty)
            searchList = words = resultList;
          else
            words = resultList;
          emit(AppSuccessSearchDataState());
        });
      });
    } else {
      dbFuture.then((database) {
        Future<List<Item>> listFuture = appDB.getItemList(activeSearchTab);
        listFuture.then((resultList) {
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
        Future<List<Word>> listFuture = appDB.getWordSearch(letter, true);
        listFuture.then((resultList) {
          words = resultList;
          emit(AppSuccessSearchDataState());
        });
      });
    } else {
      dbFuture.then((database) {
        Future<List<Item>> listFuture =
            appDB.getItemSearch(letter, activeSearchTab, true);
        listFuture.then((resultList) {
          items = resultList.cast<Item>();
          emit(AppSuccessSearchDataState());
        });
      });
    }
  }

  void loadPersonalListView() async {
    emit(AppLoadingPersonalDataState());
    personals.clear();
    dbFuture = appDB.initializeDatabase();

    if (activePersonalTab == AppStrings.history) {
      dbFuture.then((database) {
        Future<List<Word>> listFuture = appDB.getHistories(0);
        listFuture.then((resultList) {
          personals = resultList;
          emit(AppSuccessPersonalDataState());
        });
      });
    } else if (activePersonalTab == AppStrings.favorites) {
      dbFuture.then((database) {
        Future<List<Word>> listFuture = appDB.getFavorites(0);
        listFuture.then((resultList) {
          personals = resultList;
          //print('Results: ' + personals.length.toString());
          emit(AppSuccessPersonalDataState());
        });
      });
    } else if (activePersonalTab == AppStrings.searches) {
      dbFuture.then((database) {
        Future<List<Word>> listFuture = appDB.getSearches();
        listFuture.then((resultList) {
          personals = resultList;
          emit(AppSuccessPersonalDataState());
        });
      });
    }
  }

  void loadHistories() async {
    emit(AppLoadingPersonalDataState());
    histories.clear();
    dbFuture = appDB.initializeDatabase();

    dbFuture.then((database) {
      Future<List<Word>> listFuture = appDB.getHistories(5);
      listFuture.then((resultList) {
        histories = resultList;
        emit(AppSuccessPersonalDataState());
      });
    });
  }

  void loadFavorites() async {
    emit(AppLoadingPersonalDataState());
    favorites.clear();
    dbFuture = appDB.initializeDatabase();

    dbFuture.then((database) {
      Future<List<Word>> listFuture = appDB.getFavorites(5);
      listFuture.then((resultList) {
        favorites = resultList;
        emit(AppSuccessPersonalDataState());
      });
    });
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

  // Method to request data either from the db or server
  void requestCategoriesData() async {
    EventObject eventObject = await getCategories();

    switch (eventObject.id) {
      case EventConstants.requestSuccessful:
        {
          categories = TriviaCat.fromData(
              eventObject.object as List<Map<String, dynamic>>);
        }
        break;

      case EventConstants.requestUnsuccessful:
        {
          //showDialog(
          //     context: context, builder: (context) => noInternetDialog());
        }
        break;

      case EventConstants.noInternetConnection:
        {
          //showDialog(
          //     context: context, builder: (context) => noInternetDialog());
        }
        break;
    }
  }

  void loadTriviaView() async {
    emit(AppLoadingTriviaDataState());
    categories.clear();
    dbFuture = appDB.initializeDatabase();

    if (activeTriviaTab == AppStrings.categories) {
      requestCategoriesData();
    }
  }
}
