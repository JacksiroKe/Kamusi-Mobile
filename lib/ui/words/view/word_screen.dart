import 'package:flutter/material.dart';

import '../../../../cubit/cubit.dart';
import '../../../../data/models/models.dart';
import '../../../../utils/strings/strings.dart';
import 'word.dart';

// ignore: must_be_immutable
class WordScreen extends StatelessWidget {
  final Word word;

  WordScreen(this.word);

  final globalKey = GlobalKey<ScaffoldState>();

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

    KamusiCubit.get(context).appDB.insertWordHistory(word.id);

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(true);
        return true;
      },
      child: Scaffold(
        key: globalKey,
        appBar: AppBar(
          title: appbarTitle(),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                isFavourited ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () => favoriteThis(context),
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

  Widget appbarTitle() {
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
            AppStrings.appName,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  void favoriteThis(BuildContext context) {
    bool _isfavorite;
    if (word.isfav == 1) {
      _isfavorite = false;
      KamusiCubit.get(context).appDB.favouriteWord(word, _isfavorite);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Neno " + word.title + " " + AppStrings.wordDisliked),
      ));
    } else {
      _isfavorite = true;
      KamusiCubit.get(context).appDB.favouriteWord(word, _isfavorite);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Neno " + word.title + " " + AppStrings.wordLiked),
      ));
    }
    isFavourited = _isfavorite;
  }
}
