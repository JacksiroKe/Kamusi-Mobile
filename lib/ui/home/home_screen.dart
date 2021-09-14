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
          bottomNavigationBar: navigationContainer(cubit),
        );
      },
    );
  }

  Widget navigationContainer(KamusiCubit cubit) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.activeColor,
      onTap: (index) {
        cubit.changeBottom(index);
      },
      currentIndex: cubit.currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'Nyumbani',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.star,
          ),
          label: 'Vipendwa',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.history,
          ),
          label: 'Historia',
        ),
      ],
    );
  }
}
