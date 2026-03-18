import 'package:flutter/material.dart';
import '../data/adhkar_data.dart';
import '../models/dhikr_model.dart';
import '../theme/app_theme.dart';
import 'tasbeeh_counter_screen.dart';

class TasbeehScreen extends StatelessWidget {
  const TasbeehScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // فلتر الأذكار المناسبة للتسبيح المتكرر
    final allDhikr = AdhkarData.categories
        .expand((c) => c.adhkar)
        .where((d) => d.count >= 10)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: AppTheme.cardColor,
          child: const Text(
            'اختر ذكراً للتسبيح',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: allDhikr.length,
            itemBuilder: (context, index) {
              final dhikr = allDhikr[index];
              return _TasbeehCard(dhikr: dhikr);
            },
          ),
        ),
      ],
    );
  }
}

class _TasbeehCard extends StatelessWidget {
  final DhikrModel dhikr;
  const _TasbeehCard({required this.dhikr});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TasbeehCounterScreen(dhikr: dhikr),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  dhikr.arabic,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 18,
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.accentGreen,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${dhikr.count}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'مرة',
                    style:
                        TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
