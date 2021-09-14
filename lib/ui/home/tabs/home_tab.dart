import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../ui/generics/any_item.dart';
import '../../../ui/words/word_item.dart';
import '../../../utils/app_variables.dart';
import '../../../utils/conditional_builder.dart';
import '../../../utils/strings/app_strings.dart';
import '../../../utils/styles/app_colors.dart';

// ignore: must_be_immutable
class HomeTab extends StatelessWidget {
  final ScrollController myScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
          child: SafeArea(
            child: mainBody(context),
          ),
        );
      },
    );
  }

  Widget mainBody(BuildContext context) {
    return Column(
      children: <Widget>[
        headerBar(context),
        filterBar(context),
        Container(
          height: MediaQuery.of(context).size.height - 163,
          margin: EdgeInsets.only(top: 5),
          child: contentView(context),
        ),
      ],
    );
  }

  Widget headerBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10),
      decoration: BoxDecoration(color: Colors.transparent),
      child: Row(
        children: <Widget>[
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(AppStrings.appIcon, height: 22, width: 22),
            ),
            onTap: () async {
              //_scaffoldKey.currentState!.openDrawer();
            },
          ),
          Text(
            AppStrings.appName,
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Flexible(child: Container()),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.search, color: Colors.white),
            ),
            onTap: () async {
              /*final List? selected = await showSearch(
                context: context,
                delegate: SearchDelegater(context, searchList),
              );*/
            },
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.menu, color: Colors.white),
            ),
            onTap: () async {
              //_scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ],
      ),
    );
  }

  Widget filterBar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
          ),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: filters.map(
              (filter) {
                final isActive = filter == AppCubit.get(context).activeFilter;
                return InkWell(
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onHover: (focus) =>
                      AppCubit.get(context).onFilterFocus(focus, filter),
                  onFocusChange: (focus) =>
                      AppCubit.get(context).onFilterFocus(focus, filter),
                  onTap: () {
                    AppCubit.get(context).activeFilter = filter;
                    AppCubit.get(context).activeTable =
                        filtersTable[filters.indexOf(filter)];
                    AppCubit.get(context).loadHomeListView();
                  },
                  child: CustomAnimation(
                    startPosition: 0.0,
                    control:
                        AppCubit.get(context).toggles[filters.indexOf(filter)]
                            ? CustomAnimationControl.play
                            : CustomAnimationControl.playReverse,
                    duration: Duration(milliseconds: 280),
                    tween: ColorTween(
                      begin: Colors.transparent,
                      end: Colors.black.withOpacity(0.08),
                    ),
                    builder: (ctx, child, animation) => Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color:
                            isActive ? AppColors.baseColor : Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: isActive ? Colors.black : Colors.transparent,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        filter.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }

  Widget contentView(BuildContext context) {
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
            condition: AppCubit.get(context).words.length != 0 ||
                AppCubit.get(context).items.length != 0,
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
      itemCount: AppCubit.get(context).activeTable == filtersTable[0]
          ? AppCubit.get(context).words.length
          : AppCubit.get(context).items.length,
      itemBuilder: (BuildContext context, int index) {
        return AppCubit.get(context).activeTable == filtersTable[0]
            ? WordItem(
                'WordIndex_' + AppCubit.get(context).words[index].id.toString(),
                AppCubit.get(context).words[index],
                context,
              )
            : AnyItem(
                'ItemIndex_' + AppCubit.get(context).items[index].id.toString(),
                AppCubit.get(context).items[index],
                AppCubit.get(context).activeTable,
                context,
              );
      },
    );
  }
}
