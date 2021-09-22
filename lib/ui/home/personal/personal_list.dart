import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../cubit/cubit.dart';
import '../../../utils/conditional_builder.dart';
import '../../../utils/strings/strings.dart';
import '../../../widgets/widgets.dart';
import '../../words/list/word.dart';

// ignore: must_be_immutable
class PersonalList extends StatelessWidget {
  final ScrollController myScrollController = ScrollController();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SmartRefresher(
        enablePullDown: true,
        header: WaterDropHeader(),
        controller: refreshController,
        onRefresh: () async {
          KamusiCubit.get(context).loadPersonalListView();
          refreshController.refreshCompleted();
        },
        onLoading: () async {
          KamusiCubit.get(context).loadPersonalListView();
          refreshController.refreshCompleted();
        },
        child: listView(context),
      ),
    );
  }

  Widget listContainer(BuildContext context) {
    return ConditionalBuilder(
      condition: KamusiCubit.get(context).personals.length != 0,
      builder: (context) => listView(context),
      fallback: (context) => Center(
        child: Center(
          child: Container(
            height: 150,
            child: Informer(3, AppStrings.nothing, Colors.red,
                Colors.transparent, Colors.white, 10),
          ),
        ),
      ),
    );
  }

  Widget listView(BuildContext context) {
    return ListView.builder(
      controller: myScrollController,
      padding: EdgeInsets.zero,
      itemCount: KamusiCubit.get(context).personals.length,
      itemBuilder: (BuildContext context, int index) {
        return WordItem(
          'WordIndex_' +
              KamusiCubit.get(context).personals[index].id.toString(),
          KamusiCubit.get(context).personals[index],
          true,
        );
      },
    );
  }
}
