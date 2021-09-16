import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../cubit/cubit.dart';
import '../../../utils/app_variables.dart';
import '../../../utils/styles/app_colors.dart';

class SearchFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}
