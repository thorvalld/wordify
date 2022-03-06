// ignore_for_file: prefer_const_declarations

import 'dart:convert';

GameDetails gameDetailsFromJson(String str) =>
    GameDetails.fromJson(json.decode(str));

String gameDetailsToJson(GameDetails data) => json.encode(data.toJson());

final String tableLocalGamesHistory = 'localgameshistory';

class GameDetailsFields {
  static final List<String> values = [
    id,
    playerName,
    playedAt,
    isWon,
    correctWord,
    guessedAt,
    wordDifficulty,
    attemptsDifficulty,
    timeToComplete
  ];

  static final String id = '_id';
  static final String playerName = "playerName";
  static final String playedAt = "playedAt";
  static final String isWon = "isWon";
  static final String correctWord = "correctWord";
  static final String guessedAt = "guessedAt";
  static final String wordDifficulty = "wordDifficulty";
  static final String attemptsDifficulty = "attemptsDifficulty";
  static final String timeToComplete = "timeToComplete";
}

class GameDetails {
  GameDetails({
    required this.id,
    required this.playerName,
    required this.playedAt,
    required this.isWon,
    required this.correctWord,
    required this.guessedAt,
    required this.wordDifficulty,
    required this.attemptsDifficulty,
    required this.timeToComplete,
  });

  int? id;
  String? playerName;
  int? playedAt;
  bool isWon;
  String? correctWord;
  int? guessedAt;
  int? wordDifficulty;
  int? attemptsDifficulty;
  int? timeToComplete;

  GameDetails copy({
    int? id,
    String? playerName,
    int? playedAt,
    bool? isWon,
    String? correctWord,
    int? guessedAt,
    int? wordDifficulty,
    int? attemptsDifficulty,
    int? timeToComplete,
  }) =>
      GameDetails(
          id: id ?? this.id,
          playerName: playerName ?? this.playerName,
          playedAt: playedAt ?? this.playedAt,
          isWon: isWon ?? this.isWon,
          correctWord: correctWord ?? this.correctWord,
          guessedAt: guessedAt ?? this.guessedAt,
          wordDifficulty: wordDifficulty ?? this.wordDifficulty,
          attemptsDifficulty: attemptsDifficulty ?? this.attemptsDifficulty,
          timeToComplete: timeToComplete ?? this.timeToComplete);

  Map<String, Object?> fieldsToJSON() => {
        GameDetailsFields.id: id,
        GameDetailsFields.playerName: playerName,
        GameDetailsFields.playedAt: playedAt,
        GameDetailsFields.isWon: isWon ? 1 : 0,
        GameDetailsFields.correctWord: correctWord,
        GameDetailsFields.guessedAt: guessedAt,
        GameDetailsFields.wordDifficulty: wordDifficulty,
        GameDetailsFields.attemptsDifficulty: attemptsDifficulty,
        GameDetailsFields.timeToComplete: timeToComplete
      };

  static GameDetails fieldsFromJSON(Map<String, Object?> json) => GameDetails(
      id: json[GameDetailsFields.id] as int?,
      playerName: json[GameDetailsFields.playerName] as String?,
      playedAt: json[GameDetailsFields.playedAt] as int?,
      isWon: json[GameDetailsFields.isWon] == 1,
      correctWord: json[GameDetailsFields.correctWord] as String?,
      guessedAt: json[GameDetailsFields.guessedAt] as int?,
      wordDifficulty: json[GameDetailsFields.wordDifficulty] as int?,
      attemptsDifficulty: json[GameDetailsFields.attemptsDifficulty] as int?,
      timeToComplete: json[GameDetailsFields.timeToComplete] as int?);

  factory GameDetails.fromJson(Map<String, dynamic> json) => GameDetails(
        id: json["id"],
        playerName: json["playerName"],
        playedAt: json["playedAt"],
        isWon: json["isWon"],
        correctWord: json["correctWord"],
        guessedAt: json["guessedAt"],
        wordDifficulty: json["wordDifficulty"],
        attemptsDifficulty: json["attemptsDifficulty"],
        timeToComplete: json["timeToComplete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "playerName": playerName,
        "playedAt": playedAt,
        "isWon": isWon,
        "correctWord": correctWord,
        "guessedAt": guessedAt,
        "wordDifficulty": wordDifficulty,
        "attemptsDifficulty": attemptsDifficulty,
        "timeToComplete": timeToComplete,
      };
}
