import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  /// Saves UID.
  ///
  /// Saves the [uid] to [SharedPreferences].
  static saveUid(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userUID', uid);
  }

  /// Gets UID.
  ///
  /// Get the [uid] from [SharedPreferences].
  static Future<String> getUid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userUID');
  }

}