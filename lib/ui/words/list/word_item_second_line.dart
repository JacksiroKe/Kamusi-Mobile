import 'package:flutter/material.dart';

import '../../../data/app_database.dart';
import '../../../data/models/word.dart';
import '../../../utils/styles/app_colors.dart';
import '../word_view.dart';

// ignore: must_be_immutable
class WordItemSecondLine extends StatelessWidget {
  final String synonyms;

  WordItemSecondLine(this.synonyms);
  var wordSynonyms;

  @override
  Widget build(BuildContext context) {
    wordSynonyms = synonyms.split(',');
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Container(
            child: Text(
              (wordSynonyms.length == 1 ? 'KISAWE ' : 'VISAWE ') +
                  wordSynonyms.length.toString() +
                  ":",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Flexible(
            child: tagViewer(context),
          ),
        ],
      ),
    );
  }

  Widget tagViewer(BuildContext context) {
    return Container(
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: wordSynonyms.length,
        itemBuilder: (BuildContext context, int index) {
          return tagView(context, wordSynonyms[index]);
        },
      ),
    );
  }

  Widget tagView(BuildContext context, String tagText) {
    try {
      if (tagText.isNotEmpty) {
        return InkWell(
          onTap: () {
            navigateToSynonym(context, tagText);
          },
          child: Container(
            margin: EdgeInsets.only(left: 10, bottom: 5),
            padding:
                const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
            decoration: BoxDecoration(
              color: AppColors.baseColor,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Center(
              child: Text(
                tagText,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        );
      } else
        return Container();
    } catch (Exception) {
      return Container();
    }
  }

  void navigateToSynonym(BuildContext context, String sysnonym) async {
    AppDatabase db = AppDatabase();
    Word? word = await db.getSpecificWord(sysnonym);
    if (word != null)
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WordView(word);
          },
        ),
      );
    else {}
  }
}
