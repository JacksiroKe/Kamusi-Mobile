import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:moovebeta/utils/styles/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../data/models/item.dart';
import 'generic_view.dart';

class AnyItem extends StatelessWidget {
  final String? heroTag;
  final Item? item;
  final String? type;
  final BuildContext? context;

  AnyItem(this.heroTag, this.item, this.type, this.context);
  String? itemBook;

  @override
  Widget build(BuildContext context) {
    String strContent = "<b>" + item!.title + "</b>";
    //String strMeaning = item.meaning;

    try {
      if (item!.meaning.length > 1) {
        strContent = strContent + '<ul>';
        var strContents = item!.meaning.split(";");

        if (strContents.length > 1) {
          try {
            for (int i = 0; i < strContents.length; i++) {
              var strExtra = strContents[i].split(":");
              strContent = strContent + "<li>" + strExtra[0].trim() + "</li>";
            }
          } catch (Exception) {}
        } else {
          var strExtra = strContents[0].split(":");
          strContent = strContent + "<li>" + strExtra[0].trim() + "</li>";
        }
        strContent = strContent + '</ul>';
      }

      return Card(
        elevation: 2,
        child: GestureDetector(
          child: Html(
            data: strContent,
            style: {
              "html": Style(
                fontSize: FontSize(20.0),
              ),
              "ul": Style(
                fontSize: FontSize(18.0),
              ),
              "p": Style(
                fontSize: FontSize(18.0),
                margin: EdgeInsets.only(left: 25, top: 10),
              ),
            },
          ),
          onTap: () {
            navigateToViewer(item!);
          },
        ),
      );
    } catch (Exception) {
      return Container();
    }
  }

  void navigateToViewer(Item item) async {
    await Navigator.push(context!, MaterialPageRoute(builder: (context) {
      return GenericView(item, type!);
    }));
  }

  Widget tagView(String tagText) {
    try {
      if (tagText.isNotEmpty) {
        return Container(
          padding: const EdgeInsets.all(5),
          margin: EdgeInsets.only(top: 5, left: 5),
          decoration: new BoxDecoration(
            color: AppColors.primaryColor,
            border: Border.all(color: AppColors.secondaryColor),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5), bottomLeft: Radius.circular(5)),
          ),
          child: Text(
            tagText,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        );
      } else
        return Container();
    } catch (Exception) {
      return Container();
    }
  }
}
