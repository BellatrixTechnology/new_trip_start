import 'dart:convert';

import 'package:new_trip_start/models/users.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const key = "user";

class LocalStorage {
  late SharedPreferences prefs;
  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future setUser(Map<String, dynamic> user) async {
    return await prefs.setString(key, jsonEncode(user));
  }

  Future<NewUserModel?> getUser() async {
    try {
      String user = prefs.getString(key)!;
      return NewUserModel.fromMap(
          await jsonDecode(user) as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }

  Future logout() async {
    return await prefs.remove(key);
  }
}
