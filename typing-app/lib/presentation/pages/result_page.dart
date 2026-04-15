import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../providers/score_provider.dart';
import 'home_page.dart';
import '../../theme/app_theme.dart';

class ResultPage extends StatefulWidget {
  final int score;
  final int wordsTyped;
  final int comboCount;

  const ResultPage({
    Key? key,
    required this.score,
    required this.wordsTyped,
    required this.comboCount,
  }) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ScoreProvider>().refreshScores();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<GameProvider>().resetGame();
        return true;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.successColor.withOpacity(0.8),
                AppTheme.primaryColor.withOpacity(0.6),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 80,
                ),
                const SizedBox(height: 32),
                Text(
                  'Game Over!',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 48,
                  ),
                ),
                const SizedBox(height: 48),
                _ResultCard(
                  label: 'Total Score',
                  value: widget.score.toString(),
                ),
                const SizedBox(height: 16),
                _ResultCard(
                  label: 'Words Typed',
                  value: widget.wordsTyped.toString(),
                ),
                const SizedBox(height: 16),
                _ResultCard(
                  label: 'Max Combo',
                  value: widget.comboCount.toString(),
                ),
                const SizedBox(height: 64),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppTheme.primaryColor,
                      ),
                      onPressed: () {
                        context.read<GameProvider>().resetGame();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const HomePage()),
                          (route) => false,
                        );
                      },
                      child: const Text('Back to Home'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final String label;
  final String value;

  const _ResultCard({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
