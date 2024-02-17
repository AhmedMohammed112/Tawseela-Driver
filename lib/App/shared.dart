import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences? sharedPreferences;

  static init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required bool value,
}) async
  {
   return await sharedPreferences!.setBool(key, value);
  }

  static bool ?getData({
    required String key,
  })
  {
    return sharedPreferences!.getBool(key);
  }

  // save Trip Data to shared preferences
  static Future<bool> saveTripData({
    required String value,
  }) async
  {
    return await sharedPreferences!.setString('tripData', value);
  }

  // get Trip Data from shared preferences
  static String ?getTripData()
  {
    return sharedPreferences!.getString('tripData');
  }

  // remove Trip Data from shared preferences
  static Future<bool> removeTripData() async
  {
    return await sharedPreferences!.remove('tripData');
  }

}