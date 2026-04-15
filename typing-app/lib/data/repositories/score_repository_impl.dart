import '../../domain/models/score.dart';
import '../../domain/repositories/score_repository.dart';
import '../datasources/score_datasource.dart';

class ScoreRepositoryImpl implements ScoreRepository {
  final ScoreDataSource _dataSource;

  ScoreRepositoryImpl(this._dataSource);

  @override
  Future<void> saveScore(Score score) {
    return _dataSource.saveScore(score);
  }

  @override
  Future<List<Score>> getHighScores({required int limit}) {
    return _dataSource.getHighScores(limit: limit);
  }

  @override
  Future<List<Score>> getAllScores() {
    return _dataSource.getAllScores();
  }

  @override
  Future<void> deleteScore(String id) {
    return _dataSource.deleteScore(id);
  }

  @override
  Future<Score?> getLastScore() {
    return _dataSource.getLastScore();
  }
}
