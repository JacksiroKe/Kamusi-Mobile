import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/app_settings.dart';
import '../../../utils/colors.dart';
import '../../../utils/app_utils.dart';
import '../../widgets/as_text_view.dart';
import 'trivia_screen.dart';
import 'trivia_list.dart';
import 'trivia_subscription.dart';

class TriviaMenu extends StatefulWidget {
  @override
  TriviaMenuState createState() => TriviaMenuState();
}

class TriviaMenuState extends State<TriviaMenu> {
  AsTextView subsTitle = AsTextView.setUp(AppStrings.triviaSettings, 18, true,
      ColorUtils.white, Colors.transparent);
  AsTextView subsSubtitle = AsTextView.setUp(
      AppStrings.gettingReady, 16, false, ColorUtils.white, Colors.transparent);
  Color subsColor = Colors.transparent;

  final TextStyle titleStyle = TextStyle(
      fontSize: 18, color: ColorUtils.white, fontWeight: FontWeight.w500);
  final TextStyle subtitleStyle =
      TextStyle(fontSize: 16, color: ColorUtils.white);
  bool isSubscribed = false;
  String subscriptionMode = "";

  @override
  void initState() {
    super.initState();
    initBuild(context);
  }

  /// Run anything that needs to be run immediately after Widget build
  void initBuild(BuildContext context) async {
    requestData();
  }

  void requestData() async {
    /*isSubscribed = await Preferences.isAppTriviaSubscribed();
    subscriptionMode = await Preferences.getSharedPreferenceStr(
        SharedPreferenceKeys.triviaSubscriptionMode);

    setState(() {
      if (isSubscribed != null) {
        String mode = AppStrings.subscription3months;
        if (subscriptionMode == "P6M")
          mode = AppStrings.subscription6months;
        else if (subscriptionMode == "P1Y") mode = AppStrings.subscription1year;

        subsTitle.setText(AppStrings.triviaSubscription);
        subsSubtitle.setText(mode);
        subsColor = Colors.transparent;
      } else {
        subsTitle.setText(AppStrings.triviaSubscription);
        subsSubtitle.setText(AppStrings.triviaSubscribe);
        subsColor = Colors.red;
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.triviaTitle),
      ),
      body: mainBody(),
    );
  }

  Widget mainBody() {
    return Container(
      decoration: Provider.of<AppSettings>(context).isDarkMode
          ? BoxDecoration()
          : BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.1,
                    0.4,
                    0.6,
                    0.9
                  ],
                  colors: [
                    ColorUtils.black,
                    ColorUtils.baseColor,
                    ColorUtils.primaryColor,
                    ColorUtils.lightColor
                  ]),
            ),
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.help, size: 50, color: ColorUtils.white),
            title: Text(AppStrings.triviaPage, style: titleStyle),
            subtitle:
                Text(AppStrings.triviaPageDescription, style: subtitleStyle),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return TriviaScreen();
                  },
                ),
              );
            },
          ),
          /*Divider(height: 1, color: ColorUtils.white),
          ListTile(
              leading: Icon(Icons.history, size: 50, color: ColorUtils.white),
              title: Text(AppStrings.triviaList, style: titleStyle),
              subtitle:
                  Text(AppStrings.triviaListDescription, style: subtitleStyle),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TriviaList();
                }));
              }),*/
          Divider(height: 1, color: ColorUtils.white),
          ListTile(
            leading: Icon(Icons.list, size: 50, color: ColorUtils.white),
            title: Text(AppStrings.triviaLeaderboard, style: titleStyle),
            subtitle: Text(AppStrings.triviaLeaderboardDescription,
                style: subtitleStyle),
            onTap: () {},
          ),
          Divider(height: 1, color: ColorUtils.white),
          ListTile(
            leading: Icon(Icons.settings, size: 50, color: ColorUtils.white),
            title: Text(AppStrings.triviaSettings, style: titleStyle),
            subtitle: Text(AppStrings.triviaSettingsDescription,
                style: subtitleStyle),
            onTap: () {},
          ),
          Divider(height: 1, color: ColorUtils.white),
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
