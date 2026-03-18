import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'dhikr_list_screen.dart';
import 'tasbeeh_screen.dart';
import 'challenges_screen.dart';

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

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return 'صباح الخير 🌅';
    if (hour >= 12 && hour < 17) return 'مساء الخير ☀️';
    if (hour >= 17 && hour < 20) return 'مساء النور 🌇';
    return 'مساء الخير 🌙';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text('تطبيق الذكر'),
            Text(
              _greeting,
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.accentGreen,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
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
