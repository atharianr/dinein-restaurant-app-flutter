import 'package:flutter/material.dart';
import 'package:restaurant_app/constants/constants.dart';

import '../../services/sharedpreferences/shared_preferences_service.dart';

class SettingsProvider extends ChangeNotifier {
  final SharedPreferencesService _service;

  SettingsProvider(this._service) {
    _getDarkModeSettingsValue();
    _getNotificationSettingsValue();
  }

  String _message = "";

  String get message => _message;

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  bool _isNotificationEnabled = false;

  bool get isNotificationEnabled => _isNotificationEnabled;

  // Dark Mode
  Future<void> saveDarkModeSettings(bool value) async {
    try {
      await _service.saveSharePreferences(Constants.keyDarkMode, value);
      _isDarkMode = value;
      _message = "Your data is saved";
    } catch (e) {
      _message = "Failed to save your data";
    }
    notifyListeners();
  }

  Future<void> _getDarkModeSettingsValue() async {
    try {
      _isDarkMode = _service.getSharedPreferencesValue(Constants.keyDarkMode);
      _message = "Data successfully retrieved";
    } catch (e) {
      _message = "Failed to get your data";
    }
    notifyListeners();
  }

  // Notification
  Future<void> saveNotificationSettings(bool value) async {
    try {
      await _service.saveSharePreferences(Constants.keyNotification, value);
      _isNotificationEnabled = value;
      _message = "Your data is saved";
    } catch (e) {
      _message = "Failed to save your data";
    }
    notifyListeners();
  }

  Future<void> _getNotificationSettingsValue() async {
    try {
      _isNotificationEnabled =
          _service.getSharedPreferencesValue(Constants.keyNotification);
      _message = "Data successfully retrieved";
    } catch (e) {
      _message = "Failed to get your data";
    }
    notifyListeners();
  }
}
