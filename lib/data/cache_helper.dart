import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/callbacks/callbacks.dart';
import '../utils/strings/strings.dart';

class CacheHelper {
  static Future<SharedPreferences> getInstance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<bool?> getPrefBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<void> setPrefBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<String?> getPrefStr(String prefKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(prefKey);
  }

  static Future<User?> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return User.fromJson(json.decode(prefs.getString(SharedPrefKeys.appUser)!));
  }

  static Future<void> setUserProfile(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userProfileJson = json.encode(user);
    prefs.setString(SharedPrefKeys.appUser, userProfileJson);
  }
}
