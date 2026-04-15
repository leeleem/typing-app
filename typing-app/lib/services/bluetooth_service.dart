import 'dart:async';
import 'package:uuid/uuid.dart';
import '../domain/models/word.dart';
import '../domain/models/score.dart';
import '../domain/repositories/word_repository.dart';
import '../domain/repositories/score_repository.dart';

class GameService {
  final WordRepository wordRepository;
  final ScoreRepository scoreRepository;

  GameService({
    required this.wordRepository,
    required this.scoreRepository,
  });

  Timer? _gameTimer;
  Duration _elapsedTime = Duration.zero;

  // ゲームロジック
  int calculateScore(Word word, Duration timeSpent) {
    int baseScore = word.difficulty * 10;
    
    // 時間ボーナス（3秒以内なら追加ポイント）
    if (timeSpent.inSeconds <= 3) {
      baseScore += word.difficulty * 5;
    }
    
    return baseScore;
  }

  bool validateInput(String userInput, Word word) {
    // ひらがなで比較
    return userInput.toLowerCase() == word.hiragana.toLowerCase();
  }

  int calculateComboBonus(int comboCount, int baseScore) {
    if (comboCount < 3) return 0;
    if (comboCount < 10) return (baseScore * 0.1).toInt();
    return (baseScore * 0.2).toInt();
  }

  // タイマー管理
  void startTimer(Function onTick) {
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _elapsedTime += const Duration(seconds: 1);
      onTick(_elapsedTime);
    });
  }

  void stopTimer() {
    _gameTimer?.cancel();
    _gameTimer = null;
  }

  void resetTimer() {
    stopTimer();
    _elapsedTime = Duration.zero;
  }

  Duration get elapsedTime => _elapsedTime;

  // スコア保存
  Future<void> saveGameScore({
    required int totalScore,
    required int wordsTyped,
    required int comboCount,
    required String difficulty,
  }) async {
    final score = Score(
      id: const Uuid().v4(),
      points: totalScore,
      wordsTyped: wordsTyped,
      comboCount: comboCount,
      playTime: _elapsedTime,
      createdAt: DateTime.now(),
      difficulty: difficulty,
    );

    await scoreRepository.saveScore(score);
  }

  // ゲーム終了処理
  Future<Score?> endGame({
    required int totalScore,
    required int wordsTyped,
    required int comboCount,
    required String difficulty,
  }) async {
    stopTimer();
    await saveGameScore(
      totalScore: totalScore,
      wordsTyped: wordsTyped,
      comboCount: comboCount,
      difficulty: difficulty,
    );
    return scoreRepository.getLastScore();
  }

  void dispose() {
    stopTimer();
  }
}
