import 'package:flutter/material.dart';
import 'package:kamusi/cubit/cubit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../ui/trivia/trivia.dart';
import '../../../utils/strings/strings.dart';
import '../../../utils/styles/app_colors.dart';
import 'cats/trivia.dart';

// ignore: must_be_immutable
class TriviaBody extends StatelessWidget {
  final ScrollController myScrollController = ScrollController();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

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
          TriviaFilters(),
          contentBody(context),
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

  Widget contentBody(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: SmartRefresher(
          enablePullDown: true,
          header: WaterDropHeader(),
          controller: refreshController,
          onRefresh: () async {
            KamusiCubit.get(context).loadTriviaView();
            refreshController.refreshCompleted();
          },
          onLoading: () async {
            KamusiCubit.get(context).loadTriviaView();
            refreshController.refreshCompleted();
          },
          child: TriviaCategories(),
        ),
      ),
    );
  }
}
