import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'package:wordify/providers/game_state_provider.dart';

class WordifyStopwatch extends ConsumerWidget {
  const WordifyStopwatch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateProvider);

    return Container(
        margin: const EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.1),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StopWatchTimer.getDisplayTime(gameState.elapsingTime),
                style: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }
}
