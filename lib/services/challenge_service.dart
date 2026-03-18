import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DailyChallenge {
  final String id;
  final String name;
  final String dhikrId;
  final String dhikrText;
  final int targetCount;
  int currentCount;
  final DateTime createdAt;
  bool isCompleted;

  DailyChallenge({
    required this.id,
    required this.name,
    required this.dhikrId,
    required this.dhikrText,
    required this.targetCount,
    this.currentCount = 0,
    required this.createdAt,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'dhikrId': dhikrId,
        'dhikrText': dhikrText,
        'targetCount': targetCount,
        'currentCount': currentCount,
        'createdAt': createdAt.toIso8601String(),
        'isCompleted': isCompleted,
      };

  factory DailyChallenge.fromJson(Map<String, dynamic> json) => DailyChallenge(
        id: json['id'],
        name: json['name'],
        dhikrId: json['dhikrId'],
        dhikrText: json['dhikrText'],
        targetCount: json['targetCount'],
        currentCount: json['currentCount'] ?? 0,
        createdAt: DateTime.parse(json['createdAt']),
        isCompleted: json['isCompleted'] ?? false,
      );

  double get progress =>
      targetCount > 0 ? (currentCount / targetCount).clamp(0.0, 1.0) : 0.0;
}

class ChallengeService {
  static const String _challengesKey = 'daily_challenges';

  static Future<List<DailyChallenge>> getChallenges() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_challengesKey);
    if (jsonStr == null) return [];
    final List<dynamic> jsonList = jsonDecode(jsonStr);
    return jsonList.map((e) => DailyChallenge.fromJson(e)).toList();
  }

  static Future<void> saveChallenges(List<DailyChallenge> challenges) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(challenges.map((c) => c.toJson()).toList());
    await prefs.setString(_challengesKey, jsonStr);
  }

  static Future<void> addChallenge(DailyChallenge challenge) async {
    final challenges = await getChallenges();
    challenges.add(challenge);
    await saveChallenges(challenges);
  }

  static Future<void> updateChallenge(DailyChallenge updated) async {
    final challenges = await getChallenges();
    final index = challenges.indexWhere((c) => c.id == updated.id);
    if (index != -1) {
      challenges[index] = updated;
      await saveChallenges(challenges);
    }
  }

  static Future<void> deleteChallenge(String id) async {
    final challenges = await getChallenges();
    challenges.removeWhere((c) => c.id == id);
    await saveChallenges(challenges);
  }

  static Future<void> incrementChallenge(String id) async {
    final challenges = await getChallenges();
    final index = challenges.indexWhere((c) => c.id == id);
    if (index != -1) {
      challenges[index].currentCount++;
      if (challenges[index].currentCount >= challenges[index].targetCount) {
        challenges[index].isCompleted = true;
      }
      await saveChallenges(challenges);
    }
  }
}
