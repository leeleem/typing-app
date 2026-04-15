import 'package:flutter/material.dart';

class CharacterReactionWidget extends StatelessWidget {
  final int comboCount;

  const CharacterReactionWidget({
    Key? key,
    required this.comboCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String reaction = '😊';
    String message = 'Good luck!';

    if (comboCount >= 5 && comboCount < 10) {
      reaction = '😄';
      message = 'Great combo!';
    } else if (comboCount >= 10 && comboCount < 20) {
      reaction = '🤩';
      message = 'Amazing!';
    } else if (comboCount >= 20) {
      reaction = '🔥';
      message = 'Incredible!';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            reaction,
            style: const TextStyle(fontSize: 80),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (comboCount > 0)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Combo: $comboCount',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
