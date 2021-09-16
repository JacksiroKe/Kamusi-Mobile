import 'package:flutter/material.dart';

import '../../../cubit/cubit.dart';
import '../../generics/general_item.dart';
import '../../words/list/word_item.dart';
import '../../../utils/app_variables.dart';
import '../../../utils/conditional_builder.dart';
import '../../../utils/styles/app_colors.dart';

class SearchList extends StatelessWidget {
  final ScrollController myScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 60,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: letters.length,
            itemBuilder: lettersView,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 70,
          child: ConditionalBuilder(
            condition: KamusiCubit.get(context).words.length != 0 ||
                KamusiCubit.get(context).items.length != 0,
            builder: (context) => itemsBuilder(context),
            fallback: (context) => Center(
              child: Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.baseColor),
                  boxShadow: [BoxShadow(blurRadius: 5)],
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppColors.baseColor),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget lettersView(BuildContext context, int index) {
    return Container(
      height: 60,
      child: GestureDetector(
        onTap: () {
          //setSearchingLetter(letters[index]);
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
                      color: AppColors.secondaryColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget itemsBuilder(BuildContext context) {
    return ListView.builder(
      controller: myScrollController,
      padding: EdgeInsets.zero,
      itemCount: KamusiCubit.get(context).activeTable == filtersTable[0]
          ? KamusiCubit.get(context).words.length
          : KamusiCubit.get(context).items.length,
      itemBuilder: (BuildContext context, int index) {
        return KamusiCubit.get(context).activeTable == filtersTable[0]
            ? WordItem(
                'WordIndex_' +
                    KamusiCubit.get(context).words[index].id.toString(),
                KamusiCubit.get(context).words[index],
              )
            : GeneralItem(
                'ItemIndex_' +
                    KamusiCubit.get(context).items[index].id.toString(),
                KamusiCubit.get(context).items[index],
                KamusiCubit.get(context).activeTable,
              );
      },
    );
  }
}
