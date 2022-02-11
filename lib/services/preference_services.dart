import 'dart:convert';

import 'package:pdp2_ui/model/user_madel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference{
  /// #User Email ...bir dona uchun
  static storeEmail(String email) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
  }

  static Future<String?> loadEmail() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");
    return email;
  }

  static Future<bool> removeEmail() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove("email");
  }

  /// #User Preference ...object uchun
  static storeUser(User user) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringUser = jsonEncode(user);
    prefs.setString("user", stringUser);
  }

  static Future<User?> loadUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringUser = prefs.getString("user");
    if(stringUser == null || stringUser.isEmpty) return null;

    Map<String,dynamic> map = jsonDecode(stringUser);
    return User.fromJson(map);
  }

  static Future<bool> removeUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove("user");
  }

  /// #AccountUser Preference ...object uchun
  static storeAccountUser(AccountUser accountUser) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringUser = jsonEncode(accountUser);
    prefs.setString("accountUser", stringUser);
  }

  static Future<AccountUser?> loadAccountUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringAccountUser = prefs.getString("accountUser");
    if(stringAccountUser == null || stringAccountUser.isEmpty) return null;

    Map<String,dynamic> map = jsonDecode(stringAccountUser);
    return AccountUser.fromJson(map);
  }

  static Future<bool> removeAccountUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove("accountUser");
  }
}