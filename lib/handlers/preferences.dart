import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static saveUid(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userUID', uid);
  }

  static Future<String> getUid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userUID');
  }

}