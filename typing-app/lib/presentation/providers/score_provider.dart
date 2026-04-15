import 'package:flutter/foundation.dart';
import '../../domain/models/score.dart';
import '../../data/datasources/score_datasource.dart';
import '../../data/repositories/score_repository_impl.dart';

class ScoreProvider extends ChangeNotifier {
  late ScoreRepositoryImpl _scoreRepository;

  List<Score> _highScores = [];
  Score? _lastScore;

  List<Score> get highScores => _highScores;
  Score? get lastScore => _lastScore;

  ScoreProvider() {
    _initializeRepository();
    _loadHighScores();
  }

  void _initializeRepository() {
    final scoreDataSource = ScoreDataSourceImpl();
    _scoreRepository = ScoreRepositoryImpl(scoreDataSource);
  }

  Future<void> _loadHighScores() async {
    _highScores = await _scoreRepository.getHighScores(limit: 10);
    notifyListeners();
  }

  Future<void> loadLastScore() async {
    _lastScore = await _scoreRepository.getLastScore();
    notifyListeners();
  }

  Future<void> refreshScores() async {
    await _loadHighScores();
    await loadLastScore();
  }
}
