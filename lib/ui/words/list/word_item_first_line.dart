import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WordItemFirstLine extends StatelessWidget {
  final String theword;
  final String meaning;

  WordItemFirstLine(this.theword, this.meaning);
  String? wordMeaning;
  var wordContents, wordExtra;

  @override
  Widget build(BuildContext context) {
    wordMeaning = meaning.replaceAll("\\", "");
    wordMeaning = wordMeaning!.replaceAll('"', '');
    wordMeaning = wordMeaning!.replaceAll(',', ', ');
    wordMeaning = wordMeaning!.replaceAll('  ', ' ');

    wordContents = wordMeaning!.split("|");
    wordExtra = wordContents[0].split(":");

    wordMeaning = " ~ " + wordExtra[0].trim() + ".";

    if (wordContents.length > 1) {
      var wordExtra = wordContents[1].split(":");
      wordMeaning = wordMeaning! + "\n" + " ~ " + wordExtra[0].trim() + ".";
    }

    return ListTile(
      title: Text(
        theword,
        maxLines: 1,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      trailing: Container(
        width: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                "MAANA",
                style: TextStyle(fontSize: 12),
              ),
            ),
            Center(
              child: Text(
                wordContents.length.toString(),
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
      subtitle: Text(
        wordMeaning!,
        maxLines: 2,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
