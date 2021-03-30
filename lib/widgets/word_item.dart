import 'package:flutter/material.dart';

import '../data/app_database.dart';
import '../data/models/word.dart';
import 'word_view.dart';

class WordItem extends StatelessWidget {
  final String heroTag;
  final Word word;
  final BuildContext context;

  WordItem(this.heroTag, this.word, this.context);
  String varTitle, varMeaning;
  var varSynonyms, varContents, varExtra;

  @override
  Widget build(BuildContext context) {
    varTitle = word.title;
    varMeaning = word.meaning;
    varSynonyms = word.synonyms.split(',');

    try {
      if (varMeaning.length == 0) {
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
                  firstLine(),
                  if (word.synonyms.length != 0) secondLine(),
                ],
              ),
            ),
            onTap: () {
              navigateToViewer(word);
            },
          ),
        );
      }
    } catch (Exception) {
      return Container();
    }
  }

  Widget firstLine() {
    varMeaning = varMeaning.replaceAll("\\", "");
    varMeaning = varMeaning.replaceAll('"', '');
    varMeaning = varMeaning.replaceAll(',', ', ');
    varMeaning = varMeaning.replaceAll('  ', ' ');

    varContents = varMeaning.split("|");
    varExtra = varContents[0].split(":");

    varMeaning = " ~ " + varExtra[0].trim() + ".";

    if (varContents.length > 1) {
      var varExtra = varContents[1].split(":");
      varMeaning = varMeaning + "\n" + " ~ " + varExtra[0].trim() + ".";
    }

    return ListTile(
      title: Text(
        varTitle,
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
                varContents.length.toString(),
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
      subtitle: Text(
        varMeaning,
        maxLines: 2,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget secondLine() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Container(
            child: Text(
              (varSynonyms.length == 1 ? 'KISAWE ' : 'VISAWE ') +
                  varSynonyms.length.toString() +
                  ":",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Flexible(
            child: tagViewer(),
          ),
        ],
      ),
    );
  }

  Widget tagViewer() {
    return Container(
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: varSynonyms.length,
        itemBuilder: (BuildContext context, int index) {
          return tagView(varSynonyms[index]);
        },
      ),
    );
  }

  Widget tagView(String tagText) {
    try {
      if (tagText.isNotEmpty) {
        return Container(
          margin: EdgeInsets.only(left: 5, bottom: 5),
          child: RaisedButton(
            padding: EdgeInsets.all(5),
            child: Text(
              tagText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            onPressed: () {
              navigateToSynonym(tagText);
            },
          ),
        );
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

  void navigateToViewer(Word word) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WordView(word);
    }));
  }
}
