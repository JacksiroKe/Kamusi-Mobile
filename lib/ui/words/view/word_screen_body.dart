import 'package:flutter/material.dart';

import '../../../../data/app_database.dart';
import '../../../../data/models/models.dart';
import 'word.dart';

// ignore: must_be_immutable
class WordScreenBody extends StatelessWidget {
  final Word word;
  var wordMeanings, wordSynonyms;

  WordScreenBody(this.word, this.wordMeanings, this.wordSynonyms);

  final globalKey = GlobalKey<ScaffoldState>();
  AppDatabase db = AppDatabase();

  bool isFavourited = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.cyan, Colors.indigo]),
      ),
      child: mainBody(context),
    );
  }

  Widget mainBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          if (word.synonyms.length != 0) WordScreenSynonyms(wordSynonyms),
          WordScreenMeaning(wordMeanings),
        ],
      ),
    );
  }
}
