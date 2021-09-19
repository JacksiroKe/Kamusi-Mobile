import 'package:flutter/material.dart';

import '../../../data/models/word.dart';
import '../../../ui/words/list/word.dart';
import '../../../utils/strings/strings.dart';
import '../../../utils/styles/app_colors.dart';

class SearchBar extends SearchDelegate<List> {
  List<Word> itemList = [], filtered = [];

  SearchBar(BuildContext context, this.itemList) {
    filtered = itemList;
  }

  @override
  String get searchFieldLabel => AppStrings.searchHint;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      accentIconTheme: IconThemeData(color: Colors.white),
      primaryIconTheme: IconThemeData(color: Colors.white),
      primaryTextTheme: TextTheme(
        headline6: TextStyle(color: Colors.white),
      ),
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: Colors.white),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          filtered = itemList;
          showSuggestions(context);
        },
      ),
      /*IconButton(
        icon: Icon(Provider.of<Settings>(context).isDarkMode ? Icons.brightness_4 : Icons.brightness_7),
        onPressed: () {
          Provider.of<Settings>(context).setDarkMode(Provider.of<Settings>(context).isDarkMode ? true : false);
        },
      ),*/
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, filtered);
      },
    );
  }

  // Function triggered when "ENTER" is pressed.
  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) filterNow();
    return _buildItems(context);
  }

  // Results are displayed if _data is not empty.
  // Display of results changes as users type something in the search field.
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) filterNow();
    return _buildItems(context);
  }

  Widget _buildItems(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.1,
              0.5,
              0.9
            ],
            colors: [
              AppColors.primaryColor,
              AppColors.baseColor,
              Colors.black
            ]),
      ),
      child: ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            return WordItem(
                'ItemSearch_' + filtered[index].id.toString(), filtered[index]);
          }),
    );
  }

  void filterNow() async {
    if (query.isNotEmpty) {
      List<Word> tmpList = [];
      for (int i = 0; i < itemList.length; i++) {
        if (itemList[i].title.toLowerCase().startsWith(query.toLowerCase())
            //|| itemList[i].meaning.toLowerCase().contains(query.toLowerCase())
            ) tmpList.add(itemList[i]);
      }
      filtered = tmpList;
    }
  }
}
