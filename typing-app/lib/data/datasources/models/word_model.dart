import '../../domain/models/word.dart';

class WordModel extends Word {
  const WordModel({
    required String id,
    required String text,
    required String hiragana,
    required String meaning,
    required int difficulty,
  }) : super(
    id: id,
    text: text,
    hiragana: hiragana,
    meaning: meaning,
    difficulty: difficulty,
  );

  factory WordModel.fromDomain(Word word) {
    return WordModel(
      id: word.id,
      text: word.text,
      hiragana: word.hiragana,
      meaning: word.meaning,
      difficulty: word.difficulty,
    );
  }

  Word toDomain() => Word(
    id: id,
    text: text,
    hiragana: hiragana,
    meaning: meaning,
    difficulty: difficulty,
  );
}
