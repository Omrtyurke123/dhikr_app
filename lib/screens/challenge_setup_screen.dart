import 'package:flutter/material.dart';
import '../data/adhkar_data.dart';
import '../models/dhikr_model.dart';
import '../services/challenge_service.dart';
import '../theme/app_theme.dart';

class ChallengeSetupScreen extends StatefulWidget {
  const ChallengeSetupScreen({super.key});

  @override
  State<ChallengeSetupScreen> createState() => _ChallengeSetupScreenState();
}

class _ChallengeSetupScreenState extends State<ChallengeSetupScreen> {
  final _nameController = TextEditingController();
  DhikrModel? _selectedDhikr;
  int _targetCount = 100;
  final List<int> _presets = [33, 70, 100, 200, 500, 1000];

  List<DhikrModel> get _allDhikr =>
      AdhkarData.categories.expand((c) => c.adhkar).toList();

  Future<void> _save() async {
    if (_selectedDhikr == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('اختر ذكراً أولاً')),
      );
      return;
    }
    final name = _nameController.text.trim().isEmpty
        ? _selectedDhikr!.meaning
        : _nameController.text.trim();

    final challenge = DailyChallenge(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      dhikrId: _selectedDhikr!.id,
      dhikrText: _selectedDhikr!.arabic,
      targetCount: _targetCount,
      createdAt: DateTime.now(),
    );

    await ChallengeService.addChallenge(challenge);
    if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحدي جديد'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: AppTheme.accentGreen),
            onPressed: _save,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // اسم التحدي
          const Text('اسم التحدي (اختياري)',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
          const SizedBox(height: 8),
          TextField(
            controller: _nameController,
            textDirection: TextDirection.rtl,
            style: const TextStyle(color: AppTheme.textPrimary),
            decoration: InputDecoration(
              hintText: 'مثال: تحدي الصباح',
              hintStyle: const TextStyle(color: AppTheme.textSecondary),
              filled: true,
              fillColor: AppTheme.cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // اختيار الذكر
          const Text('اختر الذكر',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<DhikrModel>(
                value: _selectedDhikr,
                hint: const Text('اختر ذكراً',
                    style: TextStyle(color: AppTheme.textSecondary)),
                dropdownColor: AppTheme.cardColor,
                isExpanded: true,
                items: _allDhikr.map((d) {
                  return DropdownMenuItem(
                    value: d,
                    child: Text(
                      d.meaning,
                      style: const TextStyle(color: AppTheme.textPrimary),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedDhikr = val),
              ),
            ),
          ),

          if (_selectedDhikr != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.accentGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.accentGreen.withOpacity(0.3)),
              ),
              child: Text(
                _selectedDhikr!.arabic,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppTheme.textPrimary, fontSize: 16, height: 1.6),
              ),
            ),
          ],

          const SizedBox(height: 24),

          // العدد المستهدف
          const Text('العدد المستهدف',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _presets.map((p) {
              final selected = _targetCount == p;
              return GestureDetector(
                onTap: () => setState(() => _targetCount = p),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: selected ? AppTheme.accentGreen : AppTheme.cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selected
                          ? AppTheme.accentGreen
                          : AppTheme.textSecondary.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    '$p',
                    style: TextStyle(
                      color: selected ? Colors.white : AppTheme.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          Slider(
            value: _targetCount.toDouble(),
            min: 1,
            max: 1000,
            divisions: 99,
            activeColor: AppTheme.accentGreen,
            inactiveColor: AppTheme.cardColor,
            label: '$_targetCount مرة',
            onChanged: (v) => setState(() => _targetCount = v.toInt()),
          ),
          Center(
            child: Text(
              '$_targetCount مرة',
              style: const TextStyle(
                  color: AppTheme.accentGreen,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentGreen,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: _save,
            child: const Text('حفظ التحدي',
                style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
