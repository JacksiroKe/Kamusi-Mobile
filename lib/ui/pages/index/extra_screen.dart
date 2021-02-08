import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../utils/app_utils.dart';
import '../../pages/trivia/trivia_screen.dart';
import '../../pages/trivia/trivia_list.dart';
import '../../../services/app_settings.dart';

class ExtraScreen extends StatefulWidget {
  @override
  ExtraScreenState createState() => ExtraScreenState();
}

class ExtraScreenState extends State<ExtraScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initBuild(context));
  }

  /// Run anything that needs to be run immediately after Widget build
  void initBuild(BuildContext context) async {
   
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

  Widget mainBody()
  {
    final TextStyle titleStyle = TextStyle(
      fontSize: 18, color: ColorUtils.white, 
      fontWeight: FontWeight.w500
    );
    final TextStyle subtitleStyle = TextStyle(
      fontSize: 16, color: ColorUtils.white, 
    );

    return Container(
      decoration: Provider.of<AppSettings>(context).isDarkMode ? BoxDecoration()
    : BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [ 0.1, 0.4, 0.6, 0.9 ],
          colors: [ ColorUtils.black, ColorUtils.baseColor,  ColorUtils.primaryColor, ColorUtils.lightColor ]),
      ),
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.help, size: 50, color: ColorUtils.white),
            title: Text(AppStrings.triviaPage, style: titleStyle),
            subtitle: Text(AppStrings.triviaPageDescription, style: subtitleStyle),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TriviaScreen();
                })
              );
            }
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.history, size: 50, color: ColorUtils.white),
            title: Text(AppStrings.triviaList, style: titleStyle),
            subtitle: Text(AppStrings.triviaListDescription, style: subtitleStyle),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TriviaList();
                })
              );
            }
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.list, size: 50, color: ColorUtils.white),
            title: Text(AppStrings.triviaLeaderboard, style: titleStyle),
            subtitle: Text(AppStrings.triviaLeaderboardDescription, style: subtitleStyle),
            onTap: () {
              
            }
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings, size: 50, color: ColorUtils.white),
            title: Text(AppStrings.triviaSettings, style: titleStyle),
            subtitle: Text(AppStrings.triviaSettingsDescription, style: subtitleStyle),
            onTap: () {
              
            }
          ),
          Divider(),
        ],
      ),
    );
  }
  
}
