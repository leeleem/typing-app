import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../../domain/models/game_state.dart';
import '../widgets/word_display_widget.dart';
import '../widgets/keyboard_input_widget.dart';
import '../widgets/character_reaction_widget.dart';
import '../widgets/score_board_widget.dart';
import 'result_page.dart';
import '../../theme/app_theme.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<GameProvider>().resetGame();
        return true;
      },
      child: Scaffold(
        body: Focus(
          focusNode: _focusNode,
          onKey: (node, event) {
            final gameProvider = context.read<GameProvider>();
            final char = event.character?.toLowerCase() ?? '';
            if (char.isNotEmpty && char != ' ') {
              gameProvider.handleInput(char);
            }
            return KeyEventResult.handled;
          },
          child: Consumer<GameProvider>(
            builder: (context, gameProvider, _) {
              if (gameProvider.gameState == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final gameState = gameProvider.gameState!;

              if (gameState.status == GameStatus.finished) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ResultPage(
                        score: gameState.score,
                        wordsTyped: gameState.totalWordsTyped,
                        comboCount: gameState.comboCount,
                      ),
                    ),
                  );
                });
              }

              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.primaryColor.withOpacity(0.1),
                      AppTheme.accentColor.withOpacity(0.1),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      // スコアボード
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: ScoreBoardWidget(),
                      ),

                      // 単語表示
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: WordDisplayWidget(
                            word: gameState.currentWord,
                            userInput: gameState.userInput,
                          ),
                        ),
                      ),

                      // キャラクターリアクション
                      Expanded(
                        flex: 1,
                        child: CharacterReactionWidget(
                          comboCount: gameState.comboCount,
                        ),
                      ),

                      // キーボード入力ウィジェット
                      Expanded(
                        flex: 1,
                        child: KeyboardInputWidget(
                          onInput: (char) {
                            gameProvider.handleInput(char);
                          },
                        ),
                      ),

                      // ゲーム終了ボタン
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.errorColor,
                          ),
                          onPressed: () async {
                            await gameProvider.endGame();
                          },
                          child: const Text('End Game'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
