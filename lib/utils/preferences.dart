//This files manages shared preferences of the app

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_utils.dart';

class Preferences {
  static Future<SharedPreferences> getInstance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<String> getSharedPreferenceStr(String prefKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(prefKey);
  }

  static Future<void> setSharedPreferenceStr(
      String prefKey, String prefValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(prefKey, prefValue);
  }

  static Future<int> getSharedPreferenceInt(String prefKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(prefKey ?? 0);
  }

  static Future<void> setSharedPreferenceInt(
      String prefKey, int prefValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(prefKey, prefValue);
  }

  static Future<bool> isAppDatabaseLoaded() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPreferenceKeys.appDatabaseLoaded);
  }

  static Future<void> setKamusidbLoaded(bool isAppDatabaseLoaded) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(
        SharedPreferenceKeys.appDatabaseLoaded, isAppDatabaseLoaded);
  }

  static Future<bool> isAppTriviaSubscribed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPreferenceKeys.triviaSubscribed);
  }

  static Future<void> setAppTriviaSubscribed(bool isAppTriviaSubscribed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(
        SharedPreferenceKeys.triviaSubscribed, isAppTriviaSubscribed);
  }
}
