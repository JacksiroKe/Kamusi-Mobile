import 'package:flutter/material.dart';

import '../../../../data/models/word.dart';
import '../word_view.dart';
import 'word.dart';

// ignore: must_be_immutable
class WordItemBody extends StatelessWidget {
  final String heroTag;
  final Word word;

  WordItemBody(this.heroTag, this.word);

  String? wordTitle, wordMeaning;

  @override
  Widget build(BuildContext context) {
    wordTitle = word.title;
    wordMeaning = word.meaning;

    try {
      if (wordMeaning!.length == 0) {
        return Container();
      } else {
        return Card(
          elevation: 2,
          child: GestureDetector(
            child: Container(
              padding: EdgeInsets.only(bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  WordItemFirstLine(wordTitle!, wordMeaning!),
                  if (word.synonyms.length != 0) WordItemSecondLine(word.synonyms),
                ],
              ),
            ),
            onTap: () {
              navigateToViewer(context, word);
            },
          ),
        );
      }
    } catch (Exception) {
      return Container();
    }
  }

  void navigateToViewer(BuildContext context, Word word) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return WordView(word);
        },
      ),
    );
  }
}
