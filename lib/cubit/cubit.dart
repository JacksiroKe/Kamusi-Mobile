import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../cubit/states.dart';
import '../data/app_database.dart';
import '../data/models/item.dart';
import '../data/models/word.dart';
import '../ui/home/tabs/favorite_tab.dart';
import '../ui/home/tabs/history_tab.dart';
import '../ui/home/tabs/home_tab.dart';
import '../utils/app_variables.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> tabScreens = [
    HomeTab(),
    FavoriteTab(),
    HistoryTab(),
  ];

  AppDatabase db = AppDatabase();
  late Future<Database> dbFuture;
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

  void loadHomeListView() {
    emit(AppLoadingHomeDataState());
    words.clear();
    items.clear();
    dbFuture = db.initializeDatabase();

    if (activeTable == filtersTable[0]) {
      dbFuture.then((database) {
        Future<List<Word>> wordsListFuture = db.getWordList();
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
        Future<List<Item>> itemListFuture = db.getItemList(activeTable);
        itemListFuture.then((resultList) {
          items = resultList.cast<Item>();
          emit(AppSuccessHomeDataState());
        });
      });
    }
  }
}
