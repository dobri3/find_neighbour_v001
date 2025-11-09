import 'package:shared_preferences/shared_preferences.dart';
import 'package:find_neighbour_v001/models/user.dart';

class TemporaryStorage {
  static const String _keyPrefix = 'temp_';
  static const int _cacheDurationMinutes = 15;

  static Future<void> saveValue(String key, User user) async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    await prefs.setString('${_keyPrefix}value_$key', user.toJsonString());
    await prefs.setInt('${_keyPrefix}time_$key', timestamp);
  }

  static Future<User?> getValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('${_keyPrefix}value_$key');
    final timestamp = prefs.getInt('${_keyPrefix}time_$key');

    if (user == null || timestamp == null) {
      return null;
    }

    final now = DateTime.now().millisecondsSinceEpoch;
    final difference = now - timestamp;
    final minutesPassed = difference / (1000 * 60);

    if (minutesPassed > _cacheDurationMinutes) {
      await prefs.remove('${_keyPrefix}value_$key');
      await prefs.remove('${_keyPrefix}time_$key');
      return null;
    }

    return User.fromJsonString(user);
  }

  static Future<void> clearValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('${_keyPrefix}value_$key');
    await prefs.remove('${_keyPrefix}time_$key');
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
