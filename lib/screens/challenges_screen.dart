import 'package:flutter/material.dart';
import '../models/dhikr_model.dart';
import '../theme/app_theme.dart';
import '../services/challenge_service.dart';
import 'tasbeeh_counter_screen.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});
  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  List<DhikrChallenge> _challenges = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final all = await ChallengeService.loadAll();
    setState(() {
      _challenges = all;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator(color: AppTheme.lightGreen))
                  : _challenges.isEmpty
                      ? _buildEmpty()
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          itemCount: _challenges.length,
                          itemBuilder: (context, i) => _ChallengeCard(
                            challenge: _challenges[i],
                            onDeleted: _load,
                            onProgressUpdated: _load,
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final active = _challenges.where((c) => c.isActive).length;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('التحديات اليومية', style: TextStyle(color: AppTheme.textPrimary, fontSize: 26, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text('$active تحدٍّ نشط', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
              ],
            ),
          ),
          if (_challenges.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.refresh_rounded, color: AppTheme.textSecondary),
              onPressed: _load,
            ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100, height: 100,
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.accentGreen.withOpacity(0.1)),
              child: const Icon(Icons.lock_clock_rounded, color: AppTheme.accentGreen, size: 50),
            ),
            const SizedBox(height: 24),
            const Text('لا توجد تحديات نشطة', style: TextStyle(color: AppTheme.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text(
              'اذهب إلى صفحة الأذكار، اختر أذكاراً، ثم اضغط "تحدٍّ يومي" لبدء رحلتك',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 14, height: 1.7),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChallengeCard extends StatefulWidget {
  final DhikrChallenge challenge;
  final VoidCallback onDeleted;
  final VoidCallback onProgressUpdated;
  const _ChallengeCard({required this.challenge, required this.onDeleted, required this.onProgressUpdated});
  @override
  State<_ChallengeCard> createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<_ChallengeCard> {
  bool _expanded = false;

  DhikrChallenge get c => widget.challenge;

  @override
  Widget build(BuildContext context) {
    final todayProgress = c.todayCount / c.dailyCount;
    final overallProgress = c.daysElapsed / c.durationDays;
    final completed = c.todayCompleted;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: completed ? AppTheme.lightGreen.withOpacity(0.5) : AppTheme.accentGreen.withOpacity(0.2),
            width: completed ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          c.dhikrText.length > 50 ? '${c.dhikrText.substring(0, 50)}...' : c.dhikrText,
                          style: const TextStyle(color: AppTheme.textPrimary, fontSize: 15, height: 1.6),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _statusBadge(completed, c.isActive),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Today's progress
                  _sectionLabel('تقدم اليوم'),
                  const SizedBox(height: 6),
                  _progressBar(todayProgress, completed ? AppTheme.lightGreen : AppTheme.accentGreen),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${c.todayCount} / ${c.dailyCount} تسبيحة', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                      Text('${(todayProgress * 100).toInt()}%', style: TextStyle(color: completed ? AppTheme.lightGreen : AppTheme.textSecondary, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Overall progress
                  _sectionLabel('تقدم التحدي'),
                  const SizedBox(height: 6),
                  _progressBar(overallProgress.clamp(0.0, 1.0), Colors.blue.shade400),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${c.daysElapsed} / ${c.durationDays} يوم', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                      Text('${c.daysRemaining} يوم متبقٍ', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Stats row
                  Row(
                    children: [
                      _statChip(Icons.check_circle_outline_rounded, '${c.totalDaysCompleted}', 'يوم مكتمل', Colors.green),
                      const SizedBox(width: 8),
                      if (c.lockedApps.isNotEmpty)
                        _statChip(Icons.lock_rounded, '${c.lockedApps.length}', 'تطبيق مقفل', completed ? Colors.grey : Colors.red),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Expand for calendar
                  GestureDetector(
                    onTap: () => setState(() => _expanded = !_expanded),
                    child: Row(
                      children: [
                        Text(_expanded ? 'إخفاء الأيام' : 'عرض سجل الأيام', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
                        Icon(_expanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, color: AppTheme.textSecondary, size: 18),
                      ],
                    ),
                  ),
                  if (_expanded) ...[
                    const SizedBox(height: 12),
                    _buildDayGrid(),
                  ],
                ],
              ),
            ),

            // Action buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _delete(context),
                      icon: const Icon(Icons.delete_outline_rounded, size: 16),
                      label: const Text('حذف'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.redAccent,
                        side: BorderSide(color: Colors.redAccent.withOpacity(0.5)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: completed ? null : _startTodayTasbeeh,
                      icon: Icon(completed ? Icons.check_rounded : Icons.play_circle_rounded, size: 18),
                      label: Text(completed ? 'أكملت اليوم ✓' : 'ابدأ تسبيح اليوم'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: completed ? Colors.grey.shade800 : AppTheme.accentGreen,
                        foregroundColor: completed ? Colors.grey : Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusBadge(bool completed, bool active) {
    if (!active) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
        child: const Text('منتهي', style: TextStyle(color: Colors.grey, fontSize: 11)),
      );
    }
    if (completed) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: AppTheme.lightGreen.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
        child: const Text('✓ مكتمل', style: TextStyle(color: AppTheme.lightGreen, fontSize: 11, fontWeight: FontWeight.bold)),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.orange.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
      child: const Text('جارٍ', style: TextStyle(color: Colors.orange, fontSize: 11)),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(text, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12));
  }

  Widget _progressBar(double value, Color color) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: LinearProgressIndicator(
        value: value.clamp(0.0, 1.0),
        backgroundColor: color.withOpacity(0.15),
        valueColor: AlwaysStoppedAnimation<Color>(color),
        minHeight: 8,
      ),
    );
  }

  Widget _statChip(IconData icon, String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, color: color, size: 14),
        const SizedBox(width: 4),
        Text('$value $label', style: TextStyle(color: color, fontSize: 12)),
      ]),
    );
  }

  Widget _buildDayGrid() {
    final days = <Widget>[];
    for (int i = 0; i < c.durationDays; i++) {
      final date = c.startDate.add(Duration(days: i));
      final key = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      final count = c.dailyProgress[key] ?? 0;
      final done = count >= c.dailyCount;
      final isToday = key == c.todayKey;
      final isFuture = date.isAfter(DateTime.now());
      days.add(
        Container(
          width: 32, height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: done ? AppTheme.lightGreen : isFuture ? Colors.transparent : Colors.red.withOpacity(0.15),
            border: isToday ? Border.all(color: Colors.white, width: 2) : null,
          ),
          child: Center(
            child: Text(
              '${i + 1}',
              style: TextStyle(
                color: done ? Colors.white : isFuture ? AppTheme.textSecondary.withOpacity(0.4) : Colors.redAccent,
                fontSize: 11,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      );
    }
    return Wrap(spacing: 6, runSpacing: 6, children: days);
  }

  void _startTodayTasbeeh() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TasbeehCounterScreen(
          session: TasbeehSession(
            dhikrId: c.dhikrId,
            dhikrText: c.dhikrText,
            targetCount: c.dailyCount - c.todayCount,
            lockedApps: c.lockedApps,
          ),
          challengeId: c.id,
          alreadyDone: c.todayCount,
          onCompleted: () async {
            await ChallengeService.updateProgress(c.id, c.todayKey, c.dailyCount);
            widget.onProgressUpdated();
          },
        ),
      ),
    ).then((_) => widget.onProgressUpdated());
  }

  void _delete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: AppTheme.cardBg,
          title: const Text('حذف التحدي', style: TextStyle(color: AppTheme.textPrimary)),
          content: const Text('هل تريد حذف هذا التحدي نهائياً؟', style: TextStyle(color: AppTheme.textSecondary)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء', style: TextStyle(color: AppTheme.textSecondary))),
            TextButton(
              onPressed: () async {
                await ChallengeService.deleteChallenge(c.id);
                Navigator.pop(context);
                widget.onDeleted();
              },
              child: const Text('حذف', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}
