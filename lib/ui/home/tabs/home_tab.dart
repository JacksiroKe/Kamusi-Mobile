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
    return BlocConsumer<KamusiCubit, AppStates>(
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
        searchBar(context),
        filterBar(context),
        bodyContainer(context),
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
              child: Icon(Icons.menu, color: Colors.white),
            ),
            onTap: () async {
              //_scaffoldKey.currentState!.openEndDrawer();
            },
          ),
          Flexible(child: Container()),
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
              child: Icon(Icons.notifications, color: Colors.white),
            ),
            onTap: () async {
              /*final List? selected = await showSearch(
                context: context,
                delegate: SearchDelegater(context, searchList),
              );*/
            },
          ),
        ],
      ),
    );
  }

  Widget searchBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Material(
        borderRadius: BorderRadius.circular(5),
        elevation: 5,
        child: Container(
          child: TextFormField(
            cursorColor: AppColors.baseColor,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(5),
              prefixIcon:
                  Icon(Icons.search, color: AppColors.baseColor, size: 30),
              suffixIcon:
                  Icon(Icons.clear, color: AppColors.baseColor, size: 30),
              hintText: 'Tafuta maneno, nahau, misemo, methali',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget filterBar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
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
                final isActive =
                    filter == KamusiCubit.get(context).activeFilter;
                return InkWell(
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onHover: (focus) =>
                      KamusiCubit.get(context).onFilterFocus(focus, filter),
                  onFocusChange: (focus) =>
                      KamusiCubit.get(context).onFilterFocus(focus, filter),
                  onTap: () {
                    KamusiCubit.get(context).activeFilter = filter;
                    KamusiCubit.get(context).activeTable =
                        filtersTable[filters.indexOf(filter)];
                    KamusiCubit.get(context).loadHomeListView();
                  },
                  child: CustomAnimation(
                    startPosition: 0.0,
                    control: KamusiCubit.get(context)
                            .toggles[filters.indexOf(filter)]
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

  Widget bodyContainer(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: Stack(
          children: [
            listContainer(context),
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
          vipendwaContainer(),
          historiaContainer(),
        ],
      ),
    );
  }

  Widget vipendwaContainer() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: Row(
            children: [
              Text(
                'VIPENDWA',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.baseColor,
                ),
              ),
              Spacer(flex: 2),
              Text(
                'Orodha yote',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.baseColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 50,
        ),
      ],
    );
  }

  Widget historiaContainer() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: Row(
            children: [
              Text(
                'HISTORIA',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.baseColor,
                ),
              ),
              Spacer(flex: 2),
              Text(
                'Orodha yote',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.baseColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 50,
        ),
      ],
    );
  }

  Widget listContainer(BuildContext context) {
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
                context,
              )
            : AnyItem(
                'ItemIndex_' +
                    KamusiCubit.get(context).items[index].id.toString(),
                KamusiCubit.get(context).items[index],
                KamusiCubit.get(context).activeTable,
                context,
              );
      },
    );
  }
}
