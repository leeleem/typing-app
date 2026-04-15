import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../providers/score_provider.dart';
import 'game_page.dart';
import '../../theme/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.primaryColor.withOpacity(0.8),
              AppTheme.accentColor.withOpacity(0.6),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Typing Game',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Sushi-da Style',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 64),
              _DifficultyButton(
                difficulty: 1,
                label: 'Easy',
                color: Colors.green,
              ),
              const SizedBox(height: 16),
              _DifficultyButton(
                difficulty: 2,
                label: 'Normal',
                color: AppTheme.primaryColor,
              ),
              const SizedBox(height: 16),
              _DifficultyButton(
                difficulty: 3,
                label: 'Hard',
                color: AppTheme.accentColor,
              ),
              const SizedBox(height: 64),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppTheme.primaryColor,
                ),
                onPressed: () {
                  // スコア表示
                  _showHighScores(context);
                },
                child: const Text('High Scores'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showHighScores(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('High Scores'),
          content: Consumer<ScoreProvider>(
            builder: (context, scoreProvider, _) {
              if (scoreProvider.highScores.isEmpty) {
                return const Text('No scores yet');
              }
              return SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  itemCount: scoreProvider.highScores.length,
                  itemBuilder: (context, index) {
                    final score = scoreProvider.highScores[index];
                    return ListTile(
                      leading: Text('${index + 1}'),
                      title: Text('${score.points} points'),
                      subtitle: Text(
                        '${score.wordsTyped} words in ${score.playTime.inSeconds}s',
                      ),
                    );
                  },
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class _DifficultyButton extends StatelessWidget {
  final int difficulty;
  final String label;
  final Color color;

  const _DifficultyButton({
    required this.difficulty,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          context.read<GameProvider>().startGame(difficulty: difficulty);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const GamePage()),
          );
        },
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
