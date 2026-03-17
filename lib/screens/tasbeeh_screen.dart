import 'package:flutter/material.dart';
import '../data/adhkar_data.dart';
import '../models/dhikr_model.dart';
import '../theme/app_theme.dart';
import 'tasbeeh_counter_screen.dart';

class TasbeehScreen extends StatefulWidget {
  const TasbeehScreen({super.key});
  @override
  State<TasbeehScreen> createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  String _searchQuery = '';

  List<DhikrItem> get _filteredItems {
    final all = AdhkarData.getAllItems();
    if (_searchQuery.isEmpty) return all;
    return all.where((item) =>
      item.arabic.contains(_searchQuery) ||
      item.translation.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('اختر ذكراً للتسبيح', style: TextStyle(color: AppTheme.textPrimary, fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(color: AppTheme.cardBg, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.accentGreen.withOpacity(0.2))),
              child: TextField(
                textDirection: TextDirection.rtl,
                style: const TextStyle(color: AppTheme.textPrimary),
                decoration: const InputDecoration(
                  hintText: 'ابحث عن ذكر...',
                  hintStyle: TextStyle(color: AppTheme.textSecondary),
                  prefixIcon: Icon(Icons.search_rounded, color: AppTheme.textSecondary),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                onChanged: (val) => setState(() => _searchQuery = val),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _filteredItems.isEmpty
                  ? const Center(child: Text('لا توجد نتائج', style: TextStyle(color: AppTheme.textSecondary)))
                  : ListView.builder(
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, i) {
                        final item = _filteredItems[i];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(
                              builder: (_) => TasbeehCounterScreen(session: TasbeehSession(
                                dhikrId: item.id, dhikrText: item.arabic,
                                targetCount: item.defaultCount, lockedApps: [],
                              )),
                            )),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: AppTheme.cardBg,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: AppTheme.accentGreen.withOpacity(0.2)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          item.arabic.length > 70 ? '${item.arabic.substring(0, 70)}...' : item.arabic,
                                          style: const TextStyle(color: AppTheme.textPrimary, fontSize: 15, height: 1.6),
                                          textAlign: TextAlign.right,
                                        ),
                                        const SizedBox(height: 4),
                                        Text('${item.defaultCount} مرة', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Icon(Icons.play_circle_filled_rounded, color: AppTheme.lightGreen, size: 32),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
