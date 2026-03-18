import 'package:flutter/material.dart';
import '../models/dhikr_model.dart';
import '../theme/app_theme.dart';

class CompletionScreen extends StatelessWidget {
  final DhikrModel dhikr;

  const CompletionScreen({super.key, required this.dhikr});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '🎉',
                style: TextStyle(fontSize: 80),
              ),
              const SizedBox(height: 24),
              const Text(
                'أحسنت!',
                style: TextStyle(
                  color: AppTheme.accentGreen,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'أتممت ${dhikr.count} مرة',
                style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                dhikr.meaning,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentGreen,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () => Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                ),
                child: const Text(
                  'العودة للرئيسية',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'تكرار الذكر',
                  style: TextStyle(color: AppTheme.textSecondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
