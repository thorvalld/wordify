import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:wordify/core/game/endgame.dart';
import 'package:wordify/data/wordify_repo.dart';
import 'package:wordify/providers/settings_provider.dart';
import 'package:wordify/widgets/wordify_toasts.dart';

enum GameStatus { loading, started, win, lose }
enum AppLang { en, fr, de, no, se, dk }
enum WordLang { en, fr, de, no, se, dk }

class WrongWordLengthException implements Exception {
  int correctLength;

  WrongWordLengthException(this.correctLength);

  @override
  String toString() {
    return "Answer is of wrong length.";
  }
}

class GameState {
  final GameSettings settings;
  final GameStatus gameStatus;
  final String correctWord;
  late final List<String> words;
  late final List<String> attempts;
  int attemptedUpto;
  int timeToComplete;
  int elapsingTime;
  //bool isDisplayMsgVisible;

  GameState(
    this.settings, {
    this.correctWord = "begin",
    this.gameStatus = GameStatus.loading,
    this.attemptedUpto = 0,
    this.timeToComplete = 0,
    this.elapsingTime = 0,
    //this.isDisplayMsgVisible = false,
    List<String>? words,
    List<String>? attempts,
  }) {
    this.attempts = attempts ?? List.empty();
    this.words = words ?? List.empty();
  }

  GameState.update(GameState old,
      {GameStatus? gameStatus,
      String? correctWord,
      List<String>? words,
      int? attemptedUpto,
      int? timeToComplete,
      int? elapsingTime,
      bool? isDisplayMsgVisible,
      List<String>? attempts})
      : this(
          old.settings,
          correctWord: correctWord ?? old.correctWord,
          gameStatus: gameStatus ?? old.gameStatus,
          words: words ?? old.words,
          attemptedUpto: attemptedUpto ?? old.attemptedUpto,
          timeToComplete: timeToComplete ?? old.timeToComplete,
          elapsingTime: elapsingTime ?? old.elapsingTime,
          attempts: attempts ?? old.attempts,
        );
}

class GameStateNotifier extends StateNotifier<GameState> {
  final Random rand = Random();
  final StopWatchTimer _stopWatchTimer =
      StopWatchTimer(mode: StopWatchMode.countUp);
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  GameStateNotifier(GameSettings settings) : super(GameState(settings));

  Future<void> gamePlayed() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('games_played') ?? 0) + 1;
    prefs.setInt('games_played', counter);
  }

  Future<void> gameOutcome(bool isWin) async {
    final SharedPreferences prefs = await _prefs;
    if (isWin) {
      final int counter = (prefs.getInt('games_won') ?? 0) + 1;
      prefs.setInt('games_won', counter);
      prefs.setBool('last_played_is_win', true);
    } else {
      final int counter = (prefs.getInt('games_lost') ?? 0) + 1;
      prefs.setInt('games_lost', counter);
      prefs.setBool('last_played_is_win', false);
    }

    calculateStreaks(isWin, (prefs.getInt('current_streak') ?? 0),
        (prefs.getInt('best_streak') ?? 0));
    gamePlayed().then((_) => calculateWinRate());
  }

  Future<void> calculateStreaks(bool isGameWon, int currentS, int bestS) async {
    final SharedPreferences prefs = await _prefs;
    if (isGameWon) {
      int temp1 = currentS++;
      if (currentS > bestS) {
        int temp2 = currentS;
        // shared prefs <- best streak
        prefs.setInt('best_streak', temp2);
      }
      // shared prefs <- current streak
      prefs.setInt('current_streak', temp1);
    } else {
      if (currentS > bestS) {
        int temp3 = currentS;
        // shared prefs <- best streak
        prefs.setInt('best_streak', temp3);
      }
      // shared prefs <- current streak
      prefs.setInt('current_streak', 0);
    }
  }

  Future<void> calculateWinRate() async {
    final SharedPreferences prefs = await _prefs;
    final int gWon = (prefs.getInt('games_won') ?? 0);
    final int totalPlayed = (prefs.getInt('games_played') ?? 0);
    if (totalPlayed != 0) {
      final double wr = (gWon) / (totalPlayed) * 100;
      prefs.setDouble('win_rate', wr);
    }
  }

  Future calculateAllTimeBest(int newVal) async {
    final SharedPreferences prefs = await _prefs;
    final int oldVal = prefs.getInt('all_time_best_int') ?? -1;
    if (oldVal == -1) {
      String res = '${fromRawMillisToTime(newVal)} sec';
      prefs.setString('all_time_best_str', res);
      prefs.setInt('all_time_best_int', newVal);
    } else {
      if (oldVal > newVal) {
        String res = '${fromRawMillisToTime(newVal)} sec';
        prefs.setString('all_time_best_str', res);
        prefs.setInt('all_time_best_int', newVal);
      }
    }
  }

  Future<void> calculateLast5Best(int newVal) async {
    final SharedPreferences prefs = await _prefs;
    List<String> defaultArr = ["0", "0", "0", "0", "0"];
    final List<String> last5Arr =
        (prefs.getStringList('last_5_games') ?? defaultArr);
    for (var i = 0; i < last5Arr.length; i++) {
      if (newVal > int.parse(last5Arr[i])) {
        prefs.setString('last_5_games', "$newVal");
      }
    }
  }

  Future<void> resetWord() async {
    final useOldWords = (state.correctWord.length == state.settings.wordSize) &&
        state.words.isNotEmpty;
    final words =
        useOldWords ? state.words : await loadWords(state.settings.wordSize);
    state = GameState.update(state,
        attempts: List.empty(),
        words: words,
        attemptedUpto: 0,
        elapsingTime: 0,
        correctWord: words[rand.nextInt(words.length)],
        gameStatus: GameStatus.started);
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    _stopWatchTimer.rawTime.listen(
        (value) => state = GameState.update(state, elapsingTime: value));
  }

  Future<void> haltStopwatch() async {
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    state = GameState.update(state,
        elapsingTime: 0, timeToComplete: state.timeToComplete);
  }

  Future<void> terminateGame() async {
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    state = GameState.update(
      state,
      elapsingTime: 0,
      timeToComplete: state.timeToComplete,
      gameStatus: GameStatus.lose,
      attemptedUpto: 0,
      attempts: List.empty(),
    );
    gameOutcome(false);
  }

  Future<void> restartStopwatch() async {
    _stopWatchTimer.setPresetTime(mSec: 0);
  }

  String fromRawMillisToTime(int millis) {
    final displayTime = StopWatchTimer.getDisplayTime(
        _stopWatchTimer.rawTime.value,
        minuteRightBreak: ' min & ',
        milliSecond: false,
        second: true,
        minute: true,
        hours: false);
    return displayTime;
  }

  bool isDisplayMsgVisible = false;

  void updateCurrentAttempt(String character, BuildContext c) {
    List<String> attempts = List.from(state.attempts, growable: true);

    if (state.attempts.length == state.attemptedUpto) {
      attempts.add("");
    }

    if (character == "_") {
      print(state.correctWord);
      //ENTER
      if (attempts[state.attemptedUpto].length != state.correctWord.length) {
        //state.isDisplayMsgVisible = true;

        //state = GameState.update(state, isDisplayMsgVisible: true);

        ScaffoldMessenger.of(c).showSnackBar(SnackBar(
            elevation: 3,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
            duration: const Duration(milliseconds: 2000),
            content: Row(
              children: const [
                Icon(
                  CupertinoIcons.textformat_size,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("word too short")
              ],
            )));
      } else {
        attemptAnswer(attempts[state.attemptedUpto], c);
      }
      return;
    } else if (character == "<") {
      //DEL
      int splitTo = attempts[state.attemptedUpto].length - 1;
      if (splitTo < 0) {
        splitTo = 0;
      }
      attempts[state.attemptedUpto] =
          attempts[state.attemptedUpto].substring(0, splitTo);
    } else {
      //CHAR
      if (attempts[state.attemptedUpto].length >= state.correctWord.length) {
        //no more letters possible
        ScaffoldMessenger.of(c).showSnackBar(SnackBar(
            elevation: 3,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
            duration: const Duration(milliseconds: 2000),
            content: Row(
              children: const [
                Icon(
                  CupertinoIcons.textformat_size,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("nothing to delete")
              ],
            )));
      } else {
        attempts[state.attemptedUpto] += character;
      }
    }
    state = GameState.update(
      state,
      attempts: attempts,
    );
  }

  void attemptAnswer(String answer, BuildContext c) {
    if (answer.length != state.correctWord.length) {
      throw WrongWordLengthException(state.correctWord.length);
    } else if (!state.words.contains(answer)) {
      //state.isDisplayMsgVisible = true;
      state = GameState.update(state, isDisplayMsgVisible: true);
      ScaffoldMessenger.of(c).showSnackBar(SnackBar(
          elevation: 3,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
          duration: const Duration(milliseconds: 2000),
          content: Row(
            children: const [
              Icon(
                CupertinoIcons.textformat_size,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text("word does not exist in dictionary")
            ],
          )));
      return;
    }
    //WIN CONDITION
    if (state.correctWord == answer &&
        state.attempts.length <= state.settings.attemptsPerGame) {
      state = GameState.update(state,
          gameStatus: GameStatus.win,
          attemptedUpto: 0,
          attempts: List.empty(),
          timeToComplete: _stopWatchTimer.rawTime.value, //state.timeToComplete,
          elapsingTime: 0);
      gameOutcome(true);
      calculateAllTimeBest(state.timeToComplete);
      Navigator.pushReplacement(
          c,
          CupertinoPageRoute(
              builder: (c) => EndGame(
                  isWin: true,
                  player: "player",
                  timeCompleted:
                      '${fromRawMillisToTime(state.timeToComplete)} sec',
                  correctWord: state.correctWord))).then(
          (value) => {calculateAllTimeBest(state.timeToComplete), resetWord()});

      return;
    }
    //LOSE CONDITION
    if (state.correctWord != answer &&
        state.attempts.length == state.settings.attemptsPerGame) {
      state = GameState.update(state,
          gameStatus: GameStatus.lose,
          attemptedUpto: 0,
          attempts: List.empty(),
          timeToComplete: state.timeToComplete,
          elapsingTime: 0);
      gameOutcome(false);
      state = GameState.update(state,
          timeToComplete: _stopWatchTimer.rawTime.value);
      Navigator.pushReplacement(
              c,
              CupertinoPageRoute(
                  builder: (c) => EndGame(
                      isWin: false,
                      player: "player",
                      timeCompleted:
                          '${fromRawMillisToTime(state.timeToComplete)} sec',
                      correctWord: state.correctWord)))
          .then((value) => resetWord());

      return;
    }

    state = GameState.update(state, attemptedUpto: state.attemptedUpto + 1);
  }
}

final gameStateProvider =
    StateNotifierProvider<GameStateNotifier, GameState>((ref) {
  final gameSettings = ref.watch(gameSettingsProvider);
  final notifier = GameStateNotifier(gameSettings);
  notifier.resetWord();
  return notifier;
});
