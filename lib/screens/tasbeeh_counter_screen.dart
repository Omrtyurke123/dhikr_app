import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/dhikr_model.dart';
import '../theme/app_theme.dart';
import 'completion_screen.dart';

class TasbeehCounterScreen extends StatefulWidget {
  final DhikrModel dhikr;

  const TasbeehCounterScreen({super.key, required this.dhikr});

  @override
  State<TasbeehCounterScreen> createState() => _TasbeehCounterScreenState();
}

class _TasbeehCounterScreenState extends State<TasbeehCounterScreen>
    with SingleTickerProviderStateMixin {
  int _count = 0;
  late AnimationController _animController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _increment() {
    HapticFeedback.lightImpact();
    _animController.forward().then((_) => _animController.reverse());
    setState(() {
      _count++;
    });
    if (_count >= widget.dhikr.count) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => CompletionScreen(dhikr: widget.dhikr),
            ),
          );
        }
      });
    }
  }

  void _reset() {
    setState(() => _count = 0);
  }

  @override
  Widget build(BuildContext context) {
    final progress = _count / widget.dhikr.count;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dhikr.meaning),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reset,
            tooltip: 'إعادة',
          ),
        ],
      ),
      body: Column(
        children: [
          // شريط التقدم
          LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: AppTheme.cardColor,
            color: AppTheme.accentGreen,
            minHeight: 6,
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // نص الذكر
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      widget.dhikr.arabic,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 22,
                        height: 1.8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // زر العد
                  GestureDetector(
                    onTap: _increment,
                    child: ScaleTransition(
                      scale: _scaleAnim,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.accentGreen,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.accentGreen.withOpacity(0.4),
                              blurRadius: 20,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$_count',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'من ${widget.dhikr.count}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'اضغط للتسبيح',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
