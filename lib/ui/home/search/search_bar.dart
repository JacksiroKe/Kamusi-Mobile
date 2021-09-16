import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../../../cubit/cubit.dart';
import '../../../ui/words/list/word.dart';
import '../../../utils/strings/app_strings.dart';
import '../../../utils/styles/app_colors.dart';

class SearchBar extends StatelessWidget {
  final controller = FloatingSearchBarController();
  final ScrollController myScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 2, right: 2),
      child: FloatingSearchBar(
        transitionCurve: Curves.easeInOutCubic,
        title: appIconName(),
        hint: AppStrings.searchNow,
        iconColor: AppColors.baseColor,
        automaticallyImplyBackButton: true,
        controller: controller,
        clearQueryOnClose: true,
        scrollPadding: const EdgeInsets.only(top: 10),
        physics: const BouncingScrollPhysics(),
        onQueryChanged: (query) {
          // Call your model, bloc, controller here.
        },
        transition: CircularFloatingSearchBarTransition(),
        actions: [
          FloatingSearchBarAction(
            showIfOpened: false,
            child: CircularButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ),
          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
          ),
        ],
        builder: (context, _) => searchResults(context),
      ),
    );
  }

  Widget appIconName() {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(AppStrings.appIcon, height: 22, width: 22),
          ),
          Text(
            AppStrings.appName,
            style: TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }

  Widget searchResults(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Material(
        child: Container(
          width: 60,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: KamusiCubit.get(context).words.length,
            itemBuilder: (BuildContext context, int index) {
              return WordItem(
                'WordIndex_' +
                    KamusiCubit.get(context).words[index].id.toString(),
                KamusiCubit.get(context).words[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
