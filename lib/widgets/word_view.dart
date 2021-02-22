import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';

import '../services/app_settings.dart';
import '../utils/app_utils.dart';
import '../utils/colors.dart';
import '../data/app_database.dart';
import '../data/models/word.dart';

/// Show a full View of a word meaning
class WordView extends StatefulWidget {
  final Word word;

  WordView(this.word);

  @override
  State<StatefulWidget> createState() {
    return WordViewState(this.word);
  }
}

class WordViewState extends State<WordView> {
  WordViewState(this.word);
  final globalKey = GlobalKey<ScaffoldState>();
  AppDatabase db = AppDatabase();

  Word word;
  bool isFavourited;
  String varTitle, varContents;
  var varSynonyms, varMeaning, varExtra;

  @override
  Widget build(BuildContext context) {
    varTitle = word.title;
    varContents = word.meaning;
    varSynonyms = word.synonyms.split(',');
    isFavourited(int favorite) => favorite == 1 ?? false;

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
      },
      child: Scaffold(
        key: globalKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(AppStrings.appName),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                isFavourited(word.isfav) ? Icons.star : Icons.star_border,
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
      constraints: BoxConstraints.expand(),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: Provider.of<AppSettings>(context).isDarkMode
          ? BoxDecoration()
          : BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [ColorUtils.white, Colors.cyan, Colors.indigo]),
            ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            wordTitle(),
            wordMeaning(),
            SizedBox(height: 20.0),
            if (word.synonyms.length != 0) wordSynoyms(),
          ],
        ),
      ),
    );
  }

  Widget wordTitle() {
    return Container(
      child: Html(
        data: "<h3>" + varTitle + "</h3>",
        style: {
          "h3": Style(
              fontSize: FontSize(30.0),
              color: Provider.of<AppSettings>(context).isDarkMode
                  ? ColorUtils.white
                  : ColorUtils.black),
        },
      ),
    );
  }

  Widget wordMeaning() {
    varContents = varContents.replaceAll("\\", "");
    varContents = varContents.replaceAll('"', '');
    varContents = varContents.replaceAll(',', ', ');
    varContents = varContents.replaceAll('  ', ' ');

    varMeaning = varContents.split("|");

    return Container(
      child: Column(
        children: [
          for (var meaningStr in varMeaning) meaningItem(meaningStr),
        ],
      ),
    );
  }

  Widget meaningItem(String meaningStr) {
    var varExtra = meaningStr.split(":");
    if (varExtra.length == 2) {
      return Card(
        elevation: 2,
        child: Container(
          child: ListTile(
            title: Text(
              " ~ " + varExtra[0],
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Html(
              data: "<p><i>Mfano:</i> " + varExtra[1] + "</p>",
              style: {
                "p": Style(
                  fontSize: FontSize(18),
                ),
              },
            ),
          ),
        ),
      );
    } else {
      return Card(
        elevation: 2,
        child: Container(
          child: ListTile(
            title: Text(
              " ~ " + varExtra[0],
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      );
    }
  }

  Widget wordSynoyms() {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(5),
        child: ListTile(
          title: Text(
            (varSynonyms.length == 1 ? 'KISAWE (' : 'VISAWE (') +
                varSynonyms.length.toString() +
                ')',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle: Card(
            elevation: 2,
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  for (var synonymsStr in varSynonyms) tagView(synonymsStr),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget tagView(String tagText) {
    try {
      if (tagText.isNotEmpty) {
        return Column(children: <Widget>[
          tagText != varSynonyms[0] ? Divider() : Container(),
          ListTile(
            leading: Icon(Icons.navigate_next),
            title: Text(
              tagText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            subtitle: Text("Jifunze zaidi ..."),
            onTap: () {
              navigateToSynonym(tagText);
            },
          ),
        ]);
      } else
        return Container();
    } catch (Exception) {
      return Container();
    }
  }

  void navigateToSynonym(String sysnonym) async {
    AppDatabase db = AppDatabase();
    Word word = await db.getSpecificWord(sysnonym);
    if (word != null)
      await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return WordView(word);
      }));
    else {}
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
    Clipboard.setData(ClipboardData(
        text: varTitle +
            "\n\n" +
            varContents.replaceAll("|", "\n") +
            AppStrings.campaign));
    globalKey.currentState.showSnackBar(SnackBar(
      content: Text(AppStrings.wordCopied),
    ));
  }

  void shareItem() {
    Share.share(
      varTitle +
          "\n\n" +
          varContents.replaceAll("|", "\n") +
          AppStrings.campaign,
      subject: "Shiriki: " + word.title,
    );
  }

  void favoriteThis() {
    bool _isfavorite;
    if (word.isfav == 1) {
      _isfavorite = false;
      db.favouriteWord(word, _isfavorite);

      globalKey.currentState.showSnackBar(SnackBar(
        content: Text("Neno " + word.title + " " + AppStrings.wordDisliked),
      ));
    } else {
      _isfavorite = true;
      db.favouriteWord(word, _isfavorite);
      globalKey.currentState.showSnackBar(SnackBar(
        content: Text("Neno " + word.title + " " + AppStrings.wordLiked),
      ));
    }
    setState(() {
      isFavourited = _isfavorite;
    });
  }
}
