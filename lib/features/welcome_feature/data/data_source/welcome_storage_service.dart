import 'package:shared_preferences/shared_preferences.dart';

class WelcomeStorageService {
  late final SharedPreferences _prefs;

  Future<WelcomeStorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBool(String key, bool value) async =>
      await _prefs.setBool(key, value);

  bool getBool(String key) => _prefs.getBool(key) ?? true;
}
