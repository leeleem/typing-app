import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../../theme/app_theme.dart';

class ScoreBoardWidget extends StatelessWidget {
  const ScoreBoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, _) {
        final gameState = gameProvider.gameState;
        if (gameState == null) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ScoreStat(
                label: 'Score',
                value: gameState.score.toString(),
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.grey[300],
              ),
              _ScoreStat(
                label: 'Words',
                value: gameState.totalWordsTyped.toString(),
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.grey[300],
              ),
              _ScoreStat(
                label: 'Time',
                value: _formatTime(gameState.elapsedTime),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatTime(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

class _ScoreStat extends StatelessWidget {
  final String label;
  final String value;

  const _ScoreStat({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
      ],
    );
  }
}
