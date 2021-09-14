import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../utils/styles/app_colors.dart';

class FavoriteTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KamusiCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.baseColor,
          ),
          child: Center(
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
        );
      },
    );
  }
}
