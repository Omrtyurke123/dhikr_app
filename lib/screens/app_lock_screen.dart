import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class AppLockScreen extends StatefulWidget {
  const AppLockScreen({super.key});

  @override
  State<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends State<AppLockScreen> {
  static const _channel = MethodChannel('com.example.dhikr_app/lock');

  bool _lockEnabled = false;
  final List<Map<String, String>> _commonApps = [
    {'name': 'يوتيوب', 'package': 'com.google.android.youtube'},
    {'name': 'انستجرام', 'package': 'com.instagram.android'},
    {'name': 'تيك توك', 'package': 'com.zhiliaoapp.musically'},
    {'name': 'تويتر / X', 'package': 'com.twitter.android'},
    {'name': 'سناب شات', 'package': 'com.snapchat.android'},
    {'name': 'فيسبوك', 'package': 'com.facebook.katana'},
    {'name': 'تيليجرام', 'package': 'org.telegram.messenger'},
    {'name': 'واتساب', 'package': 'com.whatsapp'},
    {'name': 'نتفليكس', 'package': 'com.netflix.mediaclient'},
    {'name': 'ببجي', 'package': 'com.pubg.imobile'},
  ];
  final Set<String> _selectedApps = {};

  Future<void> _toggleLock(bool val) async {
    try {
      await _channel.invokeMethod('setLockEnabled', {'enabled': val});
      setState(() => _lockEnabled = val);
    } catch (e) {
      // fallback
      setState(() => _lockEnabled = val);
    }
  }

  Future<void> _toggleApp(String package) async {
    setState(() {
      if (_selectedApps.contains(package)) {
        _selectedApps.remove(package);
      } else {
        _selectedApps.add(package);
      }
    });
    try {
      await _channel.invokeMethod('setLockedApps', {
        'apps': _selectedApps.join(','),
      });
    } catch (e) {
      // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('قفل التطبيقات')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // تفعيل القفل
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'تفعيل قفل التطبيقات',
                        style: TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'يمنع فتح التطبيقات المحددة أثناء التحدي',
                        style: TextStyle(
                            color: AppTheme.textSecondary, fontSize: 13),
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

          if (_lockEnabled) ...[
            const SizedBox(height: 16),
            const Text(
              'اختر التطبيقات المراد قفلها:',
              style:
                  TextStyle(color: AppTheme.textSecondary, fontSize: 14),
            ),
            const SizedBox(height: 8),

            // تحذير خدمة إمكانية الوصول
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.withOpacity(0.4)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'تأكد من تفعيل خدمة إمكانية الوصول للتطبيق في إعدادات الجهاز',
                      style:
                          TextStyle(color: Colors.orange, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // قائمة التطبيقات
            ..._commonApps.map((app) {
              final selected = _selectedApps.contains(app['package']!);
              return Card(
                child: ListTile(
                  title: Text(
                    app['name']!,
                    style: const TextStyle(color: AppTheme.textPrimary),
                  ),
                  subtitle: Text(
                    app['package']!,
                    style: const TextStyle(
                        color: AppTheme.textSecondary, fontSize: 11),
                  ),
                  trailing: Checkbox(
                    value: selected,
                    onChanged: (_) => _toggleApp(app['package']!),
                    activeColor: AppTheme.accentGreen,
                  ),
                  onTap: () => _toggleApp(app['package']!),
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
}
