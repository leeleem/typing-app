import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../domain/models/score.dart';

abstract class ScoreDataSource {
  Future<void> saveScore(Score score);

  Future<List<Score>> getHighScores({required int limit});

  Future<List<Score>> getAllScores();

  Future<void> deleteScore(String id);

  Future<Score?> getLastScore();
}

class ScoreDataSourceImpl implements ScoreDataSource {
  static const String _scoresKey = 'scores';

  @override
  Future<void> saveScore(Score score) async {
    final prefs = await SharedPreferences.getInstance();
    final scores = await getAllScores();
    scores.add(score);

    // 降順でソート
    scores.sort((a, b) => b.points.compareTo(a.points));

    final jsonList = scores.map((s) => jsonEncode(s.toJson())).toList();
    await prefs.setStringList(_scoresKey, jsonList);
  }

  @override
  Future<List<Score>> getHighScores({required int limit}) async {
    final scores = await getAllScores();
    scores.sort((a, b) => b.points.compareTo(a.points));
    return scores.take(limit).toList();
  }

  @override
  Future<List<Score>> getAllScores() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_scoresKey) ?? [];
    return jsonList.map((json) => Score.fromJson(jsonDecode(json))).toList();
  }

  @override
  Future<void> deleteScore(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final scores = await getAllScores();
    scores.removeWhere((score) => score.id == id);

    final jsonList = scores.map((s) => jsonEncode(s.toJson())).toList();
    await prefs.setStringList(_scoresKey, jsonList);
  }

  @override
  Future<Score?> getLastScore() async {
    final scores = await getAllScores();
    if (scores.isEmpty) return null;
    scores.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return scores.first;
  }
}
