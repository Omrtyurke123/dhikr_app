import 'package:flutter/material.dart';
import '../models/dhikr_model.dart';
import '../theme/app_theme.dart';
import '../services/challenge_service.dart';

final List<AppInfo> _mockApps = [
  AppInfo(packageName: 'com.instagram.android', appName: 'Instagram'),
  AppInfo(packageName: 'com.twitter.android', appName: 'X (Twitter)'),
  AppInfo(packageName: 'com.facebook.katana', appName: 'Facebook'),
  AppInfo(packageName: 'com.snapchat.android', appName: 'Snapchat'),
  AppInfo(packageName: 'com.zhiliaoapp.musically', appName: 'TikTok'),
  AppInfo(packageName: 'com.whatsapp', appName: 'WhatsApp'),
  AppInfo(packageName: 'com.google.android.youtube', appName: 'YouTube'),
  AppInfo(packageName: 'com.netflix.mediaclient', appName: 'Netflix'),
  AppInfo(packageName: 'com.spotify.music', appName: 'Spotify'),
  AppInfo(packageName: 'com.google.android.gm', appName: 'Gmail'),
  AppInfo(packageName: 'org.telegram.messenger', appName: 'Telegram'),
  AppInfo(packageName: 'com.reddit.frontpage', appName: 'Reddit'),
];

class ChallengeSetupScreen extends StatefulWidget {
  final List<DhikrItem> selectedItems;
  const ChallengeSetupScreen({super.key, required this.selectedItems});

  @override
  State<ChallengeSetupScreen> createState() => _ChallengeSetupScreenState();
}

class _ChallengeSetupScreenState extends State<ChallengeSetupScreen> {
  final Set<String> _lockedApps = {};
  int _durationDays = 30;
  final List<int> _durationOptions = [7, 14, 21, 30, 60, 90];
  bool _saved = false;
  bool _saving = false;

  int get _totalDailyCount => widget.selectedItems.fold(0, (s, i) => s + i.defaultCount);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(
          backgroundColor: AppTheme.darkBg,
          title: const Text('إعداد التحدي اليومي', style: TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios_rounded, color: AppTheme.textPrimary), onPressed: () => Navigator.pop(context)),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryCard(),
              const SizedBox(height: 20),
              _buildDurationSection(),
              const SizedBox(height: 20),
              _buildAppLockSection(),
              const SizedBox(height: 28),
              _buildInfoCard(),
              const SizedBox(height: 28),
              _buildStartButton(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.accentGreen.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('الأذكار المحددة', style: TextStyle(color: AppTheme.lightGreen, fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...widget.selectedItems.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    item.arabic.length > 60 ? '${item.arabic.substring(0, 60)}...' : item.arabic,
                    style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14, height: 1.6),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: AppTheme.accentGreen.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                  child: Text('${item.defaultCount}×', style: const TextStyle(color: AppTheme.lightGreen, fontSize: 12)),
                ),
              ],
            ),
          )),
          Divider(color: AppTheme.accentGreen.withOpacity(0.2)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('إجمالي التسبيحات اليومية:', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
              Text('$_totalDailyCount تسبيحة', style: const TextStyle(color: AppTheme.lightGreen, fontSize: 15, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDurationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('مدة التحدي', style: TextStyle(color: AppTheme.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text('كم يوماً تريد الالتزام؟', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _durationOptions.map((d) {
            final isSelected = _durationDays == d;
            return GestureDetector(
              onTap: () => setState(() => _durationDays = d),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.accentGreen : AppTheme.cardBg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: isSelected ? AppTheme.lightGreen : AppTheme.accentGreen.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    Text('$d', style: TextStyle(color: isSelected ? Colors.white : AppTheme.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('يوم', style: TextStyle(color: isSelected ? Colors.white70 : AppTheme.textSecondary, fontSize: 11)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppTheme.accentGreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.accentGreen.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.calendar_month_rounded, color: AppTheme.lightGreen, size: 20),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'من ${_formatDate(DateTime.now())} إلى ${_formatDate(DateTime.now().add(Duration(days: _durationDays)))}',
                    style: const TextStyle(color: AppTheme.textPrimary, fontSize: 13),
                  ),
                  const SizedBox(height: 2),
                  Text('$_durationDays يوم × $_totalDailyCount تسبيحة/يوم', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppLockSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('قفل التطبيقات', style: TextStyle(color: AppTheme.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(color: AppTheme.accentGreen.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
              child: Text('${_lockedApps.length} محدد', style: const TextStyle(color: AppTheme.lightGreen, fontSize: 12)),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'هذه التطبيقات ستُقفل كل يوم ولن تُفتح إلا بعد إتمام التسبيح اليومي',
          style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
        ),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(color: AppTheme.cardBg, borderRadius: BorderRadius.circular(20)),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _mockApps.length,
            separatorBuilder: (_, __) => Divider(color: AppTheme.accentGreen.withOpacity(0.1), height: 1, indent: 16, endIndent: 16),
            itemBuilder: (context, i) {
              final app = _mockApps[i];
              final isLocked = _lockedApps.contains(app.packageName);
              return ListTile(
                onTap: () => setState(() => isLocked ? _lockedApps.remove(app.packageName) : _lockedApps.add(app.packageName)),
                leading: Container(
                  width: 38, height: 38,
                  decoration: BoxDecoration(color: _appColor(app.packageName).withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                  child: Icon(_appIcon(app.packageName), color: _appColor(app.packageName), size: 20),
                ),
                title: Text(app.appName, style: TextStyle(color: isLocked ? AppTheme.textPrimary : AppTheme.textSecondary, fontSize: 14)),
                trailing: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 22, height: 22,
                  decoration: BoxDecoration(
                    color: isLocked ? AppTheme.accentGreen : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: isLocked ? AppTheme.lightGreen : AppTheme.textSecondary.withOpacity(0.4)),
                  ),
                  child: isLocked ? const Icon(Icons.check_rounded, color: Colors.white, size: 14) : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.lightbulb_outline_rounded, color: Colors.lightBlue, size: 18),
            SizedBox(width: 8),
            Text('كيف يعمل التحدي؟', style: TextStyle(color: Colors.lightBlue, fontSize: 14, fontWeight: FontWeight.bold)),
          ]),
          SizedBox(height: 10),
          Text(
            '• كل يوم تحتاج إلى إتمام عدد التسبيحات المحددة\n'
            '• بعد الإتمام، تُفتح التطبيقات المقفلة لبقية اليوم\n'
            '• في اليوم التالي، تعود التطبيقات للقفل تلقائياً\n'
            '• تتبع تقدمك اليومي في صفحة التحديات',
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 13, height: 1.7),
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton() {
    return GestureDetector(
      onTap: _saving ? null : _saveChallenge,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _saving ? [Colors.grey.shade700, Colors.grey.shade600] : [AppTheme.accentGreen, AppTheme.lightGreen],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: AppTheme.accentGreen.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 6))],
        ),
        child: _saving
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.rocket_launch_rounded, color: Colors.white, size: 24),
                  const SizedBox(width: 10),
                  Text(
                    'ابدأ التحدي لمدة $_durationDays يوم',
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _saveChallenge() async {
    if (widget.selectedItems.isEmpty) return;
    setState(() => _saving = true);

    final combined = widget.selectedItems.map((i) => i.arabic).join(' | ');
    final challenge = DhikrChallenge(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      dhikrId: widget.selectedItems.first.id,
      dhikrText: combined,
      dailyCount: _totalDailyCount,
      lockedApps: _lockedApps.toList(),
      startDate: DateTime.now(),
      durationDays: _durationDays,
    );

    await ChallengeService.addChallenge(challenge);

    setState(() { _saving = false; _saved = true; });

    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: AppTheme.cardBg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 70, height: 70,
                decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.accentGreen.withOpacity(0.2)),
                child: const Icon(Icons.check_circle_rounded, color: AppTheme.lightGreen, size: 42),
              ),
              const SizedBox(height: 16),
              const Text('تم إنشاء التحدي!', style: TextStyle(color: AppTheme.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                'سيبدأ التحدي الآن لمدة $_durationDays يوماً. ابدأ تسبيحك اليومي من صفحة التحديات.',
                style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13, height: 1.6),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('رائع!', style: TextStyle(color: AppTheme.lightGreen, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime d) => '${d.day}/${d.month}/${d.year}';

  Color _appColor(String pkg) {
    if (pkg.contains('instagram')) return Colors.pink;
    if (pkg.contains('twitter')) return Colors.blue;
    if (pkg.contains('facebook')) return const Color(0xFF1877F2);
    if (pkg.contains('snapchat')) return Colors.amber;
    if (pkg.contains('musically')) return const Color(0xFF010101);
    if (pkg.contains('whatsapp')) return Colors.green;
    if (pkg.contains('youtube')) return Colors.red;
    if (pkg.contains('netflix')) return Colors.red.shade900;
    if (pkg.contains('spotify')) return const Color(0xFF1DB954);
    if (pkg.contains('gmail')) return Colors.red;
    if (pkg.contains('telegram')) return Colors.lightBlue;
    if (pkg.contains('reddit')) return Colors.deepOrange;
    return AppTheme.lightGreen;
  }

  IconData _appIcon(String pkg) {
    if (pkg.contains('instagram')) return Icons.camera_alt_rounded;
    if (pkg.contains('twitter')) return Icons.alternate_email_rounded;
    if (pkg.contains('facebook')) return Icons.facebook_rounded;
    if (pkg.contains('snapchat')) return Icons.tag_faces_rounded;
    if (pkg.contains('musically')) return Icons.music_note_rounded;
    if (pkg.contains('whatsapp')) return Icons.chat_rounded;
    if (pkg.contains('youtube')) return Icons.play_circle_rounded;
    if (pkg.contains('netflix')) return Icons.movie_rounded;
    if (pkg.contains('spotify')) return Icons.music_note_rounded;
    if (pkg.contains('gmail')) return Icons.email_rounded;
    if (pkg.contains('telegram')) return Icons.send_rounded;
    if (pkg.contains('reddit')) return Icons.reddit_rounded;
    return Icons.apps_rounded;
  }
}
