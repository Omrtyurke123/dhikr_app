import 'package:flutter/services.dart';

/// AppLockService handles the communication between Flutter and native Android
/// to lock/unlock apps using the Accessibility Service.
/// 
/// On iOS, app locking via third-party apps is not possible due to sandbox restrictions.
/// This feature is Android-only.
class AppLockService {
  static const MethodChannel _channel = MethodChannel('com.dhikrapp/app_lock');

  /// Check if the Accessibility Service is enabled
  static Future<bool> isAccessibilityEnabled() async {
    try {
      final bool result = await _channel.invokeMethod('isAccessibilityEnabled');
      return result;
    } catch (e) {
      return false;
    }
  }

  /// Open Android Accessibility Settings so user can enable the service
  static Future<void> openAccessibilitySettings() async {
    try {
      await _channel.invokeMethod('openAccessibilitySettings');
    } catch (e) {
      // Handle error
    }
  }

  /// Lock the specified list of apps (by package name)
  static Future<bool> lockApps(List<String> packageNames) async {
    try {
      final bool result = await _channel.invokeMethod('lockApps', {
        'packages': packageNames,
      });
      return result;
    } catch (e) {
      return false;
    }
  }

  /// Unlock all previously locked apps
  static Future<bool> unlockApps() async {
    try {
      final bool result = await _channel.invokeMethod('unlockApps');
      return result;
    } catch (e) {
      return false;
    }
  }

  /// Request PACKAGE_USAGE_STATS permission (needed to read foreground apps)
  static Future<bool> requestUsageStatsPermission() async {
    try {
      final bool result = await _channel.invokeMethod('requestUsageStatsPermission');
      return result;
    } catch (e) {
      return false;
    }
  }

  /// Check if SYSTEM_ALERT_WINDOW permission is granted (to show overlay)
  static Future<bool> canDrawOverlays() async {
    try {
      final bool result = await _channel.invokeMethod('canDrawOverlays');
      return result;
    } catch (e) {
      return false;
    }
  }
}
