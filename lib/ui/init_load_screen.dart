import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workmanager/workmanager.dart';

import '../data/app_database.dart';
import '../data/asset_database.dart';
import '../data/cache_helper.dart';
import '../data/callbacks/ItemCallback.dart';
import '../data/callbacks/WordCallback.dart';
import '../data/models/item.dart';
import '../data/models/word.dart';
import '../utils/strings/app_preferences.dart';
import '../utils/strings/app_strings.dart';
import '../utils/strings/db_strings.dart';
import '../utils/styles/app_colors.dart';
import 'home/home_screen.dart';

class InitLoadScreen extends StatefulWidget {
  final FlutterLocalNotificationsPlugin appNotifications;
  InitLoadScreen(this.appNotifications);

  @override
  State<StatefulWidget> createState() {
    return InitLoadState(this.appNotifications);
  }
}

class InitLoadState extends State<InitLoadScreen> {
  final globalKey = new GlobalKey<ScaffoldState>();
  InitLoadState(this.appNotifications);
  FlutterLocalNotificationsPlugin appNotifications;

  AppDatabase appDB = AppDatabase();
  AssetDatabase assetDB = AssetDatabase();

  List<WordCallback> words = [];
  List<ItemCallback> idiomsList = [], sayingsList = [], proverbsList = [];

  late Future<Database> dbAssets, dbFuture;

  @override
  Widget build(BuildContext context) {
    new Future.delayed(const Duration(seconds: 5), startWorkManager);
    return Scaffold(
      key: globalKey,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: mainBody(),
      ),
    );
  }

  Widget mainBody() {
    return Center(
      child: Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.baseColor),
          boxShadow: [BoxShadow(blurRadius: 5)],
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(AppColors.baseColor),
          ),
        ),
      ),
    );
  }

  Future<void> startWorkManager() async {
    Workmanager().initialize(callbackDispatcher);
    CacheHelper.setPrefBool(SharedPrefKeys.appDatabaseLoaded, true);
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(
        builder: (context) => new HomeScreen(),
      ),
    );
  }

  void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      requestAssetData();
      return Future.value(true);
    });
  }

  void requestAssetData() async {
    dbAssets = assetDB.initializeDatabase();
    dbAssets.then((database) {
      Future<List<WordCallback>> wordListAsset = assetDB.getWordList();
      wordListAsset.then((itemsList) {
        words = itemsList;
        //requestIdiomsData();
        saveWordsData();
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
        finishSavingData();
      });
    });
  }

  Future<void> saveWordsData() async {
    for (int i = 0; i < words.length; i++) {
      int progressValue = (i / words.length * 100).toInt();

      await Future<void>.delayed(const Duration(seconds: 1), () async {
        final AndroidNotificationDetails notification =
            AndroidNotificationDetails(
          'kamusinotify',
          'Kamusi ya Kiswahili Notification',
          'Subiri inapakia',
          channelShowBadge: true,
          importance: Importance.max,
          priority: Priority.high,
          onlyAlertOnce: true,
          showProgress: true,
          maxProgress: 100,
          progress: progressValue,
          additionalFlags: Int32List.fromList(<int>[4]),
        );
        final NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: notification);
        await appNotifications.show(
          0,
          'Inapakia maneno ya Kiswahili',
          progressValue.toString() + ' %',
          platformChannelSpecifics,
          payload: 'item x',
        );
      });

      WordCallback? item = words[i];

      Word? word =
          new Word(item.title, item.meaning, item.synonyms, item.conjugation);

      await appDB.insertWord(word);
    }
    await appNotifications.cancel(0);
  }

  Future<void> saveItemData(
      String type, String table, List<ItemCallback> itemlist) async {
    for (int i = 0; i < itemlist.length; i++) {
      //int progressValue = (i / itemlist.length * 100).toInt();
      //progress!.setProgress(progressValue);
      //informer!.setText("Sasa yapakia " + type + " ...");
      ItemCallback itemCallBack = itemlist[i];

      Item item = new Item(
          itemCallBack.title, itemCallBack.meaning, itemCallBack.synonyms);

      await appDB.insertItem(table, item);
    }
  }

  Future<void> finishSavingData() async {
    await saveWordsData();
    await saveItemData(AppStrings.idioms, DbStrings.idiomsTable, idiomsList);
    await saveItemData(AppStrings.sayings, DbStrings.sayingsTable, sayingsList);
    await saveItemData(
        AppStrings.proverbs, DbStrings.proverbsTable, proverbsList);
  }
}
