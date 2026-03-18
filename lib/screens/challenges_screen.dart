import 'package:flutter/material.dart';
import '../services/challenge_service.dart';
import '../theme/app_theme.dart';
import 'challenge_setup_screen.dart';
import 'app_lock_screen.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  List<DailyChallenge> _challenges = [];

  @override
  void initState() {
    super.initState();
    _loadChallenges();
  }

  Future<void> _loadChallenges() async {
    final challenges = await ChallengeService.getChallenges();
    if (mounted) setState(() => _challenges = challenges);
  }

  Future<void> _increment(DailyChallenge challenge) async {
    await ChallengeService.incrementChallenge(challenge.id);
    await _loadChallenges();
  }

  Future<void> _delete(String id) async {
    await ChallengeService.deleteChallenge(id);
    await _loadChallenges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        title: const Text('التحديات اليومية'),
        actions: [
          IconButton(
            icon: const Icon(Icons.lock_outline, color: AppTheme.accentGreen),
            tooltip: 'قفل التطبيقات',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AppLockScreen()),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.accentGreen,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChallengeSetupScreen()),
          );
          await _loadChallenges();
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: _challenges.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('📿', style: TextStyle(fontSize: 60)),
                  SizedBox(height: 16),
                  Text(
                    'لا توجد تحديات بعد',
                    style: TextStyle(color: AppTheme.textSecondary, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'اضغط + لإضافة تحدي يومي',
                    style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _challenges.length,
              itemBuilder: (context, index) {
                final c = _challenges[index];
                return _ChallengeCard(
                  challenge: c,
                  onIncrement: () => _increment(c),
                  onDelete: () => _delete(c.id),
                );
              },
            ),
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  final DailyChallenge challenge;
  final VoidCallback onIncrement;
  final VoidCallback onDelete;

  const _ChallengeCard({
    required this.challenge,
    required this.onIncrement,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = challenge.isCompleted;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    challenge.name,
                    style: TextStyle(
                      color: isCompleted
                          ? AppTheme.accentGreen
                          : AppTheme.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (isCompleted)
                  const Icon(Icons.check_circle,
                      color: AppTheme.accentGreen, size: 22),
                IconButton(
                  icon: const Icon(Icons.delete_outline,
                      color: Colors.red, size: 20),
                  onPressed: onDelete,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              challenge.dhikrText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(color: AppTheme.textSecondary, fontSize: 14),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LinearProgressIndicator(
                        value: challenge.progress,
                        backgroundColor: AppTheme.bgColor,
                        color: isCompleted ? Colors.green : AppTheme.accentGreen,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${challenge.currentCount} / ${challenge.targetCount}',
                        style: const TextStyle(
                            color: AppTheme.textSecondary, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                if (!isCompleted)
                  GestureDetector(
                    onTap: onIncrement,
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: AppTheme.accentGreen,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
