import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/dhikr_model.dart';

class ChallengeService {
  static const _key = 'active_challenges';

  static Future<List<DhikrChallenge>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    return raw.map((s) => DhikrChallenge.fromJson(jsonDecode(s))).toList();
  }

  static Future<void> saveAll(List<DhikrChallenge> challenges) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = challenges.map((c) => jsonEncode(c.toJson())).toList();
    await prefs.setStringList(_key, raw);
  }

  static Future<void> addChallenge(DhikrChallenge challenge) async {
    final all = await loadAll();
    all.add(challenge);
    await saveAll(all);
  }

  static Future<void> deleteChallenge(String id) async {
    final all = await loadAll();
    all.removeWhere((c) => c.id == id);
    await saveAll(all);
  }

  static Future<void> updateProgress(String challengeId, String dateKey, int count) async {
    final all = await loadAll();
    final idx = all.indexWhere((c) => c.id == challengeId);
    if (idx == -1) return;
    all[idx].dailyProgress[dateKey] = count;
    await saveAll(all);
  }

  /// Get the list of apps that should be locked RIGHT NOW across all active challenges
  static Future<List<String>> getCurrentlyLockedApps() async {
    final all = await loadAll();
    final locked = <String>{};
    final now = DateTime.now();
    for (final c in all) {
      if (!c.isActive) continue;
      if (!c.todayCompleted) {
        locked.addAll(c.lockedApps);
      }
    }
    return locked.toList();
  }
}
