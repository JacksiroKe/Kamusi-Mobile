import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../services/app_settings.dart';
import '../../../data/app_database.dart';
import '../../../data/models/word.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/colors.dart';
import '../../widgets/as_loader.dart';
import '../../widgets/as_informer.dart';
import '../words/word_item.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  FavouriteScreenState createState() => FavouriteScreenState();
}

class FavouriteScreenState extends State<FavouriteScreen> {
  AsLoader loader = AsLoader.setUp(ColorUtils.primaryColor);
  AsInformer notice = AsInformer.setUp(3, AppStrings.nothing, Colors.red,
      Colors.transparent, ColorUtils.white, 10);

  AppDatabase db = AppDatabase();

  Future<Database> dbFuture;
  List<Word> items = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initBuild(context));
  }

  /// Run anything that needs to be run immediately after Widget build
  void initBuild(BuildContext context) async {
    loadListView();
  }

  void loadListView() async {
    loader.show();

    dbFuture = db.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Word>> itemListFuture = db.getFavorites();
      itemListFuture.then((resultList) {
        setState(() {
          items = resultList;
          loader.hide();
          if (items.length == 0)
            notice.show();
          else
            notice.hide();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppStrings.favourited),
      ),
      body: mainBody(),
    );
  }

  Widget mainBody() {
    return Container(
      decoration: Provider.of<AppSettings>(context).isDarkMode
          ? BoxDecoration()
          : BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.1,
                    0.4,
                    0.6,
                    0.9
                  ],
                  colors: [
                    ColorUtils.black,
                    ColorUtils.baseColor,
                    ColorUtils.primaryColor,
                    ColorUtils.lightColor
                  ]),
            ),
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return WordItem('ItemLiked_' + items[index].id.toString(),
                      items[index], context);
                }),
          ),
          Container(
            height: 200,
            child: notice,
          ),
          Container(
            height: 200,
            child: Center(
              child: loader,
            ),
          ),
        ],
      ),
    );
  }
}
