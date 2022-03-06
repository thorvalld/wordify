import 'package:flutter/material.dart';
import 'package:wordify/models/game.dart';
import 'package:wordify/widgets/history_card.dart';

class LeaderboardLocal extends StatefulWidget {
  const LeaderboardLocal({Key? key}) : super(key: key);

  @override
  _LeaderboardLocalState createState() => _LeaderboardLocalState();
}

class _LeaderboardLocalState extends State<LeaderboardLocal> {
  final dummyGames = [
    GameDetails(
        id: 1,
        playerName: "Thorvalld",
        playedAt: DateTime.now().millisecondsSinceEpoch,
        isWon: true,
        correctWord: "today",
        guessedAt: 3,
        wordDifficulty: 5,
        attemptsDifficulty: 4,
        timeToComplete: 8500),
    GameDetails(
        id: 2,
        playerName: "Thorvalld",
        playedAt: DateTime.now().millisecondsSinceEpoch,
        isWon: true,
        correctWord: "globe",
        guessedAt: 2,
        wordDifficulty: 5,
        attemptsDifficulty: 6,
        timeToComplete: 4600),
    GameDetails(
        id: 3,
        playerName: "Player 3",
        playedAt: DateTime.now().millisecondsSinceEpoch,
        isWon: false,
        correctWord: "palace",
        guessedAt: 6,
        wordDifficulty: 6,
        attemptsDifficulty: 5,
        timeToComplete: 12500)
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: dummyGames.length,
        itemBuilder: (BuildContext builder, int index) {
          return HistoryCard(
            gameDetails: dummyGames[index],
          );
        });
  }
}
