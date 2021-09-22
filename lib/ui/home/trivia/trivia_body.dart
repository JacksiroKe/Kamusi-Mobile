import 'package:flutter/material.dart';

import '../../../utils/strings/strings.dart';
import '../../../utils/styles/app_colors.dart';

class TriviaBody extends StatelessWidget {
  final TextStyle titleStyle =
      TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500);
  final TextStyle subtitleStyle = TextStyle(fontSize: 16, color: Colors.white);

  @override
  Widget build(BuildContext context) {
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
      child: mainBody(context),
    );
  }

  Widget mainBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          appIconName(),
          menuContainer(context),
        ],
      ),
    );
  }

  Widget appIconName() {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(AppStrings.appIcon, height: 20, width: 20),
          ),
          Text(
            AppStrings.appName,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget menuContainer(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.help, size: 50, color: Colors.white),
            title: Text(AppStrings.triviaPage, style: titleStyle),
            subtitle:
                Text(AppStrings.triviaPageDescription, style: subtitleStyle),
            onTap: () {},
          ),
          /*Divider(height: 1, color: Colors.white),
          ListTile(
              leading: Icon(Icons.history, size: 50, color: Colors.white),
              title: Text(AppStrings.triviaList, style: titleStyle),
              subtitle:
                  Text(AppStrings.triviaListDescription, style: subtitleStyle),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TriviaList();
                }));
              }),*/
          Divider(height: 1, color: Colors.white),
          ListTile(
            leading: Icon(Icons.list, size: 50, color: Colors.white),
            title: Text(AppStrings.triviaLeaderboard, style: titleStyle),
            subtitle: Text(AppStrings.triviaLeaderboardDescription,
                style: subtitleStyle),
            onTap: () {},
          ),
          Divider(height: 1, color: Colors.white),
          ListTile(
            leading: Icon(Icons.settings, size: 50, color: Colors.white),
            title: Text(AppStrings.triviaSettings, style: titleStyle),
            subtitle: Text(AppStrings.triviaSettingsDescription,
                style: subtitleStyle),
            onTap: () {},
          ),
          Divider(height: 1, color: Colors.white),
          /*ListTile(
              leading: Icon(Icons.monetization_on_outlined,
                  size: 50, color: ColorUtils.white),
              title: subsTitle,
              subtitle: subsSubtitle,
              tileColor: subsColor,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (sheetContext) => BottomSheet(
                    builder: (_) => TriviaSubscription(),
                    onClosing: () => requestData(),
                  ),
                );
              }),
          Divider(height: 1, color: ColorUtils.white),*/
        ],
      ),
    );
  }
}
