import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameSettings {
  final int wordSize;
  final int attemptsPerGame;

  GameSettings({required this.wordSize, required this.attemptsPerGame});

  GameSettings cloneGame({int? wordSize, int? attemptsPerGame}) {
    return GameSettings(
        wordSize: wordSize ?? this.wordSize,
        attemptsPerGame: attemptsPerGame ?? this.attemptsPerGame);
  }
}

class GameSettingsNotifier extends StateNotifier<GameSettings> {
  GameSettingsNotifier() : super(GameSettings(wordSize: 5, attemptsPerGame: 6));
  void updateAttempts(int attempts) {
    state = state.cloneGame(attemptsPerGame: attempts);
  }

  void updateWordSize(int wordSize) {
    state = state.cloneGame(wordSize: wordSize);
  }
}

final gameSettingsProvider =
    StateNotifierProvider<GameSettingsNotifier, GameSettings>((ref) {
  return GameSettingsNotifier();
});
