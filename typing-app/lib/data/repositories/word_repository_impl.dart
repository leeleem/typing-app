import '../../domain/models/word.dart';
import '../../domain/repositories/word_repository.dart';
import '../datasources/word_datasource.dart';

class WordRepositoryImpl implements WordRepository {
  final WordDataSource _dataSource;

  WordRepositoryImpl(this._dataSource);

  @override
  Future<List<Word>> getWords({
    required int difficulty,
    required int limit,
  }) {
    return _dataSource.getWords(difficulty: difficulty, limit: limit);
  }

  @override
  Future<Word?> getRandomWord({required int difficulty}) {
    return _dataSource.getRandomWord(difficulty: difficulty);
  }

  @override
  Future<List<Word>> searchWords(String query) {
    return _dataSource.searchWords(query);
  }
}
