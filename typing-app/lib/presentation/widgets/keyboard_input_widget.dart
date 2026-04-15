import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class KeyboardInputWidget extends StatelessWidget {
  final Function(String) onInput;

  const KeyboardInputWidget({
    Key? key,
    required this.onInput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final keys = ['あいうえお', 'かきくけこ', 'さしすせそ', 'たちつてと', 'なにぬねの'];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: keys
              .map(
                (row) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: row.split('').map(
                          (char) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryColor,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 12,
                                ),
                              ),
                              onPressed: () => onInput(char),
                              child: Text(
                                char,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ).toList(),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
