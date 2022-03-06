import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordify/core/leaderboard/leaderboard.dart';
import 'package:wordify/core/welcome.dart';
import 'package:wordify/providers/game_state_provider.dart';

import 'package:wordify/utils/custom_colors.dart';

class EndGame extends StatefulWidget {
  final bool isWin;
  final String player;
  final String timeCompleted;
  final String correctWord;
  const EndGame(
      {Key? key,
      required this.isWin,
      required this.player,
      required this.timeCompleted,
      required this.correctWord})
      : super(key: key);

  @override
  State<EndGame> createState() => _EndGameState();
}

class _EndGameState extends State<EndGame> {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(milliseconds: 3000));

  @override
  void initState() {
    _confettiController.play();
    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Path drawStar(Size size) {
    // Convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.main_bg,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 42),
                  child: widget.isWin
                      ? WinCondition(
                          isWin: widget.isWin,
                          player: widget.player,
                          timeCompleted: widget.timeCompleted,
                          correctWord: widget.correctWord,
                        )
                      : LoseCondition(
                          isWin: widget.isWin,
                          player: widget.player,
                          timeCompleted: widget.timeCompleted,
                          correctWord: widget.correctWord,
                        )),
              Visibility(
                visible: widget.isWin,
                child: Align(
                  alignment: Alignment.center,
                  child: ConfettiWidget(
                    confettiController: _confettiController,
                    blastDirectionality: BlastDirectionality
                        .explosive, // don't specify a direction, blast randomly
                    shouldLoop:
                        true, // start again as soon as the animation is finished
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple
                    ], // manually specify the colors to be used
                    createParticlePath: drawStar, // define a custom shape/path.
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class WinCondition extends StatefulWidget {
  final bool isWin;
  final String player;
  final String timeCompleted;
  final String correctWord;

  const WinCondition(
      {Key? key,
      required this.isWin,
      required this.player,
      required this.timeCompleted,
      required this.correctWord})
      : super(key: key);

  @override
  State<WinCondition> createState() => _WinConditionState();
}

class _WinConditionState extends State<WinCondition>
    with TickerProviderStateMixin {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late final AnimationController _lottieWinAnimationController;

  Future<String> fetchPlayerNamePrefs() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('player_name') ?? '';
  }

  @override
  void initState() {
    _lottieWinAnimationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _lottieWinAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const SizedBox(
          height: 42,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<String>(
                future: fetchPlayerNamePrefs(),
                builder: (context, snapshot) {
                  return Text(
                    "Impressive, ${snapshot.data}",
                    style: const TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  );
                }),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "YOU WON",
              style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 22,
        ),
        Lottie.asset(
          'assets/animations/win_animation.json',
          controller: _lottieWinAnimationController,
          fit: BoxFit.fill,
          onLoaded: (composition) {
            _lottieWinAnimationController
              ..duration = composition.duration
              ..forward();
          },
        ),
        const SizedBox(
          height: 32,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.amber.withOpacity(.1),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            enabled: false,
            title: Row(
              children: [
                const Text(
                  "Your time",
                  style: TextStyle(
                    color: Colors.amber,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.timeCompleted,
                  style: const TextStyle(
                      color: Colors.amber, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.amber.withOpacity(.1),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            enabled: false,
            title: Row(
              children: [
                const Text(
                  "Correct word",
                  style: TextStyle(
                    color: Colors.amber,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.correctWord.toUpperCase(),
                  style: const TextStyle(
                      color: Colors.amber, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 42,
        ),
        const EndgameBtnRow()
      ],
    ));
  }
}

class LoseCondition extends StatefulWidget {
  final bool isWin;
  final String player;
  final String timeCompleted;
  final String correctWord;

  const LoseCondition(
      {Key? key,
      required this.isWin,
      required this.player,
      required this.timeCompleted,
      required this.correctWord})
      : super(key: key);

  @override
  State<LoseCondition> createState() => _LoseConditionState();
}

class _LoseConditionState extends State<LoseCondition>
    with TickerProviderStateMixin {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late final AnimationController _lottieLoseAnimationController;

  Future<String> fetchPlayerNamePrefs() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('player_name') ?? '';
  }

  @override
  void initState() {
    _lottieLoseAnimationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _lottieLoseAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      const SizedBox(
        height: 42,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<String>(
              future: fetchPlayerNamePrefs(),
              builder: (context, snapshot) {
                return Text(
                  "Ha Ha, ${snapshot.data}",
                  style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.w300),
                );
              }),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "YOU LOST",
            style: TextStyle(
                color: Colors.redAccent,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      const SizedBox(
        height: 22,
      ),
      Lottie.asset(
        'assets/animations/lose_animation.json',
        controller: _lottieLoseAnimationController,
        fit: BoxFit.fill,
        onLoaded: (composition) {
          _lottieLoseAnimationController
            ..duration = composition.duration
            ..forward();
        },
      ),
      const SizedBox(
        height: 32,
      ),
      Container(
        decoration: BoxDecoration(
            color: Colors.amber.withOpacity(.1),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: ListTile(
          enabled: false,
          title: Row(
            children: [
              const Text(
                "Your time",
                style: TextStyle(
                  color: Colors.amber,
                ),
              ),
              const Spacer(),
              Text(
                widget.timeCompleted,
                style: const TextStyle(
                    color: Colors.amber, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 16,
      ),
      Container(
        decoration: BoxDecoration(
            color: Colors.amber.withOpacity(.1),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: ListTile(
          enabled: false,
          title: Row(
            children: [
              const Text(
                "Correct word",
                style: TextStyle(
                  color: Colors.amber,
                ),
              ),
              const Spacer(),
              Text(
                widget.correctWord.toUpperCase(),
                style: const TextStyle(
                    color: Colors.amber, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 42,
      ),
      const EndgameBtnRow(),
    ]));
  }
}

class EndgameBtnRow extends ConsumerWidget {
  const EndgameBtnRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameStateNotifier = ref.watch(gameStateProvider.notifier);
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: CupertinoButton(
              child: const Icon(
                CupertinoIcons.chart_bar,
                color: Colors.amber,
              ),
              onPressed: () {
                gameStateNotifier.haltStopwatch();
                Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const Leaderboard(
                              from: 1,
                            )));
              }),
        ),
        const SizedBox(
          width: 3,
        ),
        Expanded(
          flex: 3,
          child: CupertinoButton(
              color: Colors.amber,
              child: Text(
                "HOME",
                style: TextStyle(color: CustomColors.main_bg),
              ),
              onPressed: () {
                gameStateNotifier.haltStopwatch();
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: (context) => WelcomeScreen()));
              }),
        ),
      ],
    );
  }
}
