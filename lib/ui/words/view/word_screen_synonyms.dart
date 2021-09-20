import 'package:flutter/material.dart';
import 'package:kamusi/utils/styles/app_colors.dart';

import '../../../../data/app_database.dart';
import '../../../../data/models/models.dart';
import 'word.dart';

// ignore: must_be_immutable
class WordScreenSynonyms extends StatelessWidget {
  var wordSynonyms;

  WordScreenSynonyms(this.wordSynonyms);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(),
      child: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 5.0,
          direction: Axis.horizontal,
          children: [
            Text(
              wordSynonyms.length == 1 ? 'Kisawe: ' : 'Visawe: ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            for (var synonym in wordSynonyms) synonymView(context, synonym),
          ],
        ),
      ),
    );
  }

  Widget synonymView(BuildContext context, String synonym) {
    try {
      if (synonym.isNotEmpty) {
        return InkWell(
          onTap: () {
            navigateToSynonym(context, synonym);
          },
          child: Container(
            padding:
                const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
            margin: const EdgeInsets.only(bottom: 10, left: 10),
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
            child: Text(
              synonym,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
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
            return WordScreen(word);
          },
        ),
      );
  }
}
