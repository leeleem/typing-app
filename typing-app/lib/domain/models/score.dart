class Score {
  final String id;
  final int points;
  final int wordsTyped;
  final int comboCount;
  final Duration playTime;
  final DateTime createdAt;
  final String difficulty;

  const Score({
    required this.id,
    required this.points,
    required this.wordsTyped,
    required this.comboCount,
    required this.playTime,
    required this.createdAt,
    required this.difficulty,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      id: json['id'] ?? '',
      points: json['points'] ?? 0,
      wordsTyped: json['wordsTyped'] ?? 0,
      comboCount: json['comboCount'] ?? 0,
      playTime: Duration(
        seconds: json['playTimeSeconds'] ?? 0,
      ),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      difficulty: json['difficulty'] ?? 'normal',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'points': points,
      'wordsTyped': wordsTyped,
      'comboCount': comboCount,
      'playTimeSeconds': playTime.inSeconds,
      'createdAt': createdAt.toIso8601String(),
      'difficulty': difficulty,
    };
  }

  @override
  String toString() => 'Score(points: $points, wordsTyped: $wordsTyped)';
}
