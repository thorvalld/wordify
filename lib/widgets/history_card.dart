import 'package:flutter/material.dart';
import 'package:wordify/models/game.dart';
import 'package:wordify/utils/custom_colors.dart';

class HistoryCard extends StatelessWidget {
  final GameDetails gameDetails;
  const HistoryCard({Key? key, required this.gameDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String datePlayed =
        DateTime.fromMillisecondsSinceEpoch(gameDetails.playedAt!)
            .toIso8601String();
    return Card(
      elevation: 4,
      color: CustomColors.main_bg,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(10),
      )),
      child: Column(
        children: [
          ListTile(
            title: Text(
              "${gameDetails.playerName}",
              style: const TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
            subtitle: Row(
              children: [
                Text(
                  datePlayed,
                  style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 10,
                      color: Colors.white60),
                ),
                const Spacer(),
                Text(
                  gameDetails.isWon == true ? 'WON' : 'LOST',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: gameDetails.isWon == true
                          ? Colors.greenAccent
                          : Colors.redAccent),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
