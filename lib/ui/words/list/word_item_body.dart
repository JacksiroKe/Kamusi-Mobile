import 'package:flutter/material.dart';

import '../../../../data/models/models.dart';
import '../../../../utils/strings/strings.dart';
import '../view/word_screen.dart';
import 'word.dart';

// ignore: must_be_immutable
class WordItemBody extends StatelessWidget {
  final String heroTag;
  final Word word;
  final bool showTimeline;

  WordItemBody(this.heroTag, this.word, this.showTimeline);

  String? wordTitle, wordMeaning;

  @override
  Widget build(BuildContext context) {
    wordTitle = word.title;
    wordMeaning = word.meaning;

    try {
      if (wordMeaning!.length == 0) {
        return Container();
      } else {
        return Container(
          child: Stack(
            children: [
              if (showTimeline) wordTimeline(context),
              wordContent(context),
            ],
          ),
        );
      }
    } catch (Exception) {
      return Container();
    }
  }

  Widget wordTimeline(BuildContext context) {
    return Container(
      width: 90,
      margin: EdgeInsets.only(top: 10),
      child: Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
          child: Text(
            timeAgo(int.parse(word.updated)),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget wordContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: showTimeline ? 70 : 0),
      width: showTimeline
          ? MediaQuery.of(context).size.width - 70
          : double.infinity,
      child: Card(
        elevation: 5,
        child: GestureDetector(
          child: Container(
            padding: EdgeInsets.only(bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                WordItemFirstLine(wordTitle!, wordMeaning!),
                if (word.synonyms.length != 0)
                  WordItemSecondLine(word.synonyms),
              ],
            ),
          ),
          onTap: () {
            navigateToViewer(context, word);
          },
        ),
      ),
    );
  }

  void navigateToViewer(BuildContext context, Word word) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return WordScreen(word);
        },
      ),
    );
  }
}
