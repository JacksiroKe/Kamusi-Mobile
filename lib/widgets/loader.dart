import 'package:flutter/material.dart';
import 'package:kamusi/utils/styles/app_colors.dart';

// ignore: must_be_immutable
class Loader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}
