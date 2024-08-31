import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManager {
  // Singleton instance
  static final SharedPrefsManager _instance = SharedPrefsManager._internal();

  // Private constructor
  SharedPrefsManager._internal();

  // Factory constructor to return the singleton instance
  factory SharedPrefsManager() {
    return _instance;
  }

  // SharedPreferences instance
  late SharedPreferences _prefs;

  // Initialize the SharedPreferences instance
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Get a value from SharedPreferences
  T? get<T>(String key, T defaultValue) {
    if (_prefs == null) {
      throw Exception("SharedPrefsManager not initialized. Call init() first.");
    }
    if (T == String) {
      return _prefs.getString(key) as T? ?? defaultValue;
    } else if (T == int) {
      return _prefs.getInt(key) as T? ?? defaultValue;
    } else if (T == bool) {
      return _prefs.getBool(key) as T? ?? defaultValue;
    } else if (T == double) {
      return _prefs.getDouble(key) as T? ?? defaultValue;
    } else {
      throw Exception("Unsupported type");
    }
  }

  // Set a value in SharedPreferences
  Future<void> set<T>(String key, T value) async {
    if (_prefs == null) {
      throw Exception("SharedPrefsManager not initialized. Call init() first.");
    }
    if (T == String) {
      await _prefs.setString(key, value as String);
    } else if (T == int) {
      await _prefs.setInt(key, value as int);
    } else if (T == bool) {
      await _prefs.setBool(key, value as bool);
    } else if (T == double) {
      await _prefs.setDouble(key, value as double);
    } else {
      throw Exception("Unsupported type");
    }
  }

  // Remove a value from SharedPreferences
  Future<void> remove(String key) async {
    if (_prefs == null) {
      throw Exception("SharedPrefsManager not initialized. Call init() first.");
    }
    await _prefs.remove(key);
  }

  // Clear all values from SharedPreferences
  Future<void> clear() async {
    if (_prefs == null) {
      throw Exception("SharedPrefsManager not initialized. Call init() first.");
    }
    await _prefs.clear();
  }
}


//await SharedPrefsManager().set('username', 'JohnDoe');
//String username = SharedPrefsManager().get<String>('username', 'defaultUser');
//await SharedPrefsManager().remove('username');
//await SharedPrefsManager().clear();