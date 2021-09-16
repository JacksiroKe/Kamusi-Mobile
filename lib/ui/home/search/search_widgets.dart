import 'package:flutter/material.dart';

import '../../../utils/styles/app_colors.dart';

class FavoriteContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        Padding(
          padding: EdgeInsets.all(10),
          child: Divider(),
        ),
      ],
    );
  }
}

class HistoryContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}
