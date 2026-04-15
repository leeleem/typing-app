import '../../domain/models/word.dart';

abstract class WordDataSource {
  Future<List<Word>> getWords({
    required int difficulty,
    required int limit,
  });

  Future<Word?> getRandomWord({required int difficulty});

  Future<List<Word>> searchWords(String query);
}

class WordDataSourceImpl implements WordDataSource {
  // ローカルデータベース（デモ用）
  static final List<Word> _localWords = [
    Word(
      id: '1',
      text: 'りんご',
      hiragana: 'りんご',
      meaning: 'Apple',
      difficulty: 1,
    ),
    Word(
      id: '2',
      text: 'みずうみ',
      hiragana: 'みずうみ',
      meaning: 'Lake',
      difficulty: 2,
    ),
    Word(
      id: '3',
      text: 'あなたのなまえ',
      hiragana: 'あなたのなまえ',
      meaning: 'Your name',
      difficulty: 3,
    ),
    Word(
      id: '4',
      text: 'こんにちは',
      hiragana: 'こんにちは',
      meaning: 'Hello',
      difficulty: 1,
    ),
    Word(
      id: '5',
      text: 'ありがとう',
      hiragana: 'ありがとう',
      meaning: 'Thank you',
      difficulty: 2,
    ),
    Word(
      id: '6',
      text: 'さようなら',
      hiragana: 'さようなら',
      meaning: 'Goodbye',
      difficulty: 1,
    ),
  ];

  @override
  Future<List<Word>> getWords({
    required int difficulty,
    required int limit,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _localWords
        .where((word) => word.difficulty == difficulty)
        .take(limit)
        .toList();
  }

  @override
  Future<Word?> getRandomWord({required int difficulty}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final words = _localWords.where((w) => w.difficulty == difficulty).toList();
    if (words.isEmpty) return null;
    words.shuffle();
    return words.first;
  }

  @override
  Future<List<Word>> searchWords(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _localWords
        .where(
          (word) =>
              word.text.contains(query) ||
              word.hiragana.contains(query) ||
              word.meaning.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
