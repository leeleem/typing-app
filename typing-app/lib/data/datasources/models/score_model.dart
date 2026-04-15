import '../../domain/models/score.dart';

class ScoreModel extends Score {
  const ScoreModel({
    required String id,
    required int points,
    required int wordsTyped,
    required int comboCount,
    required Duration playTime,
    required DateTime createdAt,
    required String difficulty,
  }) : super(
    id: id,
    points: points,
    wordsTyped: wordsTyped,
    comboCount: comboCount,
    playTime: playTime,
    createdAt: createdAt,
    difficulty: difficulty,
  );

  factory ScoreModel.fromDomain(Score score) {
    return ScoreModel(
      id: score.id,
      points: score.points,
      wordsTyped: score.wordsTyped,
      comboCount: score.comboCount,
      playTime: score.playTime,
      createdAt: score.createdAt,
      difficulty: score.difficulty,
    );
  }

  Score toDomain() => Score(
    id: id,
    points: points,
    wordsTyped: wordsTyped,
    comboCount: comboCount,
    playTime: playTime,
    createdAt: createdAt,
    difficulty: difficulty,
  );
}
