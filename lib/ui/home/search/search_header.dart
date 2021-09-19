import 'package:flutter/material.dart';

import '../../../data/models/word.dart';
import '../../../utils/strings/app_strings.dart';
import 'search.dart';

// ignore: must_be_immutable
class SearchHeader extends StatelessWidget {
  final List<Word> wordlist;

  SearchHeader(this.wordlist);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 45,
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            appIconName(),
            Padding(
              padding: EdgeInsets.all(5),
              child: Icon(Icons.search),
            )
          ],
        ),
      ),
      onTap: () async {
        await showSearch(
          context: context,
          delegate: SearchBar(context, wordlist),
        );
      },
    );
  }

  Widget appIconName() {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(AppStrings.appIcon, height: 20, width: 20),
          ),
          Text(
            AppStrings.appName,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
