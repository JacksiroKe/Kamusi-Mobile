import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../utils/styles/app_colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KamusiCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = KamusiCubit.get(context);

        return Scaffold(
          extendBody: true,
          body: cubit.tabScreens[cubit.currentIndex],
          bottomNavigationBar: bottomNavContainer(cubit),
          floatingActionButton: FloatingActionButton.extended(
            elevation: 3,
            onPressed: () {
              cubit.changeBottom(1);
            },
            backgroundColor:
                cubit.currentIndex == 1 ? Colors.red : AppColors.activeColor,
            icon: Icon(Icons.help),
            label: Text(
              "MASWALI",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }

  Widget bottomNavContainer(KamusiCubit cubit) {
    return BottomAppBar(
      notchMargin: 3,
      shape: AutomaticNotchedShape(RoundedRectangleBorder(),
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      child: Container(
        margin: EdgeInsets.only(left: 50, right: 50),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                size: 30,
                color:
                    cubit.currentIndex == 0 ? Colors.red : AppColors.baseColor,
              ),
              onPressed: () {
                cubit.changeBottom(0);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person_search_sharp,
                size: 30,
                color:
                    cubit.currentIndex == 2 ? Colors.red : AppColors.baseColor,
              ),
              onPressed: () {
                cubit.changeBottom(2);
              },
            )
          ],
        ),
      ),
    );
  }
}
