import 'package:flutter/material.dart';

import '../../../cubit/cubit.dart';
import '../../../utils/strings/strings.dart';
import '../../../utils/styles/app_colors.dart';

class TriviaFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 5, bottom: 10, left: 5, right: 5),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: wrapperContainer(context),
      ),
    );
  }

  Widget wrapperContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: triviaFilters.map(
          (filter) {
            final isActive =
                filter == KamusiCubit.get(context).activeTriviaFilter;
            return filterItem(context, isActive, filter);
          },
        ).toList(),
      ),
    );
  }

  Widget filterItem(BuildContext context, bool isActive, String filter) {
    return InkWell(
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onHover: (focus) =>
          KamusiCubit.get(context).onTriviaFilterFocus(focus, filter),
      onFocusChange: (focus) =>
          KamusiCubit.get(context).onTriviaFilterFocus(focus, filter),
      onTap: () {
        KamusiCubit.get(context).activeTriviaFilter = filter;
        KamusiCubit.get(context).activeTriviaTab =
            personalFilters[personalFilters.indexOf(filter)];
        KamusiCubit.get(context).loadTriviaView();
      },
      child: filterContainer(isActive, filter),
    );
  }

  Widget filterContainer(bool isActive, String filter) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isActive ? AppColors.baseColor : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: filterText(isActive, filter),
    );
  }

  Widget filterText(bool isActive, String filter) {
    return Text(
      filter.toUpperCase(),
      style: TextStyle(
        color: isActive ? Colors.white : AppColors.baseColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
