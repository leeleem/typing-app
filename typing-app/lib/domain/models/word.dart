class Word {
  final String id;
  final String text;
  final String hiragana;
  final String meaning;
  final int difficulty; // 1-5

  const Word({
    required this.id,
    required this.text,
    required this.hiragana,
    required this.meaning,
    required this.difficulty,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['id'] ?? '',
      text: json['text'] ?? '',
      hiragana: json['hiragana'] ?? '',
      meaning: json['meaning'] ?? '',
      difficulty: json['difficulty'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'hiragana': hiragana,
      'meaning': meaning,
      'difficulty': difficulty,
    };
  }

  @override
  String toString() => 'Word(id: $id, text: $text, hiragana: $hiragana)';
}
