import 'word.dart';

enum GameStatus { idle, playing, paused, finished }

class GameState {
  final GameStatus status;
  final Word currentWord;
  final String userInput;
  final int score;
  final int comboCount;
  final int totalWordsTyped;
  final Duration elapsedTime;
  final List<Word> wordsList;

  const GameState({
    required this.status,
    required this.currentWord,
    required this.userInput,
    required this.score,
    required this.comboCount,
    required this.totalWordsTyped,
    required this.elapsedTime,
    required this.wordsList,
  });

  GameState copyWith({
    GameStatus? status,
    Word? currentWord,
    String? userInput,
    int? score,
    int? comboCount,
    int? totalWordsTyped,
    Duration? elapsedTime,
    List<Word>? wordsList,
  }) {
    return GameState(
      status: status ?? this.status,
      currentWord: currentWord ?? this.currentWord,
      userInput: userInput ?? this.userInput,
      score: score ?? this.score,
      comboCount: comboCount ?? this.comboCount,
      totalWordsTyped: totalWordsTyped ?? this.totalWordsTyped,
      elapsedTime: elapsedTime ?? this.elapsedTime,
      wordsList: wordsList ?? this.wordsList,
    );
  }
}
