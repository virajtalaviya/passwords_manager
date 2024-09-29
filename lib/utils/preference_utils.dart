import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static void setBool(String key, bool value) {
    sharedPreferences.setBool(key, value);
  }

  static void setString(String key, String value) {
    sharedPreferences.setString(key, value);
  }

  static bool getBool(String key, [bool? defValue]) {
    return sharedPreferences.getBool(key) ?? defValue ?? false;
  }

  static String getString(String key, [String? defValue]) {
    return sharedPreferences.getString(key) ?? defValue ?? "";
  }
}
