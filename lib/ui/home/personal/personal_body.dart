import 'package:flutter/material.dart';

import '../../../ui/home/personal/personal.dart';
import '../../../utils/strings/strings.dart';
import '../../../utils/styles/app_colors.dart';

class PersonalBody extends StatelessWidget {
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
      child: Column(
        children: <Widget>[
          appIconName(),
          PersonalFilters(),
          bottomContainer(),
        ],
      ),
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
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget bottomContainer() {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: PersonalList(),
      ),
    );
  }
}
