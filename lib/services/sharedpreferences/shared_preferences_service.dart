import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;

  SharedPreferencesService(this._preferences);

  Future<void> saveSharePreferences(String key, dynamic value) async {
    try {
      switch (value) {
        case bool():
          await _preferences.setBool(key, value);
        case int():
          await _preferences.setInt(key, value);
        case double():
          await _preferences.setDouble(key, value);
        case String():
          await _preferences.setString(key, value);
        case List<String>():
          await _preferences.setStringList(key, value);
        default:
          throw Exception("Unsupported data type for SharedPreferences");
      }
    } catch (e) {
      throw Exception("Failed to save shared preferences: $e");
    }
  }

  dynamic getSharedPreferencesValue(String key) {
    try {
      if (_preferences.containsKey(key)) {
        return _preferences.get(key);
      }
      return null;
    } catch (e) {
      throw Exception("Failed to get shared preferences: $e");
    }
  }
}
