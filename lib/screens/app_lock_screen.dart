import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import '../data/adhkar_data.dart';

class AppLockScreen extends StatefulWidget {
  final String lockedPackage;
  const AppLockScreen({super.key, this.lockedPackage = ''});

  @override
  State<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends State<AppLockScreen> {
  int _count = 0;
  final int _target = 10;

  void _increment() {
    HapticFeedback.lightImpact();
    setState(() => _count++);
    if (_count >= _target) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) SystemNavigator.pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = _count / _target;
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: AppTheme.cardColor,
              color: AppTheme.accentGreen,
              minHeight: 6,
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('??', style: TextStyle(fontSize: 60)),
                      const SizedBox(height: 16),
                      const Text(
                        'ÇÐßÑ Çááå ÃæáÇð',
                        style: TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'ÓÈøÍ 10 ãÑÇÊ ááãÊÇÈÚÉ',
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: _increment,
                        child: Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.accentGreen,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.accentGreen.withOpacity(0.4),
                                blurRadius: 20,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$_count',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 52,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'ÓÈÍÇä Çááå',
                                style: TextStyle(color: Colors.white70, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextButton(
                        onPressed: () => SystemNavigator.pop(),
                        child: const Text(
                          'ÑÌæÚ',
                          style: TextStyle(color: AppTheme.textSecondary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
