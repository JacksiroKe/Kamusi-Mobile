import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sqflite/sqflite.dart';

import '../data/callbacks/callbacks.dart';
import '../data/app_database.dart';
import '../data/asset_database.dart';
import '../data/cache_helper.dart';
import '../utils/strings/strings.dart';
import '../utils/styles/app_colors.dart';
import 'home/home_screen.dart';

class InitLoadScreen extends StatefulWidget {
  final FlutterLocalNotificationsPlugin appNotifications;
  InitLoadScreen(this.appNotifications);

  @override
  State<StatefulWidget> createState() {
    return InitLoadState(this.appNotifications);
  }
}

class InitLoadState extends State<InitLoadScreen> {
  final globalKey = new GlobalKey<ScaffoldState>();
  InitLoadState(this.appNotifications);
  FlutterLocalNotificationsPlugin appNotifications;

  AppDatabase appDB = AppDatabase();
  AssetDatabase assetDB = AssetDatabase();

  List<WordCallback> words = [];
  List<ItemCallback> idiomsList = [], sayingsList = [], proverbsList = [];

  late Future<Database> dbAssets, dbFuture;

  @override
  Widget build(BuildContext context) {
    new Future.delayed(const Duration(seconds: 3), goToHomeScreen);
    return Scaffold(
      key: globalKey,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: mainBody(),
      ),
    );
  }

  Widget mainBody() {
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

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'kamusi_notification',
      'Kamusi ya Kiswahili',
      'Kamusi ya Kiswahili',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('slow_spring_board'),
    );
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: 'slow_spring_board.aiff');
    const MacOSNotificationDetails macOSPlatformChannelSpecifics =
        MacOSNotificationDetails(sound: 'slow_spring_board.aiff');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
      macOS: macOSPlatformChannelSpecifics,
    );
    await appNotifications.show(
      0,
      'Inapakia maneno, nahau, misemo na methali',
      '',
      platformChannelSpecifics,
    );
  }

  Future<void> goToHomeScreen() async {
    showNotification();
    CacheHelper.setPrefBool(SharedPrefKeys.isDatabaseLoaded, true);
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(
        builder: (context) => new HomeScreen(),
      ),
    );
  }
}
