import 'package:flutter/material.dart';
import '../models/dhikr_model.dart';
import '../theme/app_theme.dart';
import 'challenge_setup_screen.dart';
import 'tasbeeh_counter_screen.dart';

class DhikrListScreen extends StatefulWidget {
  final DhikrCategory category;
  const DhikrListScreen({super.key, required this.category});
  @override
  State<DhikrListScreen> createState() => _DhikrListScreenState();
}

class _DhikrListScreenState extends State<DhikrListScreen> {
  // Auto-select all items for morning/evening/istighfar/tasbeeh/salawat
  late Set<String> _selectedIds;
  bool get _isAutoCategory => [
    CategoryType.morning, CategoryType.evening, CategoryType.istighfar,
    CategoryType.tasbeeh, CategoryType.salawat
  ].contains(widget.category.type);

  @override
  void initState() {
    super.initState();
    if (_isAutoCategory) {
      _selectedIds = widget.category.items.map((i) => i.id).toSet();
    } else {
      _selectedIds = {};
    }
  }

  List<DhikrItem> get _selectedItems =>
      widget.category.items.where((i) => _selectedIds.contains(i.id)).toList();

  int get _totalCount => _selectedItems.fold(0, (sum, i) => sum + i.defaultCount);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(
          backgroundColor: AppTheme.darkBg,
          title: Text(widget.category.title, style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.bold, fontSize: 20)),
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios_rounded, color: AppTheme.textPrimary), onPressed: () => Navigator.pop(context)),
          actions: [
            if (_isAutoCategory)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Center(
                  child: GestureDetector(
                    onTap: () => setState(() {
                      if (_selectedIds.length == widget.category.items.length) {
                        _selectedIds.clear();
                      } else {
                        _selectedIds = widget.category.items.map((i) => i.id).toSet();
                      }
                    }),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: AppTheme.accentGreen.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        _selectedIds.length == widget.category.items.length ? 'إلغاء الكل' : 'تحديد الكل',
                        style: const TextStyle(color: AppTheme.lightGreen, fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        body: Column(
          children: [
            if (_isAutoCategory) _buildSelectionBanner(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                itemCount: widget.category.items.length,
                itemBuilder: (context, i) => _DhikrCard(
                  item: widget.category.items[i],
                  isSelected: _selectedIds.contains(widget.category.items[i].id),
                  showCheckbox: _isAutoCategory,
                  onToggle: () => setState(() {
                    final id = widget.category.items[i].id;
                    if (_selectedIds.contains(id)) {
                      _selectedIds.remove(id);
                    } else {
                      _selectedIds.add(id);
                    }
                  }),
                  onStartTasbeeh: () => _startSingleTasbeeh(widget.category.items[i]),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: _selectedItems.isNotEmpty ? _buildActionBar() : null,
      ),
    );
  }

  Widget _buildSelectionBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: AppTheme.accentGreen.withOpacity(0.1),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: AppTheme.lightGreen, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'تم تحديد ${_selectedIds.length} من ${widget.category.items.length} أذكار',
              style: const TextStyle(color: AppTheme.lightGreen, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        border: Border(top: BorderSide(color: AppTheme.accentGreen.withOpacity(0.2))),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _startChallenge(),
              icon: const Icon(Icons.lock_clock_rounded, size: 18),
              label: const Text('تحدٍّ يومي'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.lightGreen,
                side: const BorderSide(color: AppTheme.accentGreen),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              onPressed: _startGroupTasbeeh,
              icon: const Icon(Icons.play_circle_rounded, size: 20),
              label: Text('ابدأ ($_totalCount تسبيحة)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startSingleTasbeeh(DhikrItem item) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => TasbeehCounterScreen(session: TasbeehSession(
        dhikrId: item.id, dhikrText: item.arabic,
        targetCount: item.defaultCount, lockedApps: [],
      )),
    ));
  }

  void _startGroupTasbeeh() {
    if (_selectedItems.isEmpty) return;
    // Combine selected items into one sequential session
    final first = _selectedItems.first;
    final total = _totalCount;
    final combined = _selectedItems.map((i) => i.arabic).join('\n\n');
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => TasbeehCounterScreen(
        session: TasbeehSession(dhikrId: first.id, dhikrText: combined, targetCount: total, lockedApps: []),
        dhikrItems: _selectedItems,
      ),
    ));
  }

  void _startChallenge() {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => ChallengeSetupScreen(selectedItems: _selectedItems),
    ));
  }
}

class _DhikrCard extends StatefulWidget {
  final DhikrItem item;
  final bool isSelected;
  final bool showCheckbox;
  final VoidCallback onToggle;
  final VoidCallback onStartTasbeeh;
  const _DhikrCard({required this.item, required this.isSelected, required this.showCheckbox, required this.onToggle, required this.onStartTasbeeh});
  @override
  State<_DhikrCard> createState() => _DhikrCardState();
}

class _DhikrCardState extends State<_DhikrCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: widget.isSelected && widget.showCheckbox ? AppTheme.accentGreen.withOpacity(0.08) : AppTheme.cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: widget.isSelected && widget.showCheckbox ? AppTheme.lightGreen.withOpacity(0.5) : AppTheme.accentGreen.withOpacity(0.2),
            width: widget.isSelected && widget.showCheckbox ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: widget.showCheckbox ? widget.onToggle : null,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.showCheckbox)
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 4),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 22, height: 22,
                              decoration: BoxDecoration(
                                color: widget.isSelected ? AppTheme.accentGreen : Colors.transparent,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: widget.isSelected ? AppTheme.lightGreen : AppTheme.textSecondary.withOpacity(0.4)),
                              ),
                              child: widget.isSelected ? const Icon(Icons.check_rounded, color: Colors.white, size: 14) : null,
                            ),
                          ),
                        Expanded(
                          child: Text(
                            widget.item.arabic,
                            style: const TextStyle(color: AppTheme.textPrimary, fontSize: 17, height: 2.0),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    if (widget.item.virtue.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: AppTheme.accentGreen.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
                        child: Text(widget.item.virtue, style: const TextStyle(color: AppTheme.lightGreen, fontSize: 12)),
                      ),
                    ],
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(color: AppTheme.accentGreen.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                          child: Row(children: [
                            const Icon(Icons.repeat_rounded, color: AppTheme.lightGreen, size: 14),
                            const SizedBox(width: 4),
                            Text('${widget.item.defaultCount} ×', style: const TextStyle(color: AppTheme.lightGreen, fontSize: 13)),
                          ]),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => setState(() => _expanded = !_expanded),
                          child: Row(children: [
                            Text(_expanded ? 'إخفاء' : 'الترجمة', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                            Icon(_expanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, color: AppTheme.textSecondary, size: 18),
                          ]),
                        ),
                      ],
                    ),
                    if (_expanded) ...[
                      const SizedBox(height: 8),
                      Text(widget.item.translation, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13, height: 1.6, fontStyle: FontStyle.italic), textDirection: TextDirection.ltr, textAlign: TextAlign.left),
                    ],
                  ],
                ),
              ),
            ),
            if (!widget.showCheckbox)
              GestureDetector(
                onTap: widget.onStartTasbeeh,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [AppTheme.accentGreen, AppTheme.lightGreen]),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                  ),
                  child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(Icons.touch_app_rounded, color: Colors.white, size: 18),
                    SizedBox(width: 6),
                    Text('ابدأ التسبيح', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                  ]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
