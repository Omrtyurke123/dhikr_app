import 'package:shared_preferences/shared_preferences.dart';

class AppLockService {
  static const String _lockedAppsKey = 'locked_apps';
  static const String _lockEnabledKey = 'lock_enabled';

  static Future<bool> isLockEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_lockEnabledKey) ?? false;
  }

  static Future<void> setLockEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_lockEnabledKey, enabled);
  }

  static Future<List<String>> getLockedApps() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_lockedAppsKey) ?? [];
  }

  static Future<void> setLockedApps(List<String> apps) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_lockedAppsKey, apps);
  }

  static Future<void> addLockedApp(String packageName) async {
    final apps = await getLockedApps();
    if (!apps.contains(packageName)) {
      apps.add(packageName);
      await setLockedApps(apps);
    }
  }

  static Future<void> removeLockedApp(String packageName) async {
    final apps = await getLockedApps();
    apps.remove(packageName);
    await setLockedApps(apps);
  }
}
