import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:provider/provider.dart';

import '../../services/app_settings.dart';
import '../../utils/colors.dart';
import '../../data/models/word.dart';
import '../views/word_view.dart';

class WordItem extends StatelessWidget {

  final String heroTag;
  final Word word;
  final BuildContext context;

  WordItem(this.heroTag, this.word, this.context);
  String itemBook;

  @override
  Widget build(BuildContext context) {
    String strTitle = word.title;
    String strMeaning = word.meaning;

    try {
      if (strMeaning.length == 0) {
        return Container();
      } else {
        strMeaning = strMeaning.replaceAll("\\", "");
        strMeaning = strMeaning.replaceAll('"', '');
        strMeaning = strMeaning.replaceAll(',', ', ');
        strMeaning = strMeaning.replaceAll('  ', ' ');

        String strClean = strMeaning.replaceAll('|', '');

        var strContents = strMeaning.split("|");

        var strExtra = strContents[0].split(":");

        strMeaning = " ~ " + strExtra[0].trim() + ".";

        if (strContents.length > 1) {
          var strExtra = strContents[1].split(":");
          strMeaning = strMeaning + "\n" + " ~ " + strExtra[0].trim() + ".";
        }

        return Card(
          elevation: 2,
          child: GestureDetector(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Text(strTitle, maxLines: 1, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(strMeaning, maxLines: 2, style: TextStyle(fontSize: 16)),
                ),
                tagViewer(),
              ]
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
  
  Widget tagViewer()
  {
    var synonyms = word.synonyms.split(',');

    if (word.synonyms.length == 0) {
      return Container(padding: const EdgeInsets.only(bottom: 10));
    } else {
      return Container(
        height: 45,
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: synonyms.length,
          itemBuilder: (BuildContext context, int index) {
            return tagView(synonyms[index]);
          },
        ),
      );
    }
  }
  
  Widget tagView(String tagText)
  {
    try {
      if (tagText.isNotEmpty)
      {
        return Container(
          margin: EdgeInsets.only(left: 5),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: new BoxDecoration( 
            color: Provider.of<AppSettings>(context).isDarkMode ? ColorUtils.black : ColorUtils.primaryColor,
            border: Border.all(color: Provider.of<AppSettings>(context).isDarkMode ? ColorUtils.white : ColorUtils.secondaryColor),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text( tagText,style: TextStyle(color: ColorUtils.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        );
    }
    else return Container();      
    } catch (Exception) {
      return Container(); 
    }    
  }

  void navigateToViewer(Word word) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WordView(word);
    }));
  }

}