import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../../../cubit/cubit.dart';
import '../../../data/models/trivia_cat.dart';
import '../../../utils/strings/strings.dart';
import '../../../utils/styles/app_colors.dart';
import 'trivia_options.dart';

class TriviaCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: WaveClipperTwo(),
          child: Container(
            decoration: BoxDecoration(color: AppColors.primaryColor),
            height: 200,
          ),
        ),
        CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                child: Text(
                  AppStrings.triviaPageInstruction,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width > 1000
                          ? 7
                          : MediaQuery.of(context).size.width > 600
                              ? 5
                              : 3,
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0),
                  delegate: SliverChildBuilderDelegate(
                    categoryItem,
                    childCount: KamusiCubit.get(context).categories.length,
                  )),
            ),
          ],
        ),
      ],
    );
  }

  Widget categoryItem(BuildContext context, int index) {
    TriviaCat category = KamusiCubit.get(context).categories[index];
    return GestureDetector(
      onTap: () {
        categoryPressed(context, category);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(55),
            ),
            elevation: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(55),
              child: FadeInImage(
                image: NetworkImage(ApiConstants.baseUrl + category.icon!),
                placeholder: AssetImage(AppStrings.appIcon),
                height: 55,
                width: 55,
                fit: BoxFit.cover,
              ),
            ),
          ),
          AutoSizeText(
            category.title!,
            textAlign: TextAlign.center,
            maxLines: 1,
            wrapWords: false,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  categoryPressed(BuildContext context, TriviaCat category) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => BottomSheet(
        builder: (_) => TriviaOptions(category),
        onClosing: () {},
      ),
    );
  }
}
