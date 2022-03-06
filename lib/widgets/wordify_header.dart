import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordify/core/other/help.dart';
import 'package:wordify/providers/game_state_provider.dart';
import 'package:wordify/utils/custom_colors.dart';

import 'wordify_stopwatch.dart';

class WordifyHeader extends ConsumerWidget {
  const WordifyHeader({Key? key}) : super(key: key);

  void triggerBottomSheet(
      WidgetRef ref, BuildContext context, String title, String btnTxt) {
    final gameStateNotifier = ref.watch(gameStateProvider.notifier);
    showModalBottomSheet(
        backgroundColor: CustomColors.main_bg,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        )),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                trailing: InkResponse(
                  radius: 16,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    CupertinoIcons.xmark,
                    color: Colors.amber,
                    size: 16,
                  ),
                ),
                title: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SafeArea(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoButton(
                            color: Colors.amber.withOpacity(.2),
                            child: Text(
                              btnTxt,
                              style: TextStyle(color: Colors.amber.shade900),
                            ),
                            onPressed: () {
                              //gameStateNotifier.gameOutcome(false);
                              //gameStateNotifier.gameStreak(false);
                              if (btnTxt == 'restart') {
                                gameStateNotifier
                                    .terminateGame()
                                    .then((_) => gameStateNotifier.resetWord())
                                    .then((_) => Navigator.pop(context));
                              } else {
                                gameStateNotifier
                                    .terminateGame()
                                    .then((_) =>
                                        gameStateNotifier.restartStopwatch())
                                    .then((_) => Navigator.pop(context))
                                    .then((_) => Navigator.of(context).pop())
                                    .then((_) => Timer(
                                            const Duration(milliseconds: 1500),
                                            () {
                                          gameStateNotifier.resetWord();
                                        }));
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final gameStateNotifier = ref.watch(gameStateProvider.notifier);
    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      margin: const EdgeInsets.only(bottom: 32),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    triggerBottomSheet(
                        ref, context, 'Quit game and lose progress?', 'quit');
                  },
                  tooltip: "home",
                  splashRadius: 18,
                  icon: const Icon(
                    CupertinoIcons.home,
                    size: 22,
                    color: Colors.amber,
                  )),
              const SizedBox(
                width: 5,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Wordify',
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 26,
                    ),
                    speed: const Duration(milliseconds: 1000),
                    colors: [
                      Colors.amber.shade50,
                      Colors.amber.shade100,
                      Colors.amber.shade200,
                      Colors.amber.shade300,
                      Colors.amber.shade400,
                      Colors.amber.shade300,
                      Colors.amber.shade200,
                      Colors.amber.shade100,
                      Colors.amber.shade50,
                    ],
                  ),
                ],
                isRepeatingAnimation: false,
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    triggerBottomSheet(ref, context,
                        'Restart game and lose progress?', 'restart');
                  },
                  splashRadius: 18,
                  tooltip: "restart",
                  icon: const Icon(
                    CupertinoIcons.refresh_bold,
                    size: 22,
                    color: Colors.amber,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => const HelpScreen(),
                      ),
                    );
                  },
                  tooltip: "help",
                  splashRadius: 18,
                  icon: const Icon(
                    CupertinoIcons.info_circle,
                    size: 22,
                    color: Colors.amber,
                  )),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const WordifyStopwatch(),
        ],
      ),
    );
  }
}
