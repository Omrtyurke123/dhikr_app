import 'package:flutter/material.dart';
import '../data/adhkar_data.dart';
import '../models/dhikr_model.dart';
import '../theme/app_theme.dart';
import 'tasbeeh_counter_screen.dart';

class DhikrListScreen extends StatelessWidget {
  const DhikrListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = AdhkarData.categories;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final cat = categories[index];
        return Card(
          child: ListTile(
            leading: Text(
              cat.icon,
              style: const TextStyle(fontSize: 28),
            ),
            title: Text(
              cat.name,
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${cat.adhkar.length} أذكار',
              style: const TextStyle(color: AppTheme.textSecondary),
            ),
            trailing: const Icon(
              Icons.arrow_back_ios,
              color: AppTheme.accentGreen,
              size: 16,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DhikrDetailScreen(category: cat),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DhikrDetailScreen extends StatelessWidget {
  final DhikrCategory category;

  const DhikrDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: category.adhkar.length,
        itemBuilder: (context, index) {
          final dhikr = category.adhkar[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    dhikr.arabic,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 20,
                      height: 1.8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (dhikr.source != null)
                        Text(
                          '📖 ${dhikr.source}',
                          style: const TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.accentGreen.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppTheme.accentGreen),
                        ),
                        child: Text(
                          '${dhikr.count}×',
                          style: const TextStyle(
                            color: AppTheme.accentGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentGreen,
                    ),
                    icon: const Icon(Icons.touch_app, color: Colors.white),
                    label: const Text('ابدأ التسبيح',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TasbeehCounterScreen(dhikr: dhikr),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
