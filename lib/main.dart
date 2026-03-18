import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/app_lock_screen.dart';

void main() {
  runApp(const DhikrApp());
}

class DhikrApp extends StatelessWidget {
  const DhikrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق الذكر',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      onGenerateRoute: (settings) {
        if (settings.name == '/lock') {
          final package = settings.arguments as String? ?? '';
          return MaterialPageRoute(
            builder: (_) => AppLockScreen(lockedPackage: package),
          );
        }
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      },
      home: const HomeScreen(),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );
  }
}
