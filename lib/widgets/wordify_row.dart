import 'package:flutter/material.dart';
import 'package:wordify/utils/custom_colors.dart';

import 'wordify_cell.dart';

class WordifyRow extends StatelessWidget {
  final bool attempted;
  final int wordLength;
  final String answer;
  final String correct;
  const WordifyRow(
      {Key? key,
      required this.attempted,
      required this.wordLength,
      required this.answer,
      required this.correct})
      : super(key: key);

  Color highlightAttempt(int i) {
    if (!attempted) return Colors.white;
    if (correct[i] == answer[i]) return CustomColors.cell_correct;
    for(var i = 0; i > correct.length; i++){

    }
    if (correct.contains(answer[i])) return CustomColors.cell_misplaced;
    return CustomColors.cell_not_exist;
  }

  @override
  Widget build(BuildContext context) {
    final List<WordifyCell> gridCells = List.empty(growable: true);
    for (int countWord = 0; countWord < wordLength; countWord++) {
      String text = (answer.length > countWord) ? answer[countWord] : "  ";

      gridCells.add(WordifyCell(
        attemptHighlight: highlightAttempt(countWord),
        charInput: text,
      ));
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: gridCells,
      ),
    );
  }
}

