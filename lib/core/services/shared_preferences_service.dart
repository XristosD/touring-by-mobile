import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';



class SharedPreferencesService {


  Future<bool> storeJson(String key, Map<String, dynamic> value) async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    String strValue = jsonEncode(value);
    bool success = await shared.setString(key, strValue);
    return success;
  }

  Future<Map<String, dynamic>> getJson(String key) async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonValue;
    if( shared.containsKey(key)){
      String jsonString = shared.getString(key);
      jsonValue = jsonString == null ? null : jsonDecode(jsonString);
    }

    return jsonValue;
  }
}