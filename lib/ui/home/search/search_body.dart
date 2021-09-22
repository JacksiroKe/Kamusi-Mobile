import 'package:flutter/material.dart';

import '../../../cubit/cubit.dart';
import '../../../data/models/models.dart';
import '../../../utils/conditional_builder.dart';
import '../../../utils/styles/app_colors.dart';
import 'search.dart';

// ignore: must_be_immutable
class SearchBody extends StatelessWidget {
  List<Word> wordlist = [];

  @override
  Widget build(BuildContext context) {
    wordlist = KamusiCubit.get(context).words;

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
      child: mainBody(context),
    );
  }

  Widget mainBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          searchContainer(),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              child: SearchList(wordlist),
            ),
          ),
          footerContainer(context),
        ],
      ),
    );
  }

  Widget searchContainer() {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        children: <Widget>[
          SearchHeader(wordlist),
          SearchFilters(),
        ],
      ),
    );
  }

  Widget footerContainer(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ConditionalBuilder(
            condition: KamusiCubit.get(context).histories.length != 0,
            builder: (context) {
              return HistoryContainer();
            },
            fallback: (context) {
              return Container();
            },
          ),
          ConditionalBuilder(
            condition: KamusiCubit.get(context).favorites.length != 0,
            builder: (context) {
              return FavoriteContainer();
            },
            fallback: (context) {
              return Container();
            },
          )
        ],
      ),
    );
  }
}
