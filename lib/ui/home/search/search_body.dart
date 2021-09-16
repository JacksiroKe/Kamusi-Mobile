import 'package:flutter/material.dart';

import '../../../utils/styles/app_colors.dart';
import 'search.dart';

class SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              searchContainer(),
              bottomContainer(context),
            ],
          ),
          SearchBar(),
        ],
      ),
    );
  }

  Widget searchContainer() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
      padding: EdgeInsets.only(top: 50, bottom: 3),
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
      child: SearchFilters(),
    );
  }

  Widget bottomContainer(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: Stack(
          children: [
            SearchList(),
            Container(
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  footerContainer(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget footerContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          FavoriteContainer(),
          HistoryContainer(),
        ],
      ),
    );
  }
}
