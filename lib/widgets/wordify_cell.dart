import 'package:flutter/material.dart';

class WordifyCell extends StatelessWidget {
  final String charInput;
  final Color attemptHighlight;

  const WordifyCell(
      {Key? key, required this.charInput, required this.attemptHighlight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: 42,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: .6,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(3))),
      child: Center(
        child: Text(
          charInput.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: attemptHighlight),
        ),
      ),
    );
  }
}
