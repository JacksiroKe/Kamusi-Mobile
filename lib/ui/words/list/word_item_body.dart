import 'package:flutter/material.dart';

import '../../../../data/models/models.dart';
import '../view/word_screen.dart';
import 'word.dart';

// ignore: must_be_immutable
class WordItemBody extends StatelessWidget {
  final String heroTag;
  final Word word;
  final bool showTimeline;

  WordItemBody(this.heroTag, this.word, this.showTimeline);

  String? wordTitle, wordMeaning;
  final fifteenAgo = new DateTime.now().subtract(new Duration(minutes: 15));

  String convertToAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);

    if (diff.inDays >= 1) {
      return '${diff.inDays} day(s) ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour(s) ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute(s) ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} second(s) ago';
    } else {
      return 'just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    wordTitle = word.title;
    wordMeaning = word.meaning;
    //print('Time: ' + convertToAgo(DateTime.parse(word.updated)));
    print('Time: ' + DateTime.now().millisecondsSinceEpoch.toString());

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
      width: 80,
      margin: EdgeInsets.only(top: 10),
      child: Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Text(word.updated),
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
