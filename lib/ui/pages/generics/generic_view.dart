// This file declares the content view screen

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';

import '../../../utils/colors.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/db_utils.dart';
import '../../../services/app_settings.dart';
import '../../../data/app_database.dart';
import '../../../data/models/item.dart';

/// Show a full View of a item meaning
class GenericView extends StatefulWidget {
  final Item item;
  final String type;

  GenericView(this.item, this.type);

  @override
  State<StatefulWidget> createState() {
    return GenericViewState(this.item, this.type);
  }
}

class GenericViewState extends State<GenericView> {
  GenericViewState(this.item, this.type);
  final globalKey = new GlobalKey<ScaffoldState>();
  AppDatabase db = AppDatabase();

  var appBar = AppBar(), itemVerses;
  Item item;
  String type;
  int curItem = 0;
  String itemContent;
  List<String> meanings, synonyms;
  List<Item> items;

  @override
  Widget build(BuildContext context) {
    curItem = item.id;
    itemContent = item.title + " ni item la Kiswahili lenye meaning:";
    bool isFavourited(int favorite) => favorite == 1 ?? false;

    if (meanings == null) {
      meanings = [];
      synonyms = [];
      processData();
    }

    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: Scaffold(
        key: globalKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(AppStrings.appName),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                isFavourited(item.isfav) ? Icons.star : Icons.star_border,
              ),
              onPressed: () => favoriteThis(),
            )
          ],
        ),
        body: mainBody(),
        floatingActionButton: AnimatedFloatingActionButton(
          fabButtons: floatingButtons(),
          animatedIconData: AnimatedIcons.menu_close,
        ),
      ),
    );
  }

  Widget mainBody() {
    return Container(
      decoration: Provider.of<AppSettings>(context).isDarkMode
          ? BoxDecoration()
          : BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [ColorUtils.white, Colors.cyan, Colors.indigo]),
            ),
      child: new Stack(
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Html(
              data: "<h3>" + item.title + "</h3>",
              style: {
                "h3": Style(
                    fontSize: FontSize(30.0),
                    color: Provider.of<AppSettings>(context).isDarkMode
                        ? ColorUtils.white
                        : ColorUtils.black),
              },
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 100,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            margin: EdgeInsets.only(top: 60),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: meanings.length,
              itemBuilder: listView,
            ),
          ),
        ],
      ),
    );
  }

  Widget listView(BuildContext context, int index) {
    if (item.synonyms == meanings[index]) {
      itemContent = itemContent +
          AppStrings.synonyms_for +
          item.title +
          " ni: " +
          item.synonyms;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Html(
          data: "<p><b>Visawe:</b> <i>" + item.synonyms + "</i></p>",
          style: {
            "p": Style(
              fontSize: FontSize(25.0),
            ),
          },
        ),
      );
    } else {
      var strContents = meanings[index].split(":");
      String strContent = meanings[index];

      if (strContents.length > 1) {
        strContent = strContents[0] + "<br>";
        strContent = strContent +
            "<p><b>Kwa mfano:</b> <i>" +
            strContents[1] +
            "</i></p>";

        itemContent = itemContent + "\n- " + strContents[0] + " kwa mfano: ";
        itemContent = itemContent + strContents[1];
      } else
        itemContent = itemContent + "\n - " + meanings[index];

      return Card(
        elevation: 2,
        child: GestureDetector(
          child: Html(
            data: "<ul><li>" + strContent + "</li></ul>",
            style: {
              "li": Style(
                fontSize: FontSize(25.0),
              ),
              "p": Style(
                fontSize: FontSize(22.0),
              ),
            },
          ),
        ),
      );
    }
  }

  List<Widget> floatingButtons() {
    return <Widget>[
      FloatingActionButton(
        heroTag: null,
        child: Icon(Icons.content_copy),
        tooltip: AppStrings.copyThis,
        onPressed: copyItem,
      ),
      FloatingActionButton(
        heroTag: null,
        child: Icon(Icons.share),
        tooltip: AppStrings.shareThis,
        onPressed: shareItem,
      ),
    ];
  }

  void copyItem() {
    Clipboard.setData(ClipboardData(text: itemContent + AppStrings.campaign));
    switch (type) {
      case DbUtils.idiomsTable:
        globalKey.currentState.showSnackBar(new SnackBar(
          content: new Text(AppStrings.idiomCopied),
        ));
        return;

      case DbUtils.sayingsTable:
        globalKey.currentState.showSnackBar(new SnackBar(
          content: new Text(AppStrings.sayingCopied),
        ));
        return;

      case DbUtils.proverbsTable:
        globalKey.currentState.showSnackBar(new SnackBar(
          content: new Text(AppStrings.proverbCopied),
        ));
        return;
    }
  }

  void shareItem() {
    Share.share(
      itemContent + AppStrings.campaign,
      subject: "Shiriki: " + item.title,
    );
  }

  void favoriteThis() {
    /*if (item.isfav == 1)
      db.favouriteItem(item, false);
    else
      db.favouriteItem(item, true);
    globalKey.currentState.showSnackBar(new SnackBar(
      content: new Text(item.title + " " + AppStrings.itemLiked),
    ));*/
    //notifyListeners();
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void processData() async {
    itemContent = item.title;
    meanings = [];
    synonyms = [];

    try {
      String strMeaning = item.meaning;
      strMeaning = strMeaning.replaceAll("\\", "");
      strMeaning = strMeaning.replaceAll('"', '');

      var strMeanings = strMeaning.split("|");

      if (strMeanings.length > 1) {
        for (int i = 0; i < strMeanings.length; i++) {
          meanings.add(strMeanings[i]);
        }
      } else {
        meanings.add(strMeanings[0]);
      }
    } catch (Exception) {}
    if (item.synonyms.length > 1) meanings.add(item.synonyms);

    try {
      var strSynonyms = item.meaning.split("|");

      if (strSynonyms.length > 1) {
        for (int i = 0; i < strSynonyms.length; i++) {
          synonyms.add(strSynonyms[i]);
        }
      } else {
        synonyms.add(strSynonyms[0]);
      }
    } catch (Exception) {}
  }
}
