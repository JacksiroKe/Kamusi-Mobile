import 'package:flutter/material.dart';

import '../../../utils/styles/app_colors.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}
