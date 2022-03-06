import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordify/providers/game_state_provider.dart';
import 'package:wordify/widgets/wordify_row.dart';

class WordifyGrid extends ConsumerWidget {
  const WordifyGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateProvider);
    final List<WordifyRow> wordifyRows = List.empty(growable: true);

    for (var rowCounter = 0;
        rowCounter < gameState.settings.attemptsPerGame;
        rowCounter++) {
      var word = "";
      if (gameState.attempts.length > rowCounter) {
        word = gameState.attempts[rowCounter];
      }

      wordifyRows.add(WordifyRow(
        wordLength: gameState.settings.wordSize,
        answer: word,
        correct: gameState.correctWord,
        attempted: gameState.attemptedUpto > rowCounter,
      ));
    }

    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Column(
        children: wordifyRows,
      ),
    );
  }
}
