import 'package:flutter/material.dart';
import '../models/dhikr_model.dart';
import '../theme/app_theme.dart';
import 'tasbeeh_counter_screen.dart';

// Mock list of apps that could be locked
final List<AppInfo> _mockApps = [
  AppInfo(packageName: 'com.instagram.android', appName: 'Instagram', isLocked: false),
  AppInfo(packageName: 'com.twitter.android', appName: 'X (Twitter)', isLocked: false),
  AppInfo(packageName: 'com.facebook.katana', appName: 'Facebook', isLocked: false),
  AppInfo(packageName: 'com.snapchat.android', appName: 'Snapchat', isLocked: false),
  AppInfo(packageName: 'com.tiktok.android', appName: 'TikTok', isLocked: false),
  AppInfo(packageName: 'com.whatsapp', appName: 'WhatsApp', isLocked: false),
  AppInfo(packageName: 'com.youtube.android', appName: 'YouTube', isLocked: false),
  AppInfo(packageName: 'com.netflix.android', appName: 'Netflix', isLocked: false),
  AppInfo(packageName: 'com.spotify.music', appName: 'Spotify', isLocked: false),
  AppInfo(packageName: 'com.google.android.gm', appName: 'Gmail', isLocked: false),
  AppInfo(packageName: 'com.telegram.messenger', appName: 'Telegram', isLocked: false),
  AppInfo(packageName: 'com.reddit.frontpage', appName: 'Reddit', isLocked: false),
];

class TasbeehSetupScreen extends StatefulWidget {
  final DhikrItem dhikr;

  const TasbeehSetupScreen({super.key, required this.dhikr});

  @override
  State<TasbeehSetupScreen> createState() => _TasbeehSetupScreenState();
}

class _TasbeehSetupScreenState extends State<TasbeehSetupScreen> {
  late int _selectedCount;
  final Set<String> _lockedApps = {};
  final TextEditingController _customCountController = TextEditingController();
  bool _useCustomCount = false;

  final List<int> _presetCounts = [1, 3, 7, 10, 33, 99, 100];

  @override
  void initState() {
    super.initState();
    _selectedCount = widget.dhikr.defaultCount;
    _customCountController.text = widget.dhikr.defaultCount.toString();
  }

  @override
  void dispose() {
    _customCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(
          backgroundColor: AppTheme.darkBg,
          title: const Text(
            'إعداد التسبيح',
            style: TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded, color: AppTheme.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDhikrPreview(),
              const SizedBox(height: 24),
              _buildCountSelector(),
              const SizedBox(height: 24),
              _buildAppLockSection(),
              const SizedBox(height: 32),
              _buildStartButton(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDhikrPreview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.accentGreen.withOpacity(0.3)),
      ),
      child: Text(
        widget.dhikr.arabic,
        style: const TextStyle(
          color: AppTheme.textPrimary,
          fontSize: 20,
          height: 2.0,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildCountSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'عدد التسبيحات',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _presetCounts.map((count) {
            final isSelected = !_useCustomCount && _selectedCount == count;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCount = count;
                  _useCustomCount = false;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.accentGreen : AppTheme.cardBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? AppTheme.lightGreen : AppTheme.accentGreen.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppTheme.textSecondary,
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        // Custom count input
        Container(
          decoration: BoxDecoration(
            color: AppTheme.cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _useCustomCount ? AppTheme.lightGreen : AppTheme.accentGreen.withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _customCountController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: AppTheme.textPrimary, fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'أدخل عدداً مخصصاً',
                    hintStyle: TextStyle(color: AppTheme.textSecondary),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: InputBorder.none,
                  ),
                  onTap: () => setState(() => _useCustomCount = true),
                  onChanged: (val) {
                    final n = int.tryParse(val);
                    if (n != null && n > 0) {
                      setState(() {
                        _selectedCount = n;
                        _useCustomCount = true;
                      });
                    }
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Icon(Icons.edit_rounded, color: AppTheme.textSecondary, size: 20),
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
            const Text(
              'قفل التطبيقات',
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppTheme.accentGreen.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${_lockedApps.length} محدد',
                style: const TextStyle(color: AppTheme.lightGreen, fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'اختر التطبيقات التي ستُقفل حتى تكمل التسبيح',
          style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.cardBg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _mockApps.length,
            separatorBuilder: (_, __) => Divider(
              color: AppTheme.accentGreen.withOpacity(0.1),
              height: 1,
              indent: 16,
              endIndent: 16,
            ),
            itemBuilder: (context, i) {
              final app = _mockApps[i];
              final isLocked = _lockedApps.contains(app.packageName);
              return ListTile(
                onTap: () {
                  setState(() {
                    if (isLocked) {
                      _lockedApps.remove(app.packageName);
                    } else {
                      _lockedApps.add(app.packageName);
                    }
                  });
                },
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getAppColor(app.packageName).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getAppIcon(app.packageName),
                    color: _getAppColor(app.packageName),
                    size: 22,
                  ),
                ),
                title: Text(
                  app.appName,
                  style: TextStyle(
                    color: isLocked ? AppTheme.textPrimary : AppTheme.textSecondary,
                    fontSize: 15,
                  ),
                ),
                trailing: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isLocked ? AppTheme.accentGreen : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isLocked ? AppTheme.lightGreen : AppTheme.textSecondary.withOpacity(0.4),
                    ),
                  ),
                  child: isLocked
                      ? const Icon(Icons.check_rounded, color: Colors.white, size: 16)
                      : null,
                ),
              );
            },
          ),
        ),
        if (_lockedApps.isNotEmpty) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.withOpacity(0.3)),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline_rounded, color: Colors.orange, size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'ملاحظة: قفل التطبيقات يتطلب منح صلاحية إمكانية الوصول في الإعدادات',
                    style: TextStyle(color: Colors.orange, fontSize: 12, height: 1.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStartButton() {
    final count = _useCustomCount
        ? (int.tryParse(_customCountController.text) ?? _selectedCount)
        : _selectedCount;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TasbeehCounterScreen(
              session: TasbeehSession(
                dhikrId: widget.dhikr.id,
                dhikrText: widget.dhikr.arabic,
                targetCount: count,
                lockedApps: _lockedApps.toList(),
              ),
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppTheme.accentGreen, AppTheme.lightGreen],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppTheme.accentGreen.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.play_circle_rounded, color: Colors.white, size: 28),
            const SizedBox(width: 10),
            Text(
              'ابدأ التسبيح ($count مرة)',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getAppColor(String packageName) {
    if (packageName.contains('instagram')) return Colors.pink;
    if (packageName.contains('twitter')) return Colors.blue;
    if (packageName.contains('facebook')) return const Color(0xFF1877F2);
    if (packageName.contains('snapchat')) return Colors.yellow;
    if (packageName.contains('tiktok')) return Colors.black;
    if (packageName.contains('whatsapp')) return Colors.green;
    if (packageName.contains('youtube')) return Colors.red;
    if (packageName.contains('netflix')) return Colors.red.shade900;
    if (packageName.contains('spotify')) return const Color(0xFF1DB954);
    if (packageName.contains('gmail')) return Colors.red;
    if (packageName.contains('telegram')) return Colors.lightBlue;
    if (packageName.contains('reddit')) return Colors.deepOrange;
    return AppTheme.lightGreen;
  }

  IconData _getAppIcon(String packageName) {
    if (packageName.contains('instagram')) return Icons.camera_alt_rounded;
    if (packageName.contains('twitter')) return Icons.alternate_email_rounded;
    if (packageName.contains('facebook')) return Icons.facebook_rounded;
    if (packageName.contains('snapchat')) return Icons.tag_faces_rounded;
    if (packageName.contains('tiktok')) return Icons.music_note_rounded;
    if (packageName.contains('whatsapp')) return Icons.chat_rounded;
    if (packageName.contains('youtube')) return Icons.play_circle_rounded;
    if (packageName.contains('netflix')) return Icons.movie_rounded;
    if (packageName.contains('spotify')) return Icons.music_note_rounded;
    if (packageName.contains('gmail')) return Icons.email_rounded;
    if (packageName.contains('telegram')) return Icons.send_rounded;
    if (packageName.contains('reddit')) return Icons.reddit_rounded;
    return Icons.apps_rounded;
  }
}
