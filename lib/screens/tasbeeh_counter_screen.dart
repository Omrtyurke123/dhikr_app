import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/dhikr_model.dart';
import '../theme/app_theme.dart';
import 'completion_screen.dart';

class TasbeehCounterScreen extends StatefulWidget {
  final TasbeehSession session;
  final List<DhikrItem>? dhikrItems;   // Multiple items for sequential mode
  final String? challengeId;
  final int alreadyDone;
  final VoidCallback? onCompleted;

  const TasbeehCounterScreen({
    super.key,
    required this.session,
    this.dhikrItems,
    this.challengeId,
    this.alreadyDone = 0,
    this.onCompleted,
  });

  @override
  State<TasbeehCounterScreen> createState() => _TasbeehCounterScreenState();
}

class _TasbeehCounterScreenState extends State<TasbeehCounterScreen> with TickerProviderStateMixin {
  late TasbeehSession _session;
  late AnimationController _pulseController;
  late AnimationController _rippleController;
  late AnimationController _progressController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rippleAnimation;
  late Animation<double> _progressAnimation;
  bool _vibrationEnabled = true;

  // For multi-item sequential mode
  int _currentItemIndex = 0;
  int _currentItemCount = 0;

  List<DhikrItem>? get _items => widget.dhikrItems;
  DhikrItem? get _currentItem => _items != null && _currentItemIndex < _items!.length ? _items![_currentItemIndex] : null;
  bool get _isMultiMode => _items != null && _items!.length > 1;

  @override
  void initState() {
    super.initState();
    _session = widget.session;

    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _rippleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _progressController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));

    _pulseAnimation = Tween<double>(begin: 1.0, end: 0.88).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeOut));
    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _rippleController, curve: Curves.easeOut));
    _progressAnimation = Tween<double>(begin: 0, end: 0).animate(_progressController);

    _progressController.forward();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rippleController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _increment() {
    if (_session.currentCount >= _session.targetCount) return;

    if (_vibrationEnabled) HapticFeedback.mediumImpact();

    _pulseController.forward().then((_) => _pulseController.reverse());
    _rippleController.forward(from: 0);

    setState(() {
      _session.currentCount++;
      if (_isMultiMode) {
        _currentItemCount++;
        final item = _currentItem;
        if (item != null && _currentItemCount >= item.defaultCount) {
          // Advance to next item
          _currentItemIndex++;
          _currentItemCount = 0;
        }
      }
    });

    final target = _session.targetCount > 0 ? _session.targetCount : 1;
    _progressController.animateTo(_session.currentCount / target, duration: const Duration(milliseconds: 300));

    if (_session.currentCount >= _session.targetCount) {
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) {
          _session.isCompleted = true;
          widget.onCompleted?.call();
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (_) => CompletionScreen(session: _session, challengeId: widget.challengeId),
          ));
        }
      });
    }
  }

  void _reset() {
    HapticFeedback.lightImpact();
    showDialog(
      context: context,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: AppTheme.cardBg,
          title: const Text('إعادة التعيين', style: TextStyle(color: AppTheme.textPrimary)),
          content: const Text('هل تريد إعادة العد من الصفر؟', style: TextStyle(color: AppTheme.textSecondary)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء', style: TextStyle(color: AppTheme.textSecondary))),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() { _session.currentCount = 0; _currentItemIndex = 0; _currentItemCount = 0; });
                _progressController.animateTo(0, duration: const Duration(milliseconds: 400));
              },
              child: const Text('إعادة', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress = _session.targetCount > 0 ? _session.currentCount / _session.targetCount : 0.0;
    final remaining = _session.targetCount - _session.currentCount;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(
          backgroundColor: AppTheme.darkBg,
          title: Text(
            widget.challengeId != null ? 'تسبيح التحدي اليومي' : 'السبحة الإلكترونية',
            style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios_rounded, color: AppTheme.textPrimary), onPressed: () => Navigator.pop(context)),
          actions: [
            IconButton(
              icon: Icon(_vibrationEnabled ? Icons.vibration_rounded : Icons.phone_android_rounded, color: _vibrationEnabled ? AppTheme.lightGreen : AppTheme.textSecondary),
              onPressed: () => setState(() => _vibrationEnabled = !_vibrationEnabled),
            ),
            IconButton(icon: const Icon(Icons.refresh_rounded, color: AppTheme.textSecondary), onPressed: _reset),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _buildDhikrCard(),
                  const SizedBox(height: 20),
                  _buildProgressInfo(remaining, progress),
                  const SizedBox(height: 8),
                  if (_isMultiMode) _buildItemProgressBar(),
                  Expanded(child: Center(child: _buildMainButton(progress))),
                  if (_session.lockedApps.isNotEmpty) _buildLockedAppsBar(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDhikrCard() {
    final displayText = _isMultiMode && _currentItem != null
        ? _currentItem!.arabic
        : _session.dhikrText.split(' | ').first;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.accentGreen.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            if (_isMultiMode)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  'الذكر ${_currentItemIndex + 1} من ${_items!.length}',
                  style: const TextStyle(color: AppTheme.lightGreen, fontSize: 12),
                ),
              ),
            Text(
              displayText.length > 120 ? '${displayText.substring(0, 120)}...' : displayText,
              style: const TextStyle(color: AppTheme.textPrimary, fontSize: 16, height: 1.8),
              textAlign: TextAlign.center,
            ),
            if (_isMultiMode && _currentItem != null) ...[
              const SizedBox(height: 6),
              Text('$_currentItemCount / ${_currentItem!.defaultCount}', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildItemProgressBar() {
    if (_items == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: _items!.asMap().entries.map((e) {
          final isDone = e.key < _currentItemIndex;
          final isCurrent = e.key == _currentItemIndex;
          return Expanded(
            child: Container(
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: isDone ? AppTheme.lightGreen : isCurrent ? AppTheme.accentGreen : AppTheme.cardBg,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProgressInfo(int remaining, double progress) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('متبقي', style: TextStyle(color: AppTheme.textSecondary.withOpacity(0.7), fontSize: 12)),
            Text('$remaining', style: const TextStyle(color: AppTheme.textPrimary, fontSize: 28, fontWeight: FontWeight.bold)),
          ]),
          Column(children: [
            Text('${(progress * 100).toInt()}%', style: const TextStyle(color: AppTheme.lightGreen, fontSize: 22, fontWeight: FontWeight.bold)),
            Text('مكتمل', style: TextStyle(color: AppTheme.textSecondary.withOpacity(0.7), fontSize: 12)),
          ]),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('الهدف', style: TextStyle(color: AppTheme.textSecondary.withOpacity(0.7), fontSize: 12)),
            Text('${_session.targetCount}', style: const TextStyle(color: AppTheme.textPrimary, fontSize: 28, fontWeight: FontWeight.bold)),
          ]),
        ],
      ),
    );
  }

  Widget _buildMainButton(double progress) {
    return GestureDetector(
      onTap: _increment,
      child: AnimatedBuilder(
        animation: Listenable.merge([_pulseAnimation, _rippleAnimation]),
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              if (_rippleController.isAnimating)
                Container(
                  width: 200 + (_rippleAnimation.value * 70),
                  height: 200 + (_rippleAnimation.value * 70),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.lightGreen.withOpacity(1 - _rippleAnimation.value), width: 2),
                  ),
                ),
              SizedBox(
                width: 210, height: 210,
                child: CustomPaint(
                  painter: _CircularProgressPainter(
                    progress: _progressAnimation.value.clamp(0.0, 1.0),
                    color: AppTheme.lightGreen,
                    backgroundColor: AppTheme.cardBg,
                    strokeWidth: 8,
                  ),
                ),
              ),
              Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 180, height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                      colors: [AppTheme.lightGreen, AppTheme.accentGreen],
                      center: Alignment(-0.3, -0.3),
                    ),
                    boxShadow: [BoxShadow(color: AppTheme.accentGreen.withOpacity(0.4), blurRadius: 35, spreadRadius: 5)],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${_session.currentCount}', style: const TextStyle(color: Colors.white, fontSize: 56, fontWeight: FontWeight.bold, height: 1)),
                      const SizedBox(height: 4),
                      const Text('سبح', style: TextStyle(color: Colors.white70, fontSize: 20)),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLockedAppsBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withOpacity(0.3)),
      ),
      child: Row(children: [
        const Icon(Icons.lock_rounded, color: Colors.redAccent, size: 18),
        const SizedBox(width: 8),
        Expanded(child: Text('${_session.lockedApps.length} تطبيقات مقفلة حتى تكمل التسبيح', style: const TextStyle(color: Colors.redAccent, fontSize: 13))),
      ]),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;

  _CircularProgressPainter({required this.progress, required this.color, required this.backgroundColor, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    const startAngle = -3.14159 / 2;
    canvas.drawCircle(center, radius, Paint()..color = backgroundColor..strokeWidth = strokeWidth..style = PaintingStyle.stroke..strokeCap = StrokeCap.round);
    if (progress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius), startAngle, 2 * 3.14159 * progress, false,
        Paint()..color = color..strokeWidth = strokeWidth..style = PaintingStyle.stroke..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(_CircularProgressPainter old) => old.progress != progress;
}
