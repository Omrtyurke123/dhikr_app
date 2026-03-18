import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'dhikr_list_screen.dart';
import 'tasbeeh_screen.dart';
import 'challenges_screen.dart';
import 'app_lock_settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تطبيق الذكر'),
        actions: [
          IconButton(
            icon: const Icon(Icons.lock_outline, color: AppTheme.accentGreen),
            tooltip: 'قفل التطبيقات',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AppLockSettingsScreen(),
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'الرئيسية', icon: Icon(Icons.home_outlined)),
            Tab(text: 'التسبيح', icon: Icon(Icons.repeat_outlined)),
            Tab(text: 'التحديات', icon: Icon(Icons.emoji_events_outlined)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          DhikrListScreen(),
          TasbeehScreen(),
          ChallengesScreen(),
        ],
      ),
    );
  }
}
