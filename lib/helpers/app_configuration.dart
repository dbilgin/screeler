import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class AppConfiguration {
  static dynamic getAppConfigs() async {
    return jsonDecode(await rootBundle.loadString('assets/app_config.json'));
  }
}