import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../cubit/cubit.dart';
import '../../../data/models/models.dart';
import '../../../utils/strings/strings.dart';
import '../../../utils/styles/app_colors.dart';
import '../../generics/general_item.dart';
import '../../words/list/word_item.dart';

// ignore: must_be_immutable
class SearchList extends StatelessWidget {
  final ScrollController myScrollController = ScrollController();
  final List<Word> wordlist;

  SearchList(this.wordlist);
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 60,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: letters.length,
            itemBuilder: lettersList,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 70,
          child: listContainer(context),
        ),
      ],
    );
  }

  Widget lettersList(BuildContext context, int index) {
    return Container(
      height: 60,
      child: GestureDetector(
        onTap: () {
          KamusiCubit.get(context).setSearchingLetter(letters[index]);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 5,
          color: Colors.white,
          child: Hero(
            tag: letters[index],
            child: Container(
              padding: const EdgeInsets.all(2),
              child: Center(
                child: Text(
                  letters[index],
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget listContainer(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      header: WaterDropHeader(),
      controller: refreshController,
      onRefresh: () async {
        KamusiCubit.get(context).loadSearchListView();
        refreshController.refreshCompleted();
      },
      onLoading: () async {
        KamusiCubit.get(context).loadSearchListView();
        refreshController.loadComplete();
        refreshController.refreshCompleted();
      },
      child: listView(context),
    );
  }

  Widget listView(BuildContext context) {
    return ListView.builder(
      controller: myScrollController,
      padding: EdgeInsets.zero,
      itemCount:
          KamusiCubit.get(context).activeSearchTab == searchFiltersTable[0]
              ? wordlist.length
              : KamusiCubit.get(context).items.length,
      itemBuilder: (BuildContext context, int index) {
        return KamusiCubit.get(context).activeSearchTab == searchFiltersTable[0]
            ? WordItem(
                'WordIndex_' + wordlist[index].id.toString(),
                wordlist[index],
                false,
              )
            : GeneralItem(
                'ItemIndex_' +
                    KamusiCubit.get(context).items[index].id.toString(),
                KamusiCubit.get(context).items[index],
                KamusiCubit.get(context).activeSearchTab,
              );
      },
    );
  }
}
