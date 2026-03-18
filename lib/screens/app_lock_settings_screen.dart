import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../theme/app_theme.dart';

// قائمة التطبيقات الشائعة
final List<Map<String, String>> popularApps = [
  {'name': 'يوتيوب', 'package': 'com.google.android.youtube', 'icon': '▶️'},
  {'name': 'إنستجرام', 'package': 'com.instagram.android', 'icon': '📸'},
  {'name': 'تيك توك', 'package': 'com.zhiliaoapp.musically', 'icon': '🎵'},
  {'name': 'تويتر/X', 'package': 'com.twitter.android', 'icon': '🐦'},
  {'name': 'فيسبوك', 'package': 'com.facebook.katana', 'icon': '👍'},
  {'name': 'سناب شات', 'package': 'com.snapchat.android', 'icon': '👻'},
  {'name': 'واتساب', 'package': 'com.whatsapp', 'icon': '💬'},
  {'name': 'تيليجرام', 'package': 'org.telegram.messenger', 'icon': '✈️'},
  {'name': 'نتفليكس', 'package': 'com.netflix.mediaclient', 'icon': '🎬'},
  {'name': 'جوجل كروم', 'package': 'com.android.chrome', 'icon': '🌐'},
];

class AppLockSettingsScreen extends StatefulWidget {
  const AppLockSettingsScreen({super.key});

  @override
  State<AppLockSettingsScreen> createState() => _AppLockSettingsScreenState();
}

class _AppLockSettingsScreenState extends State<AppLockSettingsScreen> {
  List<String> _lockedApps = [];
  bool _lockEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lockEnabled = prefs.getBool('lock_enabled') ?? false;
      final json = prefs.getString('locked_apps');
      if (json != null) {
        _lockedApps = List<String>.from(jsonDecode(json));
      }
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('lock_enabled', _lockEnabled);
    await prefs.setString('locked_apps', jsonEncode(_lockedApps));
  }

  void _toggleApp(String package) {
    setState(() {
      if (_lockedApps.contains(package)) {
        _lockedApps.remove(package);
      } else {
        _lockedApps.add(package);
      }
    });
    _saveSettings();
  }

  void _toggleLock(bool value) {
    setState(() => _lockEnabled = value);
    _saveSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('قفل التطبيقات')),
      body: Column(
        children: [
          // تفعيل القفل
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _lockEnabled
                    ? AppTheme.accentGreen
                    : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                const Text('🔒', style: TextStyle(fontSize: 28)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'تفعيل قفل التطبيقات',
                        style: TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'يجب تفعيل خدمة إمكانية الوصول من الإعدادات',
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _lockEnabled,
                  onChanged: _toggleLock,
                  activeColor: AppTheme.accentGreen,
                ),
              ],
            ),
          ),

          // زر فتح إعدادات إمكانية الوصول
          if (_lockEnabled)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentGreen,
                  minimumSize: const Size(double.infinity, 48),
                ),
                icon: const Icon(Icons.accessibility, color: Colors.white),
                label: const Text(
                  'افتح إعدادات إمكانية الوصول',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  // فتح إعدادات إمكانية الوصول
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'روح الإعدادات ← إمكانية الوصول ← تطبيق الذكر ← فعّل الخدمة',
                      ),
                      duration: Duration(seconds: 5),
                    ),
                  );
                },
              ),
            ),

          const SizedBox(height: 12),

          // عنوان القائمة
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'اختر التطبيقات المحظورة:',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // قائمة التطبيقات
          Expanded(
            child: ListView.builder(
              itemCount: popularApps.length,
              itemBuilder: (context, index) {
                final app = popularApps[index];
                final isLocked = _lockedApps.contains(app['package']);
                return Card(
                  child: ListTile(
                    leading: Text(
                      app['icon']!,
                      style: const TextStyle(fontSize: 28),
                    ),
                    title: Text(
                      app['name']!,
                      style: const TextStyle(color: AppTheme.textPrimary),
                    ),
                    subtitle: Text(
                      app['package']!,
                      style: const TextStyle(
                          color: AppTheme.textSecondary, fontSize: 11),
                    ),
                    trailing: Switch(
                      value: isLocked,
                      onChanged: (_) => _toggleApp(app['package']!),
                      activeColor: AppTheme.accentGreen,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
