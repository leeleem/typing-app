import '../models/word.dart';

abstract class WordRepository {
  Future<List<Word>> getWords({
    required int difficulty,
    required int limit,
  });

  Future<Word?> getRandomWord({required int difficulty});

  Future<List<Word>> searchWords(String query);
}
