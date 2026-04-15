import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/game_provider.dart';
import 'presentation/providers/score_provider.dart';
import 'presentation/pages/home_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const TypingApp());
}

class TypingApp extends StatelessWidget {
  const TypingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameProvider()),
        ChangeNotifierProvider(create: (_) => ScoreProvider()),
      ],
      child: MaterialApp(
        title: 'Typing Game - Sushi-da Style',
        theme: AppTheme.lightTheme,
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
