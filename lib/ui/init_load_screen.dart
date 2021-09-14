import 'package:anisi_controls/anisi_controls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

const simpleDelayedTask = "simpleDelayedTask";

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    AppDatabase appDB = AppDatabase();
    AssetDatabase assetDB = AssetDatabase();

    Future<Database> dbAssets, dbFuture;
    dbAssets = assetDB.initializeDatabase();

    return Future.value(true);
  });
}

class InitLoadScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InitLoadState();
  }
}

class InitLoadState extends State<InitLoadScreen> {
  final globalKey = new GlobalKey<ScaffoldState>();

  AsLineProgress? progress = AsLineProgress.setUp(
          0, Colors.black, Colors.black, AppColors.secondaryColor)
      as AsLineProgress?;
  AsInformer? informer = AsInformer.setUp(
      1,
      AppStrings.gettingReady,
      AppColors.primaryColor,
      Colors.transparent,
      Colors.white,
      10) as AsInformer?;

  AppDatabase appDB = AppDatabase();
  AssetDatabase assetDB = AssetDatabase();

  List<WordCallback> words = [];
  List<ItemCallback> idiomsList = [], sayingsList = [], proverbsList = [];

  late Future<Database> dbAssets, dbFuture;

  late double mHeight, mWidth;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => initBuild(context));
  }

  /// Run anything that needs to be run immediately after Widget build
  void initBuild(BuildContext context) async {
    informer!.show();
    requestData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: mainBody(),
    );
  }

  Widget mainBody() {
    mHeight = MediaQuery.of(context).size.height;
    mWidth = MediaQuery.of(context).size.width;

    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/splash.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: mWidth / 1.125,
              margin: EdgeInsets.only(top: mHeight / 2.52),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: progress,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: mHeight / 7.56),
              child: Center(
                child: informer,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void requestData() async {
    dbAssets = assetDB.initializeDatabase();
    dbAssets.then((database) {
      Future<List<WordCallback>> wordListAsset = assetDB.getWordList();
      wordListAsset.then((itemsList) {
        setState(() {
          words = itemsList;
          requestIdiomsData();
        });
      });
    });
  }

  void requestIdiomsData() async {
    dbAssets = assetDB.initializeDatabase();
    dbAssets.then((database) {
      Future<List<ItemCallback>> idiomsListAsset =
          assetDB.getItemList(DbStrings.idiomsTable);
      idiomsListAsset.then((itemsList) {
        setState(() {
          idiomsList = itemsList;
          requestSayingsData();
        });
      });
    });
  }

  void requestSayingsData() async {
    dbAssets = assetDB.initializeDatabase();
    dbAssets.then((database) {
      Future<List<ItemCallback>> sayingsListAsset =
          assetDB.getItemList(DbStrings.sayingsTable);
      sayingsListAsset.then((itemsList) {
        setState(() {
          sayingsList = itemsList;
          requestProverbsData();
        });
      });
    });
  }

  void requestProverbsData() async {
    dbAssets = assetDB.initializeDatabase();
    dbAssets.then((database) {
      Future<List<ItemCallback>> proverbsListAsset =
          assetDB.getItemList(DbStrings.proverbsTable);
      proverbsListAsset.then((itemsList) {
        setState(() {
          proverbsList = itemsList;
          _goToNextScreen();
        });
      });
    });
  }

  Future<void> saveWordsData() async {
    for (int i = 0; i < words.length; i++) {
      int progressValue = (i / words.length * 100).toInt();
      progress!.setProgress(progressValue);

      switch (progressValue) {
        case 1:
          informer!.setText("Moja...");
          break;
        case 2:
          informer!.setText("Mbili...");
          break;
        case 3:
          informer!.setText("Tatu ...");
          break;
        case 4:
          informer!.setText("Inapakia ...");
          break;
        case 10:
          informer!.setText("Inapakia maneno ...");
          break;
        case 20:
          informer!.setText("Kuwa mvumilivu ...");
          break;
        case 40:
          informer!.setText("Mvumilivu hula mbivu ...");
          break;
        case 50:
          informer!.setText("Inapakia maneno ...");
          break;
        case 75:
          informer!.setText("Asante kwa uvumilivu wako!");
          break;
        case 85:
          informer!.setText("Hatimaye");
          break;
        case 90:
          informer!.setText("Inapakia words ...");
          break;
        case 95:
          informer!.setText("Karibu tunamalizia");
          break;
      }

      WordCallback? item = words[i];

      Word? word =
          new Word(item.title, item.meaning, item.synonyms, item.conjugation);

      await appDB.insertWord(word);
    }
  }

  Future<void> saveItemData(
      String type, String table, List<ItemCallback> itemlist) async {
    for (int i = 0; i < itemlist.length; i++) {
      int progressValue = (i / itemlist.length * 100).toInt();
      progress!.setProgress(progressValue);
      informer!.setText("Sasa yapakia " + type + " ...");
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

    CacheHelper.setPrefBool(SharedPrefKeys.appDatabaseLoaded, true);
    Navigator.pushReplacement(
        context, new MaterialPageRoute(builder: (context) => new HomeScreen()));
  }
}
