import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

// ignore: must_be_immutable
class WordScreenMeaning extends StatelessWidget {
  var wordMeanings;

  WordScreenMeaning(this.wordMeanings);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Column(
        children: [
          for (var meaningStr in wordMeanings) meaningItem(meaningStr),
        ],
      ),
    );
  }

  Widget meaningItem(String meaningStr) {
    var wordExtra = meaningStr.split(":");
    if (wordExtra.length == 2) {
      return Card(
        elevation: 2,
        child: Container(
          child: ListTile(
            title: Text(
              " ~ " + wordExtra[0],
              style: TextStyle(fontSize: 20),
            ),
            subtitle: wordExtra[1].length > 5
                ? Html(
                    data: "<p><i>Mfano:</i> " + wordExtra[1] + "</p>",
                    style: {
                      "p": Style(
                        fontSize: FontSize(18),
                      ),
                    },
                  )
                : null,
          ),
        ),
      );
    } else {
      return Card(
        elevation: 2,
        child: Container(
          child: ListTile(
            title: Text(
              " ~ " + wordExtra[0],
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      );
    }
  }
}
