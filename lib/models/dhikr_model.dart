class DhikrCategory {
  final String id;
  final String title;
  final String subtitle;
  final String iconAsset;
  final List<DhikrItem> items;
  final CategoryType type;

  const DhikrCategory({
    required this.id,
    required this.title,
    this.subtitle = '',
    required this.iconAsset,
    required this.items,
    required this.type,
  });
}

enum CategoryType { morning, evening, night, prayer, sleep, misc, istighfar, tasbeeh, salawat }

class DhikrItem {
  final String id;
  final String arabic;
  final String transliteration;
  final String translation;
  final int defaultCount;
  final String virtue;

  const DhikrItem({
    required this.id,
    required this.arabic,
    this.transliteration = '',
    required this.translation,
    required this.defaultCount,
    this.virtue = '',
  });
}

class AppInfo {
  final String packageName;
  final String appName;
  final bool isLocked;

  AppInfo({
    required this.packageName,
    required this.appName,
    this.isLocked = false,
  });
}

class TasbeehSession {
  final String dhikrId;
  final String dhikrText;
  final int targetCount;
  int currentCount;
  final List<String> lockedApps;
  bool isCompleted;

  TasbeehSession({
    required this.dhikrId,
    required this.dhikrText,
    required this.targetCount,
    required this.lockedApps,
    this.currentCount = 0,
    this.isCompleted = false,
  });
}

/// Represents an active challenge: a dhikr commitment over N days
class DhikrChallenge {
  final String id;
  final String dhikrId;
  final String dhikrText;
  final int dailyCount;          // Required tasbeehs per day
  final List<String> lockedApps;
  final DateTime startDate;
  final int durationDays;        // e.g. 30 for one month
  final Map<String, int> dailyProgress; // 'YYYY-MM-DD' -> count completed that day

  DhikrChallenge({
    required this.id,
    required this.dhikrId,
    required this.dhikrText,
    required this.dailyCount,
    required this.lockedApps,
    required this.startDate,
    required this.durationDays,
    Map<String, int>? dailyProgress,
  }) : dailyProgress = dailyProgress ?? {};

  DateTime get endDate => startDate.add(Duration(days: durationDays));
  bool get isActive => DateTime.now().isBefore(endDate);
  int get daysElapsed => DateTime.now().difference(startDate).inDays + 1;
  int get daysRemaining => durationDays - daysElapsed;

  String get todayKey {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')}';
  }

  int get todayCount => dailyProgress[todayKey] ?? 0;
  bool get todayCompleted => todayCount >= dailyCount;

  int get totalDaysCompleted =>
      dailyProgress.values.where((v) => v >= dailyCount).length;

  // Apps are unlocked today if today's tasbeeh is done
  bool get appsUnlockedToday => todayCompleted;

  Map<String, dynamic> toJson() => {
    'id': id,
    'dhikrId': dhikrId,
    'dhikrText': dhikrText,
    'dailyCount': dailyCount,
    'lockedApps': lockedApps,
    'startDate': startDate.toIso8601String(),
    'durationDays': durationDays,
    'dailyProgress': dailyProgress,
  };

  factory DhikrChallenge.fromJson(Map<String, dynamic> json) => DhikrChallenge(
    id: json['id'],
    dhikrId: json['dhikrId'],
    dhikrText: json['dhikrText'],
    dailyCount: json['dailyCount'],
    lockedApps: List<String>.from(json['lockedApps']),
    startDate: DateTime.parse(json['startDate']),
    durationDays: json['durationDays'],
    dailyProgress: Map<String, int>.from(json['dailyProgress'] ?? {}),
  );
}
