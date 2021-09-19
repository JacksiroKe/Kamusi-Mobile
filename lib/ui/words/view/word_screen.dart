import 'package:flutter/material.dart';

import '../../../../data/app_database.dart';
import '../../../../data/models/models.dart';
import 'word.dart';

// ignore: must_be_immutable
class WordScreen extends StatelessWidget {
  final Word word;

  WordScreen(this.word);

  final globalKey = GlobalKey<ScaffoldState>();
  AppDatabase db = AppDatabase();

  bool isFavourited = false;
  String? wordMeaning;
  var wordMeanings, wordExtra, wordSynonyms;

  @override
  Widget build(BuildContext context) {
    wordMeaning = word.meaning.replaceAll("\\", "");
    wordMeaning = wordMeaning!.replaceAll('"', '');
    wordMeaning = wordMeaning!.replaceAll(',', ', ');
    wordMeaning = wordMeaning!.replaceAll('  ', ' ');

    wordMeanings = wordMeaning!.split("|");
    wordExtra = wordMeanings[0].split(":");
    wordSynonyms = word.synonyms.split(',');

    wordMeaning = " ~ " + wordExtra[0].trim() + ".";

    if (wordMeanings.length > 1) {
      var wordExtra = wordMeanings[1].split(":");
      wordMeaning = wordMeaning! + "\n" + " ~ " + wordExtra[0].trim() + ".";
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(true);
        return true;
      },
      child: Scaffold(
        key: globalKey,
        appBar: AppBar(
          title: appbarContainer(),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                isFavourited ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () => favoriteThis(),
            )
          ],
        ),
        body: WordScreenBody(
          word,
          wordMeanings,
          wordSynonyms,
        ),
      ),
    );
  }

  Widget appbarContainer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            word.title.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            'Maana ' +
                wordMeanings.length.toString() +
                ', Visawe ' +
                wordSynonyms.length.toString(),
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  void favoriteThis() {}
}
