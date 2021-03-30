import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/app_settings.dart';
import '../utils/app_utils.dart';
import '../views/info/about_screen.dart';
import '../views/info/donate_screen.dart';
import '../views/info/help_desk_screen.dart';
import '../views/info/howto_use_screen.dart';

class NavDrawer extends StatefulWidget {
  @override
  createState() => NavDrawerState();
}

class NavDrawerState extends State<NavDrawer> {
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    didChangeDependencies();

    return ListView(
      children: <Widget>[
        drawerHeader(),
        Consumer<AppSettings>(builder: (context, AppSettings settings, _) {
          return ListTile(
            onTap: () {},
            leading: Icon(settings.isDarkMode ? Icons.brightness_4 : Icons.brightness_7),
            title: Text(AppStrings.darkMode),
            trailing: Switch(
              onChanged: (bool value) => settings.setDarkMode(value),
              value: settings.isDarkMode,
            ),
          );
        }),
        ListTile(
          leading: Icon(Icons.card_membership),
          title: Text(AppStrings.donateTabPage),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DonateScreen();
             })
            );
          }
        ),
        Divider(),        
        ListTile(
          leading: Icon(Icons.help),
          title: Text(AppStrings.helpTabPage),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HelpDeskScreen();
             })
            );
          }
        ),
        ListTile(
          leading: Icon(Icons.info),
          title: Text(AppStrings.howToUse),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HowtoUseScreen();
             })
            );
          }
        ),
        ListTile(
          leading: Icon(Icons.info),
          title: Text(AppStrings.aboutApp),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AboutScreen();
             })
            );
          }
        ),
      ],
    );
  }

  Widget drawerHeader() {
    return UserAccountsDrawerHeader(
      accountName: Text(AppStrings.appName + AppStrings.appVersion),
      accountEmail: Text(AppStrings.appSlogan),
      currentAccountPicture: CircleAvatar(
        child: Image(
          image: AssetImage(AppStrings.appIcon),
          height: 75,
          width: 75,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
