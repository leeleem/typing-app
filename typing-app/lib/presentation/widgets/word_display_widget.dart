import 'package:flutter/material.dart';
import '../../domain/models/word.dart';
import '../../theme/app_theme.dart';

class WordDisplayWidget extends StatelessWidget {
  final Word word;
  final String userInput;

  const WordDisplayWidget({
    Key? key,
    required this.word,
    required this.userInput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 単語の意味
        Text(
          word.meaning,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppTheme.textColor,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 32),

        // ひらがな表示と入力状況
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            word.hiragana.length,
            (index) {
              final character = word.hiragana[index];
              final isTyped = index < userInput.length;
              final isCorrect = isTyped && userInput[index] == character;

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isTyped
                      ? (isCorrect
                      ? AppTheme.successColor
                      : AppTheme.errorColor)
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  character,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isTyped ? Colors.white : AppTheme.textColor,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
