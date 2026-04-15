import '../models/score.dart';

abstract class ScoreRepository {
  Future<void> saveScore(Score score);

  Future<List<Score>> getHighScores({required int limit});

  Future<List<Score>> getAllScores();

  Future<void> deleteScore(String id);

  Future<Score?> getLastScore();
}
