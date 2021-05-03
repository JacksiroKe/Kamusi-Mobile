import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/app_settings.dart';
import '../data/models/word.dart';
import '../utils/app_utils.dart';
import '../utils/colors.dart';
import '../widgets/word_item.dart';

class AppSearchDelegate extends SearchDelegate<List> {

	List<Word> itemList, filtered;

	AppSearchDelegate(BuildContext context, this.itemList) {
    filtered = itemList;
  }

  @override
  String get searchFieldLabel => AppStrings.searchHint;

	@override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
			primaryColor: Provider.of<AppSettings>(context).isDarkMode ? ColorUtils.black : ColorUtils.primaryColor,
			accentIconTheme: IconThemeData(color: ColorUtils.white),
			primaryIconTheme: IconThemeData(color: ColorUtils.white),
      primaryTextTheme: TextTheme(
				headline6: TextStyle(
          color: ColorUtils.white
				),
			),
			textTheme: TextTheme(
				headline6: TextStyle(
					color: ColorUtils.white
				),
			),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
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
        icon: Icon(Provider.of<AppSettings>(context).isDarkMode ? Icons.brightness_4 : Icons.brightness_7),
        onPressed: () {
          Provider.of<AppSettings>(context).setDarkMode(Provider.of<AppSettings>(context).isDarkMode ? true : false);
        },
      ),*/
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
		return IconButton(
			icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
			onPressed: () {
				close(context, null);
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
      decoration: Provider.of<AppSettings>(context).isDarkMode ? BoxDecoration(color: Colors.black)
          : BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.1,
                  0.5,
                  0.9
                ],
                colors: [
                  ColorUtils.primaryColor,
                  ColorUtils.baseColor,
                  ColorUtils.black
                ]
            ),
          ),
      child: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          return WordItem('ItemSearch_' + filtered[index].id.toString(), filtered[index], context);
        }
      ),
    );
  }

  void filterNow() async {
    if (query.isNotEmpty)
    {
      List<Word> tmpList = [];
      for(int i = 0; i < itemList.length; i++) {        
        if (
          itemList[i].title.toLowerCase().startsWith(query.toLowerCase())
          //|| itemList[i].meaning.toLowerCase().contains(query.toLowerCase())
        ) tmpList.add(itemList[i]);
      }
      filtered = tmpList;
    }
  }
  
}
