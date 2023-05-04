import 'package:shared_preferences/shared_preferences.dart';

class AppPersistentStore {
  static Future<SharedPreferences> initialize() async => _sharedPreferences = await SharedPreferences.getInstance();

  static const String _key = 'id';
  static const String _keyRol = 'rol';
  static const String _keyState = 'state';
  static late SharedPreferences _sharedPreferences;

  static Future<bool> setUserId(String id) async {
    return await _sharedPreferences.setString(_key, id);
  }

  static String? getUserId() {
    return _sharedPreferences.getString(_key);
  }

  static Future<bool> setUserRol(String rol) async {
    return await _sharedPreferences.setString(_keyRol, rol);
  }

  static String? getUserRol() {
    return _sharedPreferences.getString(_keyRol);
  }
  static Future<bool> setUserState(String state) async {
    return await _sharedPreferences.setString(_keyState, state);
  }

  static String? getUserState() {
    return _sharedPreferences.getString(_keyState);
  }

  static Future<bool> clear() async {
    return await _sharedPreferences.clear();
  }
}
