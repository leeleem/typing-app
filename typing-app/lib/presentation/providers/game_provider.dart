import 'package:flutter/foundation.dart';
import '../../domain/models/word.dart';
import '../../domain/models/game_state.dart';
import '../../services/game_service.dart';
import '../../data/datasources/word_datasource.dart';
import '../../data/repositories/word_repository_impl.dart';

class GameProvider extends ChangeNotifier {
  late GameService _gameService;
  GameState? _gameState;

  int _currentDifficulty = 1;
  String _currentGameDifficulty = 'normal';

  GameState? get gameState => _gameState;
  int get currentDifficulty => _currentDifficulty;

  GameProvider() {
    _initializeGameService();
  }

  void _initializeGameService() {
    final wordDataSource = WordDataSourceImpl();
    final wordRepository = WordRepositoryImpl(wordDataSource);

    _gameService = GameService(
      wordRepository: wordRepository,
      scoreRepository: throw UnimplementedError(),
    );
  }

  Future<void> startGame({required int difficulty}) async {
    _currentDifficulty = difficulty;

    // 最初の単語を取得
    final firstWord =
        await _gameService.wordRepository.getRandomWord(difficulty: difficulty);

    if (firstWord != null) {
      _gameState = GameState(
        status: GameStatus.playing,
        currentWord: firstWord,
        userInput: '',
        score: 0,
        comboCount: 0,
        totalWordsTyped: 0,
        elapsedTime: Duration.zero,
        wordsList: [],
      );

      _gameService.startTimer((_) {
        notifyListeners();
      });

      notifyListeners();
    }
  }

  Future<void> handleInput(String character) async {
    if (_gameState == null ||
        _gameState!.status != GameStatus.playing) {
      return;
    }

    String newInput = _gameState!.userInput + character;

    // 入力が一致するかチェック
    if (_gameService.validateInput(newInput, _gameState!.currentWord)) {
      // 正解！
      int baseScore = _gameService.calculateScore(
        _gameState!.currentWord,
        _gameState!.elapsedTime,
      );
      int comboBonus = _gameService.calculateComboBonus(
        _gameState!.comboCount + 1,
        baseScore,
      );
      int totalScore = baseScore + comboBonus;

      // 次の単語を取得
      final nextWord =
          await _gameService.wordRepository.getRandomWord(
        difficulty: _currentDifficulty,
      );

      if (nextWord != null) {
        _gameState = _gameState!.copyWith(
          currentWord: nextWord,
          userInput: '',
          score: _gameState!.score + totalScore,
          comboCount: _gameState!.comboCount + 1,
          totalWordsTyped: _gameState!.totalWordsTyped + 1,
        );
      }
    } else if (!_gameState!.currentWord.hiragana.startsWith(newInput)) {
      // 入力がマッチしなくなったのでリセット
      newInput = '';
    }

    _gameState = _gameState!.copyWith(userInput: newInput);
    notifyListeners();
  }

  void pauseGame() {
    if (_gameState != null) {
      _gameService.stopTimer();
      _gameState = _gameState!.copyWith(
        status: GameStatus.paused,
      );
      notifyListeners();
    }
  }

  void resumeGame() {
    if (_gameState != null) {
      _gameService.startTimer((_) {
        notifyListeners();
      });
      _gameState = _gameState!.copyWith(
        status: GameStatus.playing,
      );
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    if (_gameState == null) return;

    _gameService.stopTimer();
    _gameState = _gameState!.copyWith(
      status: GameStatus.finished,
    );
    notifyListeners();
  }

  void resetGame() {
    _gameService.dispose();
    _initializeGameService();
    _gameState = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _gameService.dispose();
    super.dispose();
  }
}
