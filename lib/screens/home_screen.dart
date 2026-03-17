import 'package:flutter/material.dart';
import '../data/adhkar_data.dart';
import '../models/dhikr_model.dart';
import '../theme/app_theme.dart';
import 'dhikr_list_screen.dart';
import 'tasbeeh_screen.dart';
import 'challenges_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const _tabs = [_AdhkarTab(), TasbeehScreen(), ChallengesScreen()];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        body: IndexedStack(index: _selectedIndex, children: _tabs),
        bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        border: Border(top: BorderSide(color: AppTheme.accentGreen.withOpacity(0.3), width: 1)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(icon: Icons.home_rounded, label: 'الرئيسية', isSelected: _selectedIndex == 0, onTap: () => setState(() => _selectedIndex = 0)),
              _NavItem(icon: Icons.touch_app_rounded, label: 'التسبيح', isSelected: _selectedIndex == 1, onTap: () => setState(() => _selectedIndex = 1)),
              _NavItem(icon: Icons.lock_clock_rounded, label: 'التحديات', isSelected: _selectedIndex == 2, onTap: () => setState(() => _selectedIndex = 2)),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _NavItem({required this.icon, required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.accentGreen.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? AppTheme.lightGreen : AppTheme.textSecondary, size: 24),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(color: isSelected ? AppTheme.lightGreen : AppTheme.textSecondary, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _AdhkarTab extends StatelessWidget {
  const _AdhkarTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: AdhkarData.categories.length,
              itemBuilder: (context, i) => _CategoryCard(category: AdhkarData.categories[i], index: i),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final hour = DateTime.now().hour;
    final greeting = hour < 12 ? 'صباح الخير 🌤' : hour < 17 ? 'مساء الخير ☀️' : 'مساء النور 🌙';
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('الأذكار', style: TextStyle(color: AppTheme.textPrimary, fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(greeting, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final DhikrCategory category;
  final int index;
  const _CategoryCard({required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DhikrListScreen(category: category))),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: _getGradient(category.type),
            boxShadow: [BoxShadow(color: _getShadowColor(category.type).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(category.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text('${category.items.length} أذكار', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
                    ],
                  ),
                ),
                Container(
                  width: 50, height: 50,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(15)),
                  child: Icon(_getCategoryIcon(category.type), color: Colors.white, size: 28),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(CategoryType t) {
    switch (t) {
      case CategoryType.morning: return Icons.wb_sunny_rounded;
      case CategoryType.evening: return Icons.nights_stay_rounded;
      case CategoryType.night: return Icons.dark_mode_rounded;
      case CategoryType.prayer: return Icons.mosque_rounded;
      case CategoryType.sleep: return Icons.bedtime_rounded;
      case CategoryType.misc: return Icons.auto_awesome_rounded;
      case CategoryType.istighfar: return Icons.favorite_rounded;
      case CategoryType.tasbeeh: return Icons.radio_button_checked_rounded;
      case CategoryType.salawat: return Icons.star_rounded;
    }
  }

  LinearGradient _getGradient(CategoryType t) {
    switch (t) {
      case CategoryType.morning: return const LinearGradient(colors: [Color(0xFF2196F3), Color(0xFF64B5F6), Color(0xFFFFB74D)], begin: Alignment.centerRight, end: Alignment.centerLeft);
      case CategoryType.evening: return const LinearGradient(colors: [Color(0xFF4A148C), Color(0xFF7B1FA2), Color(0xFFE91E63)], begin: Alignment.centerRight, end: Alignment.centerLeft);
      case CategoryType.night: return const LinearGradient(colors: [Color(0xFF0D47A1), Color(0xFF1565C0), Color(0xFF283593)], begin: Alignment.centerRight, end: Alignment.centerLeft);
      case CategoryType.prayer: return const LinearGradient(colors: [Color(0xFF2E7D32), Color(0xFF43A047), Color(0xFF66BB6A)], begin: Alignment.centerRight, end: Alignment.centerLeft);
      case CategoryType.sleep: return const LinearGradient(colors: [Color(0xFF1A237E), Color(0xFF303F9F), Color(0xFF3949AB)], begin: Alignment.centerRight, end: Alignment.centerLeft);
      case CategoryType.misc: return const LinearGradient(colors: [Color(0xFF00695C), Color(0xFF00897B), Color(0xFF26A69A)], begin: Alignment.centerRight, end: Alignment.centerLeft);
      case CategoryType.istighfar: return const LinearGradient(colors: [Color(0xFF880E4F), Color(0xFFC2185B), Color(0xFFE91E63)], begin: Alignment.centerRight, end: Alignment.centerLeft);
      case CategoryType.tasbeeh: return const LinearGradient(colors: [Color(0xFF4E342E), Color(0xFF6D4C41), Color(0xFF8D6E63)], begin: Alignment.centerRight, end: Alignment.centerLeft);
      case CategoryType.salawat: return const LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF388E3C), Color(0xFFA5D6A7)], begin: Alignment.centerRight, end: Alignment.centerLeft);
    }
  }

  Color _getShadowColor(CategoryType t) {
    switch (t) {
      case CategoryType.morning: return const Color(0xFF2196F3);
      case CategoryType.evening: return const Color(0xFF7B1FA2);
      case CategoryType.night: return const Color(0xFF0D47A1);
      case CategoryType.prayer: return const Color(0xFF2E7D32);
      case CategoryType.sleep: return const Color(0xFF303F9F);
      case CategoryType.misc: return const Color(0xFF00695C);
      case CategoryType.istighfar: return const Color(0xFFC2185B);
      case CategoryType.tasbeeh: return const Color(0xFF6D4C41);
      case CategoryType.salawat: return const Color(0xFF388E3C);
    }
  }
}
