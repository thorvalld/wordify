import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordify/providers/game_state_provider.dart';

class WordifyKey extends ConsumerWidget {
  final String mChar;

  const WordifyKey(
    this.mChar, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: mChar == '_'
          ? const EdgeInsets.only(left: 14)
          : mChar == '<'
              ? const EdgeInsets.only(right: 14)
              : const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: InkResponse(
        radius: 16,
        onTap: () {
          ref
              .read(gameStateProvider.notifier)
              .updateCurrentAttempt(mChar, context);
        },
        child: mChar == '_'
            ? const Icon(
                CupertinoIcons.checkmark,
                size: 22,
                color: Colors.greenAccent,
              )
            : mChar == '<'
                ? const Icon(
                    CupertinoIcons.backward,
                    size: 22,
                    color: Colors.redAccent,
                  )
                : Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Text(mChar.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
      ),
    );
  }
}
