import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/dhikr_model.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class CompletionScreen extends StatefulWidget {
  final TasbeehSession session;
  final String? challengeId;

  const CompletionScreen({super.key, required this.session, this.challengeId});

  @override
  State<CompletionScreen> createState() => _CompletionScreenState();
}

class _CompletionScreenState extends State<CompletionScreen> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _fadeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _scaleAnimation = CurvedAnimation(parent: _scaleController, curve: Curves.bounceOut);
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
    _scaleController.forward();
    Future.delayed(const Duration(milliseconds: 300), () => _fadeController.forward());
    HapticFeedback.heavyImpact();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isChallenge = widget.challengeId != null;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: 130, height: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(colors: [AppTheme.accentGreen, AppTheme.lightGreen], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [BoxShadow(color: AppTheme.accentGreen.withOpacity(0.5), blurRadius: 40, spreadRadius: 10)],
                    ),
                    child: const Icon(Icons.check_rounded, color: Colors.white, size: 70),
                  ),
                ),
                const SizedBox(height: 32),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      Text(
                        isChallenge ? 'أكملت تسبيح اليوم! 🎉' : 'مبارك! أكملت التسبيح',
                        style: const TextStyle(color: AppTheme.textPrimary, fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'سبّحت ${widget.session.targetCount} مرة',
                        style: const TextStyle(color: AppTheme.lightGreen, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      if (isChallenge) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppTheme.accentGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppTheme.accentGreen.withOpacity(0.3)),
                          ),
                          child: const Row(children: [
                            Icon(Icons.lock_open_rounded, color: AppTheme.lightGreen, size: 22),
                            SizedBox(width: 10),
                            Expanded(child: Text('تم فتح جميع التطبيقات المقفلة لبقية اليوم', style: TextStyle(color: AppTheme.textPrimary, fontSize: 14))),
                          ]),
                        ),
                      ] else if (widget.session.lockedApps.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(color: AppTheme.cardBg, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.accentGreen.withOpacity(0.3))),
                          child: Row(children: [
                            const Icon(Icons.lock_open_rounded, color: AppTheme.lightGreen, size: 20),
                            const SizedBox(width: 10),
                            Text('${widget.session.lockedApps.length} تطبيقات تم إلغاء قفلها', style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14)),
                          ]),
                        ),
                      ],
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: AppTheme.accentGreen.withOpacity(0.08), borderRadius: BorderRadius.circular(14)),
                        child: const Text('اللَّهُمَّ تَقَبَّلْ مِنَّا', style: TextStyle(color: AppTheme.textPrimary, fontSize: 20, height: 1.8), textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity, height: 56,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomeScreen()), (r) => false),
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accentGreen, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    child: const Text('العودة للرئيسية', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity, height: 56,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(foregroundColor: AppTheme.lightGreen, side: const BorderSide(color: AppTheme.accentGreen), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    child: const Text('تسبيح مرة أخرى', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
